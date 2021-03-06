%% Ball Radius Optimization function
global R

Ball_sizes=1.5:0.01:6; %m
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

%% Optimization of Foam mass with 1kg/m^3 foam

Good_ball_sizes_indexes=zeros(1,length(Altitudes));

%This calculates the minimum ball size that can deorbit each debris k
%within 25 years
for k=1:length(Altitudes)
    Good_ball_sizes_indexes(k)=find(Deorbiting_time(:,find(Foam_densities==Foam_density_target),k)<25,1);
end

for k=1:length(Altitudes)
    plot(Ball_sizes,Deorbiting_time(:,find(Foam_densities==Foam_density_target),k))
    hold on
end


xlabel("Ball Radius (m)")
ylabel("Deorbiting time (years)")
% title("Deorbiting Time as a function of Foam Ball Radius for different objects")
for k=1:length(Altitudes)
    scatter(Ball_sizes(Good_ball_sizes_indexes(k)),25,'black')
end
plot(Ball_sizes,25+0*Ball_sizes,'r','LineWidth',1.5)
legend('Object #7412','Object #6276','Object #4954','Object #3271','Object #4048','Object #2940','Minimum Foam Ball Radius')

%Calculation of the minimum ball mass(we neglect the volume of the debris)
Min_foam_mass=Foam_density_target*4/3*pi*Ball_sizes(Good_ball_sizes_indexes(1,:)).^3;
disp("Masses of foam (kg)")
disp(Min_foam_mass)
disp("Ball Radius (m)")
disp(Ball_sizes(Good_ball_sizes_indexes))
disp("Minimal Mass of foam for the 6 debris : "+sum(Min_foam_mass)+" kg")
% disp("Minimal Ball Radius : "+Ball_sizes(Good_ball_sizes_indixes(1))+" m")

%% Final deorbitation

Mothership_area = 1:0.01:5;     %m²
Final_mass = 1200-200-300;      %Total mass - fuel mass - foam mass
Final_altitude = [550,500,450,400,350,300];           %km

Deorbiting_mother_time = zeros(length(Mothership_area),length(Final_altitude));

for i=1:length(Mothership_area)
    for j=1:length(Final_altitude)
        equivalent_radius = sqrt(Mothership_area(i)/pi);
        Deorbiting_mother_time(i,j)=Decay_Time(equivalent_radius,0,Final_mass,Final_altitude(j));
    end
end

for j=1:length(Final_altitude)
    semilogy(Mothership_area,Deorbiting_mother_time(:,j))
    hold on
end

semilogy(Mothership_area,0*Deorbiting_mother_time(:,1)+25,"Color","red","LineWidth",2)

leg = legend('show');
title(leg,'Parking Orbits')
legend("550 km","500 km","450 km","400 km","350 km","300 km", "25 years limit");
xlabel("Mothership Area (m²)")
ylabel("Decay Time (years)")
title("Decay Time as a function of Mothership Area for different Parking Orbits");
