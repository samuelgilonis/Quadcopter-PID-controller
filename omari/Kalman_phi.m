function Kalman_phi
global A
persistent Pp Q R xp A1 H I
if isempty(Pp)
    Pp=1;     Q=5;    R=100;     
    xp=0;     A1=0.5;      H=1;     I=eye(1); 
end 
% Compute priori
    xp=A.p*A.Ts + xp;
%     Pp=A1*Pp*A1'+Q
%     Pp = 6.5331;
% Measurement update 
%     K = Pp*H'*inv(H*Pp*H'+R)
    K = 0.0613;
    A.phi_kalman = xp+K*(A.phi_meas-xp);
    A.phi_kalman_plot(A.counter) = A.phi_kalman;
% Update covariance  
%     Pp=(I-K*H)*Pp  
    xp = A.phi_kalman;
% End or function