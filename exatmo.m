function [rho]=exatmo(height)
%this function is useful to find out tipical atmospheric values with a
%local exponential model.atmospheric  height scale values were retrived
%from tables shown in class and available on the course slides.The out put
%values are  p (pressure in Pa), rho (density in
%Kg/m^3.
%Be sure the altitude is in m and not in km.

R_gas= 8.31432;  %[J/(Kg*mol)]
      gamma=1.4;     %no_dim


    
    % preallocation stuff
    rho=zeros(length(height),1);
    p=zeros(length(height),1);
    
    for j=1:length(height)
       altitude=height(j); %[m]
       
       if altitude<0
       error('you should put a positive altitude')
       return
       end

        if  altitude<=150000
            altitude_0=0;
            rho_0=1.225;    %[Kg/m^3]
            p_0=1.10*10^5;    %[Pa]
            H_scale=8343.5;   %[m]
            Molecular_weight=29*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
           
            %temperature remains constant along the heigh since you are concidering
            %it as constant
            
        elseif  altitude>150000 || altitude<=200000
            altitude_0=150000;
            rho_0=2.076*10^-9;    %[Kg/m^3]
            p_0=4.54*10^-4;    %[Pa]
            H_scale=44.924*10^3;   %[m]
            Molecular_weight=24.1*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
           %temperature remains constant along the heigh since you are concidering
           %it as constant
        
        elseif  altitude >200000 || altitude <=250000
            altitude_0=200000;
            rho_0=2.541*10^-10;    %[Kg/m^3]
            p_0=8.47*10^-5;    %[Pa]
            H_scale=36.183*10^3;   %[m]
            Molecular_weight=21.3*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
           %temperature remains constant along the heigh since you are concidering
           %it as constant
        
        elseif  altitude >250000 || altitude<=300000
            altitude_0=250000;
            rho_0=2.541*10^-10;    %[Kg/m^3]
            p_0=8.47*10^-5;    %[Pa]
            H_scale=44.924*10^3;   %[m]
            Molecular_weight=21.3*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
           %temperature remains constant along the heigh since you are concidering
           %it as constant
           
        elseif  altitude >300000 || altitude<=350000
            altitude_0=300000;
            rho_0=1.916*10^-11;    %[Kg/m^3]
            p_0=8.77*10^-6;    %[Pa]
            H_scale=51.193*10^3;   %[m]
            Molecular_weight=17.7*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
           %temperature remains constant along the heigh since you are concidering
           %it as constant
           
        elseif  altitude >350000 || altitude<=400000
            altitude_0=350000;
            rho_0=7.014*10^-11;    %[Kg/m^3]
            p_0=3.45*10^-6;    %[Pa]
            H_scale=55.832*10^3;   %[m]
            Molecular_weight=16.7*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
           %temperature remains constant along the heigh since you are concidering
           %it as constant
           
        elseif  altitude >400000 || altitude<=450000
            altitude_0=400000;
            rho_0=2.803*10^-12;    %[Kg/m^3]
            p_0=1.45*10^-6;    %[Pa]
            H_scale=59.678*10^3;   %[m]
            Molecular_weight=16.0*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
             
        elseif  altitude >450000 || altitude<=500000
            altitude_0=450000;
            rho_0=1.184*10^-12;    %[Kg/m^3]
            p_0=6.45*10^-7;    %[Pa]
            H_scale=63.644*10^3;   %[m]
            Molecular_weight=15.3*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
            
        elseif  altitude >500000 || altitude<=550000
            altitude_0=500000; %[m]
            rho_0=5.215*10^-13;    %[Kg/m^3]
            p_0=3.02*10^-7;    %[Pa]
            H_scale=68.785*10^3;   %[m]
            Molecular_weight=14.4*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
          
        elseif  altitude >550000 || altitude<=600000
            altitude_0=550000; %[m]
            rho_0=2.384*10^-13;    %[Kg/m^3]
            p_0=1.51*10^-7;    %[Pa]
            H_scale=76.427*10^3;   %[m]
            Molecular_weight=13.1*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
            
        elseif  altitude >600000 || altitude<=650000
            altitude_0=600000; %[m]
            rho_0=1.137*10^-13;    %[Kg/m^3]
            p_0=8.21*10^-8;    %[Pa]
            H_scale=88.244*10^3;   %[m]
            Molecular_weight=11.5*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
            
        elseif  altitude >650000 || altitude<=700000
            altitude_0=650000; %[m]
            rho_0=5.712*10^-14;    %[Kg/m^3]
            p_0=4.89*10^-8;    %[Pa]
            H_scale=105.992*10^3;   %[m]
            Molecular_weight=9.72*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
        
        elseif  altitude >700000 || altitude<=750000
            altitude_0=700000; %[m]
            rho_0=3.070*10^-14;    %[Kg/m^3]
            p_0=3.19*10^-8;    %[Pa]
            H_scale=130.630*10^3;   %[m]
            Molecular_weight=8.00*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
        
        elseif  altitude >750000 || altitude<=800000
            altitude_0=750000; %[m]
            rho_0=1.788*10^-14;    %[Kg/m^3]
            p_0=2.26*10^-8;    %[Pa]
            H_scale=161.064*10^3;   %[m]
            Molecular_weight=6.58*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
            
        elseif  altitude >800000 || altitude<=850000
            altitude_0=800000; %[m]
            rho_0=1.136*10^-14;    %[Kg/m^3]
            p_0=1.70*10^-8;    %[Pa]
            H_scale=193.862*10^3;   %[m]
            Molecular_weight=5.54*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
             
        elseif  altitude >850000 || altitude<=900000
            altitude_0=850000; %[m]
            rho_0=7.824*10^-15;    %[Kg/m^3]
            p_0=1.34*10^-8;    %[Pa]
            H_scale=224.737*10^3;   %[m]
            Molecular_weight=4.85*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
            
        elseif  altitude >900000 || altitude<=950000
            altitude_0=900000; %[m]
            rho_0=5.759*10^-15;    %[Kg/m^3]
            p_0=1.09*10^-8;    %[Pa]
            H_scale=250.894*10^3;   %[m]
            Molecular_weight=4.40*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
         
        elseif  altitude >950000 || altitude<=1000000
            altitude_0=950000; %[m]
            rho_0=4.453*10^-15;    %[Kg/m^3]
            p_0=8.98*10^-9;    %[Pa]
            H_scale=271.754*10^3;   %[m]
            Molecular_weight=4.12*10^-3; %[J/mol]
            R_spec=R_gas/Molecular_weight;
            rho(j)=rho_0*exp(-(altitude-altitude_0)/H_scale); %[Kg/m^3]
            p(j)=p_0*exp(-(altitude-altitude_0)/H_scale);
            T=p/(rho*R_spec);
            a=sqrt(gamma*R_spec*T);
        end
    end
end
    
    
    
    



  