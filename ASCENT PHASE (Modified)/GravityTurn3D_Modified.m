%% Main Program for the 3D gravity turn

clear all
clc

global A
global Cd
global R
global mu
global incl
global apo
global peri

%%% Data

Tt=10;          %Time before start of gravity turn [s]
g=9.81;         %Gravity Acceleration [m/s²] => can be evaluated as a function of H : g=GM/r
Cd=0.20;        %Drag Coefficient [1]
A=4.3855;       %Area of Vega C [m²]
R=6371008.7714;       %Earth Radius [m]
G=6.67e-11;             %Gravitational Constant [m3 kg-1 s-2]
M_earth = 5.972e24;     %Earth's Mass [kg]
E = 0;
mu=G*M_earth;

%-----------------------%
%%% Values for a Vega %%%
%-----------------------%

%Stage 1 : P80
mp1=88000;      %[kg]
ms1=7800;       %[kg]
Isp1=280;         %[s]
T1=3040000;      %[N]

%Stage 2 : Zefiro 23
mp2=23900;       %[kg]
ms2=1700;        %[kg]
Isp2=289;         %[s]
T2=1200000;      %[N]

%Stage 3 :
mp3=10100;        %[kg]
ms3=800;        %[kg]
Isp3=295;         %[s]
T3=313000;       %[N]

%Stage 4 : 
mp4=550;        %[kg]
ms4=250;        %[kg]
Isp4=315.2;         %[s]
T4=2450;       %[N]


m_star=1100;     %[kg]

mf1=T1/(Isp1*g);
mf2=T2/(Isp2*g);
mf3=T3/(Isp3*g);
mf4=T4/(Isp4*g);


ve1=Isp1*g;
ve2=Isp2*g;
ve3=Isp3*g;
ve4=Isp4*g;

% Integration Values

tb1=mp1*Isp1*g/T1;
tb2=mp2*Isp2*g/T2;
tb3=mp3*Isp3*g/T3;
tb4=mp4*Isp4*g/T4;
dt=0.01;

%% Initialization of Ode45

t1a=0:dt:Tt;
t1b=Tt:dt:tb1;
t2=tb1:dt:tb1+tb2;


opts = odeset('RelTol',1e-2,'AbsTol',1e-4);


%% Calculation of the turn

%initial value of u=[x,y,z,dxdt,dydt,dzdt,m, mf, ve]

%---------------------------------------------------------%
%%% Launch site coordinates of Kourou in French Guyanne %%%
%---------------------------------------------------------%

Lat0 = 5.159700; %deg
Long0 = -52.650299; %deg
Pos0=[R*cosd(Lat0)*cosd(Long0) R*cosd(Lat0)*sind(Long0) R*sind(Lat0)];

% Desired orbit
incl=98.76; % orbit inclination [deg]
apo=700e3;      %m
peri=500e3;     %m

%-----------------------------%
%%% Calculations with ode45 %%%
%-----------------------------%

init_u1a=[Pos0(1);Pos0(2);Pos0(3); 0; 0; 0; mp1+ms1+mp2+ms2+mp3+ms3+m_star;mf1;ve1;E];

%Ode45 function
[t1a,u1a]=ode45(@Hopper_NoTurn, t1a, init_u1a, opts);

% gam0=u1a(end,2);
% gamt1b = -(gam0-30)/2*tanh(0.1*(t1b-(Tt+tb1)/2))+gam0/2;

v1a=sqrt(u1a(end,4)^2+u1a(end,5)^2+u1a(end,6)^2);
theta_1a=acosd(u1a(end,6)/v1a);

gam_i=90;
gam_f=0;
gamt1b = (gam_f-gam_i)/2*tanh(0.08*(t1b-(Tt+tb1)/2))+gam_i/2;

init_u1b=[u1a(end,1); u1a(end,2); u1a(end,3); u1a(end,4); u1a(end,5); u1a(end,6); u1a(end,7); mf1; ve1; u1a(end,10)];
[t1b,u1b]=ode45(@(t,u) Steer(t,u,t1b,gamt1b),t1b,init_u1b,opts);

gam_i=0;
gam_f=0;
gamt2 = (gam_f-gam_i)/2*tanh(0.08*(t2-(2*tb1+tb2)/2))+gam_i/2;

