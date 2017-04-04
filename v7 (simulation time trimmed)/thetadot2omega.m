function omega = thetadot2omega(thetadot,angles)
    phi=angles(1);
    theta=angles(2);
    psi=angles(3);
    
    A=zeros(3);
    A(1,:)=[
        1
        0 
        -sin(theta)
        ];
    A(2,:) =[
        0 
        cos(phi) 
        cos(theta)*sin(phi)
        ];
    A(3,:) =[
        0 
        -sin(phi) 
        cos(phi)*cos(theta)
        ];
    
    omega=A*thetadot;
        
        
%This function converts time derivatives of roll, pitch and yaw into
%angular velocity. A is the necessary rotation matrix for this operation.
%We can define the reverse function omega2thetadot using the inverse of
%this matrix if desired.

end

