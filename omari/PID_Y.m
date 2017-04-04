global A

A.Y_des = A.Y_des_EF*cos(A.psi_kalman)-A.X_des_EF*sin(A.psi_kalman);    % calculating the desired X in BF
A.Y_BF = A.Y_kalman*cos(A.psi_kalman)-A.X_kalman*sin(A.psi_kalman);            % calculating X in BF
A.Y_dot_BF = A.Y_dot*cos(A.psi_kalman)-A.X_dot*sin(A.psi_kalman);    % calculating X_dot in BF

% PD controller for X_position
A.phi_des = -1*(A.Y_KP*(A.Y_des - A.Y_BF) + A.Y_KD*A.Y_dot);

if(abs(A.phi_des) > pi/4)        % limiter
    A.phi_des = sign(A.phi_des)*pi/4;
end
