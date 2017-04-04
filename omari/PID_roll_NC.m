function PID_roll_NC
global A
  persistent uik1;
  persistent errork1;
  % initialize persistent variables at beginning of simulation
  if A.init==0, 
      uik1    = 0; 
      errork1 = 0;
  end
 
  % error equation
  error = A.phi_des - A.phi_meas;

  % proportional term
  up = A.phi_KP * error;
  
  % integral term
  ui = uik1 + A.phi_KI * A.Ts/2 * (error + errork1);
  
  % derivative term
  ud = A.phi_KD*A.p;
  
  % implement PID control
  A.U2 = up + ui + ud;

  % update stored variables
  uik1    = ui; 
  errork1 = error;