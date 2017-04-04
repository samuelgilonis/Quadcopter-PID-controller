function R = rotation(angles)
    phi=angles(1);
    theta=angles(2);
    psi=angles(3);
    
    R=zeros(3);
    R(1,:) = [
        cos(theta)*cos(psi) 
        cos(psi)*sin(phi)*sin(theta)-cos(phi)*sin(psi) 
        sin(phi)*sin(psi)+cos(phi)*cos(psi)*sin(theta)
    ];
    
    R(2,:) = [
        cos(theta)*sin(psi)
        cos(phi)*cos(psi) + sin(phi)*sin(theta)*sin(psi)
        cos(phi)*sin(theta)*sin(psi)-cos(psi)*sin(phi)
    ];

    R(3,:) = [
        -sin(theta) 
        cos(theta)*sin(phi)
        cos(phi)*cos(theta)
    ];
     
%This rotation matrix maps between the body-fixed frame and the inertial
%frame. 

end

