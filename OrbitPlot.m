%% Orbit Plot of objects and rocket

global R
global mu
GravityTurn3D;

Earth_alignment_angle = -Long0+99.02; %To align the earth with the desired orbits [deg]

%% Data of objects

%%% TLE Values day 258 year 2020  

%%% Object 1 : 7412
Apo1=852e3+R; %km
Peri1=788e3+R; %km
incl1=98.76;   %deg
RAAN1=99.02;    %Right Ascension of the Ascending Node [deg]
w1=299.9;       %Argument of the perigee [deg]
m1=65;          %Mass (kg)
color1='blue';

%%% Object 2 : 6276
Apo2=852e3+R; %km
Peri2=798e3+R; %km
incl2=98.55;   %deg
RAAN2=100.89;    %Right Ascension of the Ascending Node [deg]
w2=64.39;       %Argument of the perigee [deg]
m2=65;          %Mass (kg)
color2='yellow';

%%% Object 3 : 4954
Apo3=796e3+R; %km
Peri3=741e3+R; %km
incl3=98.59;   %deg
RAAN3=111.15;    %Right Ascension of the Ascending Node [deg]
w3=37.4;       %Argument of the perigee [deg]
m3=65;          %Mass (kg)
color3='cyan';

%%% Object 4 : 3271
Apo4=879e3+R; %km
Peri4=802e3+R; %km
incl4=98.66;   %deg
RAAN4=114.9;    %Right Ascension of the Ascending Node [deg]
w4=113.4;       %Argument of the perigee [deg]
m4=65;          %Mass (kg)
color4='magenta';

%%% Object 5 : 4048
Apo5=823e3+R; %km
Peri5=762e3+R; %km
incl5=98.54;   %deg
RAAN5=119.8;    %Right Ascension of the Ascending Node [deg]
w5=161.4;       %Argument of the perigee [deg]
m5=65;          %Mass (kg)
color5='green';

%%% Object 6 : 2940
Apo6=870e3+R; %km
Peri6=814e3+R; %km
incl6=98.73;   %deg
RAAN6=121.46;    %Right Ascension of the Ascending Node [deg]
w6=122.33;       %Argument of the perigee [deg]
m6=65;          %Mass (kg)
color6='green';


true_ano=0:1:360;         %true anomalie

%% Plot
%--------------%
% Calculations %
%--------------%

%%% Object 1
a1=(Apo1+Peri1)/2;                  %Semi-major axis [m]
e1=(Apo1-Peri1)/(Apo1+Peri1);       %Exentricity
L_sq1=a1*mu*(1-e1^2);                %Squared Angular Moment [m^4/s^2]
r1=L_sq1./mu.*1./(1+e1.*cosd(true_ano)); %Orbit Radius [m]

x1=r1.*(cosd(true_ano+w1).*cosd(RAAN1-Earth_alignment_angle)-sind(true_ano+w1).*sind(RAAN1-Earth_alignment_angle).*cosd(incl1));
y1=r1.*(cosd(true_ano+w1).*sind(RAAN1-Earth_alignment_angle)+sind(true_ano+w1).*cosd(RAAN1-Earth_alignment_angle)*cosd(incl1));
z1=r1.*sind(true_ano+w1).*sind(incl1);
str1 = {"Orbital Parameters of Object #1","Apogee : "+(Apo1-R)/1000+" km","Perigee : "+(Peri1-R)/1000+" km", "Inclination : "+incl1+"°","RAAN : "+RAAN1+"°", "Perigee Argument : "+w1+"°"};

%%% Object 2
a2=(Apo2+Peri2)/2;                  %Semi-major axis [m]
e2=(Apo2-Peri2)/(Apo2+Peri2);       %Exentricity
L_sq2=a2*mu*(1-e2^2);                %Squared Angular Moment [m^4/s^2]
r2=L_sq2./mu.*1./(1+e2.*cosd(true_ano)); %Orbit Radius [m]

x2=r2.*(cosd(true_ano+w2).*cosd(RAAN2-Earth_alignment_angle)-sind(true_ano+w2).*sind(RAAN2-Earth_alignment_angle).*cosd(incl2));
y2=r2.*(cosd(true_ano+w2).*sind(RAAN2-Earth_alignment_angle)+sind(true_ano+w2).*cosd(RAAN2-Earth_alignment_angle)*cosd(incl2));
z2=r2.*sind(true_ano+w2).*sind(incl2);
str2 = {"Orbital Parameters of Object #2","Apogee : "+(Apo2-R)/1000+" km","Perigee : "+(Peri2-R)/1000+" km", "Inclination : "+incl2+"°","RAAN : "+RAAN2+"°", "Perigee Argument : "+w2+"°"};

%%% Object 3
a3=(Apo3+Peri3)/2;                  %Semi-major axis [m]
e3=(Apo3-Peri3)/(Apo3+Peri3);       %Exentricity
L_sq3=a3*mu*(1-e3^2);                %Squared Angular Moment [m^4/s^2]
r3=L_sq3./mu.*1./(1+e3.*cosd(true_ano)); %Orbit Radius [m]