init_u2=[u1b(end,1); u1b(end,2); u1b(end,3); u1b(end,4); u1b(end,5); u1b(end,6); mp2+ms2+mp3+ms3+mp4+ms4+m_star; mf2; ve2; u1b(end,10)];

[t2,u2]=ode45(@(t,u) Steer(t,u,t2,gamt2),t2,init_u2,opts);

%-------------------------%
%%% 3rd stage Hell burn %%%
%-------------------------%


burn_ratio_3=0.891;    %fraction of fuel burned before cruising : sets apogee altitude
wait_time_3=0.49;       %in percentage of orbit (0.5 being close to apogee)
apoapsis_adjuster=0.22;  %Parameter that stops 3rd burn before the end : sets perigee

t3a=tb1+tb2:dt:tb1+tb2+burn_ratio_3*tb3;
gamt3a=0*t3a;


init_u3=[u2(end,1); u2(end,2); u2(end,3); u2(end,4); u2(end,5); u2(end,6); mp3+ms3+ms4+mp4+m_star; mf3; ve3; u2(end,10)];
[t3a,u3]=ode45(@(t,u) Steer(t,u,t3a,gamt3a),t3a,init_u3,opts);

h=sqrt(u3(end,1)^2+u3(end,2)^2+u3(end,3)^2);
v=sqrt(u3(end,4)^2+u3(end,5)^2+u3(end,6)^2);

a=1/(2/(h)-v^2/(mu)); %Semi-major axis in m


cruising_time3=wait_time_3*2*pi*sqrt((a/1000)^3/398600); %Waiting to get to Apogee
t3b=tb1+tb2+burn_ratio_3*tb3:dt:tb1+tb2+burn_ratio_3*tb3+cruising_time3;
t3c=tb1+tb2+burn_ratio_3*tb3+cruising_time3 : dt : tb1+tb2+burn_ratio_3*tb3+cruising_time3+apoapsis_adjuster*(1-burn_ratio_3)*tb3;


init_u3b=[u3(end,1); u3(end,2); u3(end,3); u3(end,4); u3(end,5); u3(end,6); u3(end,7);0;0; u3(end,10)];
[t3b,u3b]=ode45(@orbiter3D, t3b, init_u3b);

init_u3c=[u3b(end,1); u3b(end,2); u3b(end,3); u3b(end,4); u3b(end,5); u3b(end,6); u3(end,7);mf3;ve3; u3b(end,10)];
[t3c,u3c]=ode45(@(t,u) Prograde_Burn(t,u),t3c,init_u3c,opts);


% t4=tb1+tb2+burn_ratio_3*tb3+cruising_time3+(1-burn_ratio_3)*tb3 : dt : tb1+tb2+burn_ratio_3*tb3+cruising_time3+(1-burn_ratio_3)*tb3+tb4;
% 
% init_u4=[u3c(end,1); u3c(end,2); u3c(end,3); u3c(end,4); u3c(end,5); u3c(end,6); mp4+ms4+m_star; mf4; ve4];
% [t4,u4]=ode45(@(t,u) Prograde_Burn(t,u),t4,init_u4,opts);



%% Plots


earth_example
hold on

x=[u1a(:,1); u1b(:,1); u2(:,1); u3(:,1); u3b(:,1); u3c(:,1)]; %; u4(:,1)
y=[u1a(:,2); u1b(:,2); u2(:,2); u3(:,2); u3b(:,2); u3c(:,2)]; %; u4(:,2)
z=[u1a(:,3); u1b(:,3); u2(:,3); u3(:,3); u3b(:,3); u3c(:,3)]; %; u4(:,3)
vx=[u1a(:,4); u1b(:,4); u2(:,4); u3(:,4); u3b(:,4); u3c(:,4)]; %; u4(:,4)
vy=[u1a(:,5); u1b(:,5); u2(:,5); u3(:,5); u3b(:,5); u3c(:,5)]; %; u4(:,5)
vz=[u1a(:,6); u1b(:,6); u2(:,6); u3(:,6); u3b(:,6); u3c(:,6)]; %; u4(:,6)
m=[u1a(:,7); u1b(:,7); u2(:,7); u3(:,7); u3b(:,7); u3c(:,7)]; %; u4(:,7)

