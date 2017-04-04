%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pitch_attitude_hold
%  - regulate pitch attitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PID_pitch
global A
  persistent uik1;
  persistent errork1;
  % initialize persistent variables at beginning of simulation
  if A.init==0, 
      uik1    = 0; 
      errork1 = 0;
  end
 
  % error equation
  error = A.theta_des - A.theta_kalman;

  % proportional term
  up = A.theta_KP * error;
  
  % integral term
  ui = uik1 + A.theta_KI * A.Ts/2 * (error + errork1);
  
  % derivative term
  ud = A.theta_KD*A.q;
  
  
  % implement PID control
  A.U3 = up + ui + ud;

  % update stored variables
  uik1    = ui; 
  errork1 = error;
  
end