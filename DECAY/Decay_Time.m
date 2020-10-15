function [delta_t_total_year] = Decay_Time(Ball_Radius,rho_foam,mass_deb,h)
%DECAY_TIME Summary of this function goes here
%   Detailed explanation goes here
    

    global mu
    global R
    Cd=0.5; % Value for a sphere
    
    
    B_star=Cd.*pi.*Ball_Radius.^2./(mass_deb+rho_foam.*4./3.*pi*Ball_Radius.^3);
    
    Altitude=[0,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000];
    %km
    
    rho=[1.225,2.076e-9,2.541e-10,6.073e-11,1.916e-11,7.014e-12,2.803e-12,1.184e-12,5.215e-13,2.384e-13,1.137e-13,5.712e-14,3.070e-14,1.788e-14,1.136e-14,7.824e-15,5.759e-15,4.453e-15,3.561e-15];
    %kg/m^3
    
    H_scale=[8.4345,23.380,36.183,44.924,51.193,55.832,59.678,63.644,68.785,76.427,88.244,105.992,130.630,161.074,193.862,224.737,250.894,271.754,288.203];
    %km
    
    delta_t=zeros(1,length(Altitude));
    
    for i=1:length(Altitude)-1
        delta_t(i)=H_scale(i)./(B_star.*rho(i).*sqrt(R*mu)).*(exp(Altitude(i+1)/H_scale(i))-exp(Altitude(i)/H_scale(i)));
    end
    
    Bottom_Layer_index = find(Altitude>h,1)-1;
    delta_t0=H_scale(Bottom_Layer_index)./(B_star.*rho(Bottom_Layer_index).*sqrt(R*mu)).*(exp(h/H_scale(Bottom_Layer_index))-exp(Altitude(Bottom_Layer_index)/H_scale(Bottom_Layer_index)));
    
    
    delta_t_total=delta_t0;
    for i=1:Bottom_Layer_index-1
        delta_t_total=delta_t_total+delta_t(i);
    end
    delta_t_total_year=delta_t_total/(365*24*60*60);
end