
function [dv_tot] = deltaV(dRAAN,a1,a2,di,v1,v2,i1,i2)
    
    % dRAAN                   [rad]     raan difference between start and end orbit
    % a1                      [Km]      semimajor axis of the first orbit
    % a2                      [Km]      semimajor axis of the second orbit
    % v1                      [Km/s]    velocity in the first orbit
    % v2                      [Km/s]    velocity in the second orbit
    %i1                       [deg]     inclination of the orbit in which
    %                                   you are
    
    
    
    mu = 3.869e5; %[Km^3/s^2]         Gravitational constant of the Earth
    
   %we decide to change raan always when the velocity is the lowest
   %possible. This is a choice that we can easily make since no other
   %calculation are affected by this choice. Instead, this way of
   %manuoevring is always the optimal
    
   
   if v1>=v2 && i1>=i2
      dv_sm = abs(sqrt(mu/a1) - sqrt(mu/a2));                  %first step you change speed from a lower to a higher orbit
      dv_inc = v2*sqrt(2-2*cosd((pi/2)*di*pi/180));            %the second step is change in inclinatio to obtain the minum dvRAAN
      dv_RAAN = (pi/2)*sqrt(mu/a1)*abs(pi*dRAAN/180)*sind(i2); %the third id the change in RAAN
   
   elseif v1>=v2 && i1<=i2
       dv_sm = abs(sqrt(mu/a1) - sqrt(mu/a2));    %first step you change speed from a lower to a higher orbit
       dv_RAAN = (pi/2)*sqrt(mu/a1)*abs(pi*dRAAN/180)*sind(i1); %the second step you change in RAAN at the same inclination
       dv_inc = v2*sqrt(2-2*cosd((pi/2)*di*pi/180)); %third step you change in inclination
   
   elseif v2>=v1  && i1>=i2
       
        dv_RAAN = (pi/2)*sqrt(mu/a1)*abs(pi*dRAAN/180)*sind(i1); %the first step youchange in RAAN
        dv_inc = v1*sqrt(2-2*cosd((pi/2)*di*pi/180)); %second dtep you change in inclination
        dv_sm = abs(sqrt(mu/a1) - sqrt(mu/a2));    %third step you change speed from a lower to a higher orbit
   
   elseif v2>=v1 &&  i1<=i2
       
       dv_inc = v1*sqrt(2-2*cosd((pi/2)*di*pi/180)); %first step you change in inclination
       dv_RAAN = (pi/2)*sqrt(mu/a1)*abs(pi*dRAAN/180)*sind(i1); %the secxond step you change in RAAN
       dv_sm = abs(sqrt(mu/a1) - sqrt(mu/a2));    %third step you change speed from a lower to a higher orbit
   end

   dv_tot=dv_inc+dv_RAAN+dv_sm;
   
end