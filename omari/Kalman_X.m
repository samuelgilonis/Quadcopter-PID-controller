function Kalman_X
global A
persistent Pp Q R xp A1 H I xp_dot
if isempty(Pp)
    Pp=1;     Q=5;    R=100;     
    xp=0;     A1=0.5;      H=1;     I=eye(1);   xp_dot = 0; 
end 
% Compute priori
    xp_dot = (A.U1/A.m*A.theta_kalman - (A.X_dot*cos(A.psi_kalman)+A.Y_dot*sin(A.psi_kalman))*1.2)*A.Ts + xp_dot;
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