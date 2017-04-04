function PID_Z_NC
global A
persistent ui;
  persistent errork1;
  persistent vhatk1;
  % initialize persistent variables at beginning of simulation
  if A.init==0
      ui    = 0; 
      errork1 = 0;
      vhatk1 = 0;
  end
 
  error = A.Z_des-A.Z_meas;
  % proportional term1
  up = A.Z_KP * error;
  
  % integral term
  ui = ui + A.Z_KI * A.Ts/2 * (error + errork1);
  
  % dirty derivative of pe to get vhat
  vhat = (2*A.tau-A.Ts)/(2*A.tau+A.Ts)*vhatk1 + (2/(2*A.tau+A.Ts))*(error - errork1);
  ud = A.Z_KD*vhat;

  F = up + ui + ud;

  A.U1 = A.m*(A.g + F)/cos(A.phi_meas)/cos(A.theta_meas);
  A.U1_plot(A.counter) = A.U1;
  
  % update stored variables
  errork1 = error;
  vhatk1 = vhat;
  
end