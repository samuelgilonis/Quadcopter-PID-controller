function Kalman_theta
global A
persistent Pp Q R xp A1 H I
if isempty(Pp)
    Pp=1;     Q=5;    R=100;     
    xp=0;     A1=0.5;      H=1;     I=eye(1); 
end 
% Compute priori
    xp=A.q*A.Ts + xp;
    Pp=A1*Pp*A1'+Q;
% Measurement update 
    K = Pp*H'*inv(H*Pp*H'+R);
    A.theta_kalman = xp+K*(A.theta_meas-H*xp);
    A.theta_kalman_plot(A.counter) = A.theta_kalman;
% Update covariance  
    Pp=(I-K*H)*Pp;  
    xp = A.theta_kalman;
% End or function