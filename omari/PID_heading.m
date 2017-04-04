function PID_heading
global A
  persistent uik1;
  persistent errork1;
  % initialize persistent variables at beginning of simulation
  if A.init==0, 
      uik1    = 0; 
      errork1 = 0;
  end
 
 error = A.psi_des - A.psi_kalman ;
  
  % proportional term
  up = A.psi_KP * error;
  
  % integral term
  ui = uik1 + A.psi_KI * A.Ts/2 * (error + errork1);
  
  % derivative term
  ud = A.psi_KD*A.r;
  
  
  % implement PID control
  A.U4 = up + ui + ud;

  % update stored variables
  uik1    = ui; 
  errork1 = error;