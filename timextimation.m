%%% this scripts evaluate the time required to accomplish a ADR of four
%%% rocket stages. The cange in mass is taken into account at the end of
%%% each jump. During the manouevres we mantain the mass as constant

function  [mass_t,mass_prop,sequence,Dt,v_evolution,the_winners_prop_mass]=timextimation(target)

clf
close all


%---Thruster motor definition and starting mass of the satellite-----%

mu=3.98*10^5;         %[Km^3/s^2]
th_motor=298*10^-3;   %[N]   thrust given by one single engine
mass0=1200;           %[Kg]  starting mass of the spacecraft
Nen=1;                %      number of engine
Isp=2770;             %[s]   specific impulse
th=th_motor*Nen;%[N]

%--------------------------------------------------------------------%


%---Dv evaluation---%


[v_evolution,poss,mass_t,mass_prop]=dVextimation(target,mass0,Isp);


%-------------------%

[r,c]=size(poss);
Dt=zeros(size(poss)) ;  %for c targets you have c-1 steps to reach all of them
 
 % in this vector you have r rows for each possibility
 % you have c-1 colums for each jump from one orbit to the other and the
 % last is the sume of the time interval per jump
 %the first orbit is rea ched with the sounding rocket


%  some assumption first:

%  1 during the trajectory the mass is not changing since the electtric
%  motors eject very low level of mass. the mass changes only between two
%  different steps when the foam is going to be put on the stellite.

%  2 the acceleration is assumed constant as the thrust.

for i=1:r
    for j=1:c-1
        a=th/mass_t(i,j)*10^-3;              %[km/s^2]           
        Dt(i,j)=v_evolution(i,j)/a;          %[s]
    end
end
%--------de-orbit phase of the spacecraft-----------%

last_dv=zeros(r,1);

for i=1:r
last_dv(i) = abs(sqrt(mu/target.semi(poss(i,end))-sqrt(mu/(250+6371))));
end

last_dv;


k=60*60*24*365;
total_time=sum(Dt,2);                %[s]
total_time=total_time/k;             %[years]
total_dv=v_evolution(:,end);          %[Km/s]
total_prop_mass=sum(mass_prop,2);     %[Kg]


sequence=poss;

for i=1:length(target.api)
sequence(:,i)=sequence(:,i)*10^(length(target.api)-i);
end

sequence=sum(sequence,2);


%------ finding out only the "one year" solutions-----%

deadline=0.7;        %[years]  %PUT THE MARGIN THAT YOU WANT
                     
the_winners_seq=sequence(total_time<deadline);

the_winners_time=total_time(total_time<deadline);

the_winners_dv=total_dv(total_time<deadline);

the_winners_prop_mass=total_prop_mass(total_time<deadline);

the_winners_range=1:length(the_winners_seq);                    


%-----solutions that not match the tyotal fuel consumprion--------%

the_winners_mass_over_ind=the_winners_range(the_winners_prop_mass>200);
the_winners_time_over=the_winners_time(the_winners_prop_mass>200);
the_winners_dv_over=the_winners_dv(the_winners_prop_mass>200);
the_winners_mass_over=the_winners_prop_mass(the_winners_prop_mass>200);

exclude=Dt(mass_prop(:,end)>200);



%------for plotting the numbers in the axis ----%



axplot=cell(1,length(the_winners_seq));

for i=1:length(the_winners_seq)
    axplot{i}=num2str(the_winners_seq(i));
end

length(axplot)

%-----------------------------------------------%
format short

mindv=round(the_winners_dv(the_winners_dv==min(the_winners_dv)),2);
mindv_time=the_winners_time(the_winners_dv==min(the_winners_dv));
mindv_prop_mass=the_winners_prop_mass(the_winners_dv==min(the_winners_dv));



mintime=the_winners_time(the_winners_time==min(the_winners_time));
mintime_dv=the_winners_dv(the_winners_time==min(the_winners_time));
mintime_prop_mass=the_winners_prop_mass(the_winners_time==min(the_winners_time));









%------------------------------------------------%
figure(1)

scatter(the_winners_range,the_winners_time,'b','LineWidth',3)
hold on
scatter(the_winners_mass_over_ind,the_winners_time_over,'r','LineWidth',3)

xlim([1,length(the_winners_range)])
ax.XAxis.FontSize = 10;
ax.YAxis.FontSize = 10;
% xticks([1:length(the_winners_seq)]);
 xticklabels([]);
% xtickangle(45);



title('time extimation')
%xlabel('possible combinations')
ylabel('total mission time requirement (years)')
grid on


figure(2)

scatter(the_winners_range,the_winners_dv,'b',"LineWidth",3);
hold on
scatter(the_winners_mass_over_ind,the_winners_dv_over,'r','LineWidth',3)
xlim([1,length(the_winners_range)])
ax.XAxis.FontSize = 10;
ax.YAxis.FontSize = 10;


 xticklabels([]);
% title(' DeltaV required')
% xlabel('possible combinations')
 ylabel('Dv required (km/s)')
grid on


figure(3)

scatter(the_winners_range,the_winners_prop_mass,'b',"LineWidth",3);
hold on
scatter(the_winners_mass_over_ind,the_winners_mass_over,'r','LineWidth',3)

xlim([1,length(the_winners_range)]);

%xticks([1:length(the_winners_seq)]);
%xticklabels(axplot);
%xtickangle(45);
xticklabels([]);
grid on

ylabel('propellant mass  (Kg)')

the_winners_prop_mass(1);

end     
    
    
    