h=sqrt(x.^2+y.^2+z.^2);
v=sqrt(vx.^2+vy.^2+vz.^2);
t=[t1a; t1b; t2; t3a; t3b; t3c]; %; t4
H=h-R;
theta_pos=acosd(z./h);
phi_pos=atan2d(y,x);

theta_vit=acosd(vz./v);
phi_vit=atan2d(vy,vx);

plot3(x,y,z,'w','LineWidth',1.5)
hold on
% plot3(u4(:,1),u4(:,2),u4(:,3),'w','LineWidth',1.5)

h1a=sqrt(u1a(:,1).^2+u1a(:,2).^2+u1a(:,3).^2);
h1b=sqrt(u1b(:,1).^2+u1b(:,2).^2+u1b(:,3).^2);
h2=sqrt(u2(:,1).^2+u2(:,2).^2+u2(:,3).^2);
h3=sqrt(u3(:,1).^2+u3(:,2).^2+u3(:,3).^2);
h3b=sqrt(u3b(:,1).^2+u3b(:,2).^2+u3b(:,3).^2);
h3c=sqrt(u3c(:,1).^2+u3c(:,2).^2+u3c(:,3).^2);
% h4=sqrt(u4(:,1).^2+u4(:,2).^2+u4(:,3).^2);

% % Angle Plot
% figure(3);
% plot(t,theta_pos,t, phi_pos, t, theta_vit,t, phi_vit);
% xlabel('Time (s)')
% ylabel('Angle (°)')
% legend('theta pos','phi pos','theta vit','phi vit')

%Mass plot
% figure(4);
% plot(t,m);u
% xlabel('Time (s)');
% ylabel('Mass (kg)');

% %Speed Plot
% figure(5);
% plot(t,v);
% xlabel('Time (s)');
% ylabel('Speed (m/s)');



%% Orbit Phase
% 

h0=h(end);
v0=v(end);
a0=1/(2/(h0)-v0^2/(mu)); %Semi-major axis in m

T=1*2*pi*sqrt((a0/1000)^3/398600);
t5=0:1:T;

init_u5=[u3c(end,1); u3c(end,2); u3c(end,3); u3c(end,4); u3c(end,5); u3c(end,6); m_star; 0; 0; u3c(end,10)];
[t5,u5]=ode45(@orbiter3D, t5, init_u5);

figure(1)
hold on
plot3(u5(:,1), u5(:,2), u5(:,3), 'r', 'LineWidth', 1.5)
text(Pos0(1),Pos0(2),Pos0(3),'Launch Site \rightarrow','Color','w','HorizontalAlignment','right')


Orbit_coord=u5(:,1:3);
Orbit_r=sqrt(u5(:,1).^2+u5(:,2).^2+u5(:,3).^2);
[rp,Ip]=min(Orbit_r);
[ra,Ia]=max(Orbit_r);
hp=(rp-R)/1000;
ha=(ra-R)/1000;

text(u5(Ia,1),u5(Ia,2),u5(Ia,3),"Apoapsis ("+ha+" km) \rightarrow",'Color','red','HorizontalAlignment','right')
text(u5(Ip,1),u5(Ip,2),u5(Ip,3),"\leftarrow Periapsis ("+hp+" km)"','Color','red','HorizontalAlignment','left')
disp("Perigee : "+hp+" km")
disp("Apogee  : "+ha+" km")

% hold off
%Height plot
figure(2);  
plot(t1a,(h1a-R)/1000,t1b,(h1b-R)/1000,t2,(h2-R)/1000,t3a,(h3-R)/1000,t3b,(h3b-R)/1000,t3c,(h3c-R)/1000,t5+t3c(end),(Orbit_r-R)/1000, 'LineWidth', 1.5); %t4,(h4-R)/1000
xlabel('Time (s)');
ylabel('H (km)');

theta = acos(z./sqrt(x.^2+y.^2+z.^2));
dist = 6371*(pi/2-theta);

figure(4);
plot(dist,z)

%% ENERGY CALCULATION


Energy = u3c(end,10);
disp(['The total energy produced by the rocket during ascent is: ' , num2str(Energy), 'J'])

