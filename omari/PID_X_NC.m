global A

A.X_des = A.X_des_EF*cos(A.psi_meas)+A.Y_des_EF*sin(A.psi_meas);    % calculating the desired X in BF

A.X_BF = A.X_meas*cos(A.psi_meas)+A.Y_meas*sin(A.psi_meas);            % calculating X in BF
A.X_dot_BF = A.X_dot*cos(A.psi_meas)+A.Y_dot*sin(A.psi_meas);    % calculating X_dot in BF

% PD controller for X_position
A.theta_des = A.X_KP*(A.X_des - A.X_BF) + A.X_KD*A.X_dot;

if(abs(A.theta_des) > pi/18)        % limiter
    A.theta_des = sign(A.theta_des)*pi/18;
end
