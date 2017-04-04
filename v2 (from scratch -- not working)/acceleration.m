function a= acceleration(orientation,m,K,inputs,velocities,Cx,Cy,Cz,g);

    gravity = [0 0 -g].';
    thrust_FB = [0; 0; K*sum(inputs)]; %thrust in the body-fixed frame
    R = rotation(orientation); %rotation matrix to map vectors from F_B to F_I
    thrust_FI = R*thrust_FB; %thrust in the inertial frame
    drag = [-Cx*velocities(1);-Cy*velocities(2);-Cz*velocities(3)];

    a = gravity + 1/m*thrust_FI + 1/m*drag;
    
    %This function computes the acceleration of the quadcopter based upon
    %its orientation, mass, thrust proportionality constant, inputs (the
    %squares of each propeller's angular velocity, the linear velocity, the
    %drag constants and the acceleration due to gravity.

end