x3=r3.*(cosd(true_ano+w3).*cosd(RAAN3-Earth_alignment_angle)-sind(true_ano+w3).*sind(RAAN3-Earth_alignment_angle).*cosd(incl3));
y3=r3.*(cosd(true_ano+w3).*sind(RAAN3-Earth_alignment_angle)+sind(true_ano+w3).*cosd(RAAN3-Earth_alignment_angle)*cosd(incl3));
z3=r3.*sind(true_ano+w3).*sind(incl3);
str3 = {"Orbital Parameters of Object #3","Apogee : "+(Apo3-R)/1000+" km","Perigee : "+(Peri3-R)/1000+" km", "Inclination : "+incl3+"°","RAAN : "+RAAN3+"°", "Perigee Argument : "+w3+"°"};

%%% Object 4
a4=(Apo4+Peri4)/2;                  %Semi-major axis [m]
e4=(Apo4-Peri4)/(Apo4+Peri4);       %Exentricity
L_sq4=a4*mu*(1-e4^2);                %Squared Angular Moment [m^4/s^2]
r4=L_sq4./mu.*1./(1+e4.*cosd(true_ano)); %Orbit Radius [m]

x4=r4.*(cosd(true_ano+w4).*cosd(RAAN4-Earth_alignment_angle)-sind(true_ano+w4).*sind(RAAN4-Earth_alignment_angle).*cosd(incl4));
y4=r4.*(cosd(true_ano+w4).*sind(RAAN4-Earth_alignment_angle)+sind(true_ano+w4).*cosd(RAAN4-Earth_alignment_angle)*cosd(incl4));
z4=r4.*sind(true_ano+w4).*sind(incl4);
str4 = {"Orbital Parameters of Object #4","Apogee : "+(Apo4-R)/1000+" km","Perigee : "+(Peri4-R)/1000+" km", "Inclination : "+incl4+"°","RAAN : "+RAAN4+"°", "Perigee Argument : "+w4+"°"};

%%% Object 5
a5=(Apo5+Peri5)/2;                  %Semi-major axis [m]
e5=(Apo5-Peri5)/(Apo5+Peri5);       %Exentricity
L_sq5=a5*mu*(1-e5^2);                %Squared Angular Moment [m^4/s^2]
r5=L_sq5./mu.*1./(1+e5.*cosd(true_ano)); %Orbit Radius [m]

x5=r5.*(cosd(true_ano+w5).*cosd(RAAN5-Earth_alignment_angle)-sind(true_ano+w5).*sind(RAAN5-Earth_alignment_angle).*cosd(incl5));
y5=r5.*(cosd(true_ano+w5).*sind(RAAN5-Earth_alignment_angle)+sind(true_ano+w5).*cosd(RAAN5-Earth_alignment_angle)*cosd(incl5));
z5=r5.*sind(true_ano+w5).*sind(incl5);
str5= {"Orbital Parameters of Object #5","Apogee : "+(Apo5-R)/1000+" km","Perigee : "+(Peri5-R)/1000+" km", "Inclination : "+incl5+"°","RAAN : "+RAAN5+"°", "Perigee Argument : "+w5+"°"};

%%% Object 6
a6=(Apo6+Peri6)/2;                  %Semi-major axis [m]
e6=(Apo6-Peri6)/(Apo6+Peri6);       %Exentricity
L_sq6=a6*mu*(1-e6^2);                %Squared Angular Moment [m^4/s^2]
r6=L_sq6./mu.*1./(1+e6.*cosd(true_ano)); %Orbit Radius [m]

x6=r6.*(cosd(true_ano+w6).*cosd(RAAN6-Earth_alignment_angle)-sind(true_ano+w6).*sind(RAAN6-Earth_alignment_angle).*cosd(incl6));
y6=r6.*(cosd(true_ano+w6).*sind(RAAN6-Earth_alignment_angle)+sind(true_ano+w6).*cosd(RAAN6-Earth_alignment_angle)*cosd(incl6));
z6=r6.*sind(true_ano+w6).*sind(incl6);
str6= {"Orbital Parameters of Object #6","Apogee : "+(Apo6-R)/1000+" km","Perigee : "+(Peri6-R)/1000+" km", "Inclination : "+incl5+"°","RAAN : "+RAAN5+"°", "Perigee Argument : "+w5+"°"};



%--------------%
% Orbital Plot %
%--------------%

figure(1)
hold on
plot3(x1,y1,z1,color1, 'LineWidth', 1.5)
% plot3(x2,y2,z2,color2, 'LineWidth', 1.5)
% plot3(x3,y3,z3,color3, 'LineWidth', 1.5)
% plot3(x4,y4,z4,color4, 'LineWidth', 1.5)
% plot3(x5,y5,z5,color5, 'LineWidth', 1.5)
% plot3(x6,y6,z6,color6, 'LineWidth', 1.5)

text(-1*a1,1*a1,0,str1,'Color',color1,'HorizontalAlignment','left','FontSize',14    ,'fontweight', 'bold')
% text(0,0,-1.5*a2,str2,'Color',color2,'HorizontalAlignment','left','FontSize',7)
% text(0,1.5*a3,0,str3,'Color',color3,'HorizontalAlignment','left','FontSize',7)
% text(-1.5*a4,0,0,str4,'Color',color4,'HorizontalAlignment','left','FontSize',7)
% text(0,-1.5*a5,0,str5,'Color',color5,'HorizontalAlignment','left','FontSize',7)
% text(0,0,1.5*a6,str6,'Color',color6,'HorizontalAlignment','left','FontSize',7)