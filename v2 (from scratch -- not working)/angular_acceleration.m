function a = angular_acceleration(I,l,K,B,inputs,angular_velocities)

    i1=inputs(1);
    i2=inputs(2);
    i3=inputs(3);
    i4=inputs(4);

    p=angular_velocities(1);
    q=angular_velocities(2);
    r=angular_velocities(3);
    

    Ixx=I(1,1);
    Iyy=I(2,2);
    Izz=I(3,3);

    actuator_action=[
        l*K*(i2-i4);
        l*K*(i1-i3);
        0;
        ];
    
    dragtorque=[
        0;
        0;
        B*(i1-i2+i3-i4);
        ];
        
%     gyrotorque=[
%         (Iyy-Izz)*q*r;
%         (Izz-Ixx)*p*r;
%         (Ixx-Iyy)*p*q;
%         ];
        
    a = inv(I)*((actuator_action + dragtorque)-cross(angular_velocities,I*angular_velocities)); %+ gyrotorque
    
    %This function computes the angular acceleration of the quadcopter
    %based upon the inertia matrix, the length of the quadcopter arms, the
    %thrust proportionality constant, the inputs (squares of the angular
    %velocities of the propellers) and the angular velocity of the
    %quadcopter.
    
    
end
    