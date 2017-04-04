function Kalman_X2
global A
persistent Pp Q R xp A1 H I xp_dot
if isempty(Pp)
    Pp=1;     Q=5;    R=100;     
    xp=0;     A1=0.5;      H=1;     I=eye(1);   xp_dot = 0; 
end 
% Compute priori
    xp_dot = ((sin(A.psi_kalman)*sin(A.phi_kalman) + cos(A.psi_kalman)*sin(A.theta_kalman)*cos(A.phi_kalman))*A.U1/A.m - A.X_dot*1.2)*A.Ts + xp_dot;
    xp=xp_dot*A.Ts + xp;
    Pp=A1*Pp*A1'+Q;
% Measurement update 
    K = Pp*H'*inv(H*Pp*H'+R);
    A.X_kalman = xp+K*(A.X_meas-H*xp);

    A.X_kalman_plot(A.counter) = A.X_kalman;
% Update covariance  
    Pp=(I-K*H)*Pp;  
    xp = A.X_kalman;
% End or function