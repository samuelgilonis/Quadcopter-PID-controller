function xhat = Kalman_function1(z,xpp,RR,QQ)
persistent Pp Q R xp A H I
if isempty(Pp)
    Pp=1;     Q=QQ;    R=RR;     
    xp=xpp;    A=0.5;      H=1;     I=eye(1); 
end 
% Compute priori
    xp=A*xp;
    Pp=A*Pp*A'+Q;
% Measurement update 
    K = Pp*H'*inv(H*Pp*H'+R);
    xhat = xp+K*(z-H*xp);
% Update covariance  
    Pp=(I-K*H)*Pp;  
    xp = xhat;
% End or function