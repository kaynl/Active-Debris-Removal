function dudt=Steer(t,u,t3,gamt) %u=[x,y,z,vx,vy,vz,m,mf,ve]


      global A
      global Cd
      global R
      global mu
      global incl
      global apo
      global peri

      x=u(1);
      y=u(2);
      z=u(3);
      vx=u(4);
      vy=u(5);
      vz=u(6);
      m=u(7);
      mf=u(8);
      ve=u(9);
      E = u(10);
      
      r=sqrt(x^2+y^2+z^2);
      H=r-R;
      theta_pos=acosd(z/r);
      phi_pos=atan2d(y,x);
      g=mu/(r^2);
      
      V=sqrt(vx^2+vy^2+vz^2);
      
      
      if H<0
          rho=exatmo(0);
      else 
          rho=exatmo(H);
      end

      dmdt=-mf;
      T=-dmdt*ve;

      
      D=0.5*(rho*V^2*Cd*A);
      
      dxdt=vx;
      dydt=vy;
      dzdt=vz;
      
      gam_st = interp1(t3,gamt,t); % Interpolate the data set (t3,gamt) at time t
      
      %Thrusting along theta axis
      dvxdt=(T/m-D/m)*(sind(gam_st)*sind(theta_pos)*cosd(phi_pos)-sind(incl)*cosd(gam_st)*cosd(theta_pos)*cosd(phi_pos)-cosd(incl)*sind(phi_pos))-g*cosd(phi_pos)*sind(theta_pos);
      dvydt=(T/m-D/m)*(sind(gam_st)*sind(theta_pos)*sind(phi_pos)-sind(incl)*cosd(gam_st)*cosd(theta_pos)*sind(phi_pos)+cosd(incl)*cosd(phi_pos))-g*sind(phi_pos)*sind(theta_pos);
      dvzdt=(T/m-D/m)*(sind(gam_st)*cosd(theta_pos)+sind(incl)*cosd(gam_st)*sind(theta_pos))-g*cosd(theta_pos);
      
      dvxdt2=(T/m)*(sind(gam_st)*sind(theta_pos)*cosd(phi_pos)-sind(incl)*cosd(gam_st)*cosd(theta_pos)*cosd(phi_pos)-cosd(incl)*sind(phi_pos));
      dvydt2=(T/m)*(sind(gam_st)*sind(theta_pos)*sind(phi_pos)-sind(incl)*cosd(gam_st)*cosd(theta_pos)*sind(phi_pos)+cosd(incl)*cosd(phi_pos));
      dvzdt2=(T/m)*(sind(gam_st)*cosd(theta_pos)+sind(incl)*cosd(gam_st)*sind(theta_pos));
    
      dEdt = T*sqrt(vx^2 + vy^2 + vz^2);
      
      dudt = [dxdt; dydt; dzdt; dvxdt; dvydt; dvzdt; dmdt; 0; 0; dEdt];

    
      
      
      
end