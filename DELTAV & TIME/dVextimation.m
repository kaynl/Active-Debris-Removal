
function [v_evolution,poss,mass_t,mass_prop]=dVextimation(target,m_tot,Isp)

%this function will give you out all the possible combination of dv needed
%to reach the targets specified in the structure 'target'. The code
%commented gives you the specifications about the target structure format

%-----input-----%

% target           a structure as defined below
% m_tot            total initial mass of your spacecraft
% Isp              specific impulse of your engine

%----output----%

% poss             % matrix with all the possible permutations of the target

% v_evolutio       % dv required for any step and the last colum is the sum of the
                   % previous ones

% mass_t           % evolution of the mass over time. the first mass
                   % considered is always the mass of the spacecraft minus the mass of foam
                   % needed for the first target. The end mass

                   
% the lines of the v_evolution and poss are matched  so that 
% each combination has the corrisponding dv consumption in the same row                
                  
%----How to compile the structure----%                 
                  
                  
% target.per(1)=753+6371;                                   %[km] perigee absolute altitude
% target.api(1)=768+6371;                                   %[km]  apogee absolute altitude
% target.raan(1)=327;                                       %[deg] the radiant change is in the functions
% target.inc(1)=98.45;                                      %[deg] inclination
% target.semi(1)=(target.api(1)+target.per(1))/2;           %[km] semimajor axis
% target.vel(1)=sqrt(2*mu/target.api(1)-mu/target.semi(1));  %[km/s] velocity considering circular orbit
% target.mass(1)=1764;                                      %[kg]  mass
% target.cfoam(1)=0.2;                                       %foam mass coefficient

 
%---Constants----%

g=9.81*10^-3;            %  [Km/s^2]
mu=3.98*10^5;            %[Km^3/s^2]
                 
%---definition of the parameters---%

in=[1:length(target.api)];                

poss=perms(in);                               % all the possible permutations of n targets

[r,~]=size(poss);

v_evolution=zeros(r,length(target.api));     %this vector will contain all the dv for any
                                             %passage and a total dV at the last column
                                             

mass_t=zeros(r,length(target.api));           %[kg] mass of the spacecraft in time. the first is the total mass at 
                                              %     the start of the mission and
                                              %     at the end you have the end mass.
                                              %     In the first orbit you
                                              %     already eject the foam
                                              %     even if you don't use
                                              %     the propellant mass
                                              %     since the rocket
                                              %     directs
                                              %     you in orbit



for k=1:r
    mass_t(k,1)=m_tot-target.mass(poss(k,1))*target.cfoam(poss(k,1));
end
mass_t;
% the starting mass is the mass of the spacecraft withouth the foam mass of
% thge first object
mass_prop=zeros(r,length(target.api)-1);       %[kg] mass of the propellant at each jump. I have n-1 jumps for n targets

for count=1:r
    
    index=poss(count,:);

    for i=1:length(index)-1 % we have n-1 passages for n targets      
      
      draan=abs(target.raan(index(i))-target.raan(index(i+1)));
      di=abs(target.inc(index(i))-target.inc(index(i+1)));
      v_evolution(count,i)=deltaV(draan,target.semi(index(i)),target.semi(index(i+1)),di,target.vel(index(i)),target.vel(index(i+1)),target.inc(index(i)),target.inc(index(i+1)));
      size(v_evolution)
      % this function gives the total dv for the full manouevre from one
      % target to the other. During this manouvre the mass is considered
      % constant.This is a first approximation
      
 
      mass_prop(count,i)=(exp(v_evolution(count,i)/(Isp*g))-1)/exp(v_evolution(count,i)/(Isp*g))*mass_t(count,i);
      
      
      mass_t(count,i+1)=mass_t(count,i)-mass_prop(count,i)-target.mass(poss(i+1))*target.cfoam(i);
      
      % I take out the mass of propellant for this change in orbit and the
      % mass of foam needed for the target in the successive orbit
      
    end
      v_evolution(count,end)=sum(v_evolution(count,:)); % the last elemnt in the row is zero always

    
end

mass_prop;




end





    
    
        
    
    













