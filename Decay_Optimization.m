%% Ball Radius Optimization function
global R

Ball_sizes=1:0.01:10; %m
Debris_mass = 65; %kg
Foam_densities = [0.1,0.25,0.5,1,1.5]; %kg/m3
Altitudes = [Apo1-R,Apo2-R,Apo3-R,Apo4-R,Apo5-R,Apo6-R]/1000; %altitude from surface of the earth in km (data from Orbit Plot Function)

Foam_density_target=1; %The density used in the mission (1 kg/m^3)

Deorbiting_time=zeros(length(Ball_sizes),length(Foam_densities),length(Altitudes));

for i=1:length(Ball_sizes)
    for j=1:length(Foam_densities)
        for k=1:length(Altitudes)
            Deorbiting_time(i,j,k)=Decay_Time(Ball_sizes(i),Foam_densities(j),Debris_mass,Altitudes(k));
        end
    end
end

%Plot the decay time as a function of the ball size for different values of
%densities
for j=1:length(Foam_densities)
    plot(Ball_sizes,Deorbiting_time(:,j,1))
    hold on
end

plot(Ball_sizes,25+0*Ball_sizes,'r')
xlabel("Ball Radius (m)")
ylabel("Deorbiting time (years)")
legend('Foam density : 0.1 kg/m3','Foam density : 0.25 kg/m3','Foam density : 0.5 kg/m3','Foam density : 1 kg/m3','Foam density : 1.5 kg/m3')
title("Deorbiting Time as a function of Foam Ball Radius for different foam densities (for a 1t object)")
%% Optimization of Foam mass with 1kg/m^3 foam

Good_ball_sizes_indexes=zeros(1,length(Altitudes));

%This calculates the minimum ball size that can deorbit each debris k
%within 25 years
for k=1:length(Altitudes)
    Good_ball_sizes_indexes(k)=find(Deorbiting_time(:,find(Foam_densities==Foam_density_target),k)<25,1);
end

%Calculation of the minimum ball mass(we neglect the volume of the debris)
Min_foam_mass=Foam_density_target*4/3*pi*Ball_sizes(Good_ball_sizes_indexes(1,:)).^3;
disp("Masses of foam (kg)")
disp(Min_foam_mass/65)
disp("Ball Radius (m)")
disp(Ball_sizes(Good_ball_sizes_indexes))
disp("Minimal Mass of foam for the 6 debris : "+sum(Min_foam_mass)+" kg")
% disp("Minimal Ball Radius : "+Ball_sizes(Good_ball_sizes_indixes(1))+" m")
