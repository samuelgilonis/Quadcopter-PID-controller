function Kalman_psi
global A
persistent Pp Q R xp A1 H I
if isempty(Pp)
    Pp=1;     Q=5;    R=100;     
    xp=0;     A1=0.5;      H=1;     I=eye(1); 
end 
% Compute priori
    xp=A.r*A.Ts + xp;
    Pp=A1*Pp*A1'+Q;
% Measurement update 
    K = Pp*H'*inv(H*Pp*H'+R);
    A.psi_kalman = xp+K*(A.psi_meas-H*xp);
    A.psi_kalman_plot(A.counter) = A.psi_kalman;
% Update covariance  
    Pp=(I-K*H)*Pp;  
    xp = A.psi_kalman;
% End or function