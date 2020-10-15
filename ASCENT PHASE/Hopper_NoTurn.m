function dudt=Hopper_NoTurn(t,u)

      global A
      global Cd
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
      
      dvxdt=(T/m-D/m-g)*cosd(phi_pos)*sind(theta_pos);
      dvydt=(T/m-D/m-g)*sind(phi_pos)*sind(theta_pos);
      dvzdt=(T/m-D/m-g)*cosd(theta_pos);

    

      dudt = [dxdt; dydt; dzdt; dvxdt; dvydt; dvzdt; dmdt; 0; 0];
end


