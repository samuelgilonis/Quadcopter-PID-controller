function thetadot = omega2thetadot(omega,angles)
    phi=angles(1);
    theta=angles(2);
    psi=angles(3);
    
    A=zeros(3);
    A=[1 0 -sin(theta);0 cos(phi) cos(theta)*sin(phi);0 -sin(phi) cos(phi)*sin(phi)];
    
    W=inv(A);
    thetadot=W*omega;
    
    %This function converts from angular velocity to the time derivatives
    %of roll, pitch and yaw.
end
