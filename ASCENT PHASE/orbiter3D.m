function dudt=orbiter3D(t,u) %u=[x,y,z,vx,vy,vz,m,mf,ve]
%Orbiter3D(t,u,t3,gamt)

      global R
      global mu

      x=u(1);
      y=u(2);
      z=u(3);
      vx=u(4);
      vy=u(5);
      vz=u(6);
      m=u(7);
      mf=u(8);
      ve=u(9);
      
      r=sqrt(x^2+y^2+z^2);
      H=r-R;
      theta_pos=acosd(z/r);
      phi_pos=atan2d(y,x);
      
      g=mu/(r^2);
      
      V=sqrt(vx^2+vy^2+vz^2);      
            
      dmdt=0;
      
      dxdt=vx;
      dydt=vy;
      dzdt=vz;
            
      dvxdt=-g*cosd(phi_pos)*sind(theta_pos);
      dvydt=-g*sind(phi_pos)*sind(theta_pos);
      dvzdt=-g*cosd(theta_pos);
    

      dudt = [dxdt; dydt; dzdt; dvxdt; dvydt; dvzdt; dmdt; 0; 0];

    
%       gam_st = interp1(t3,gamt,t); % Interpolate the data set (ft,f) at time t
      
      
end