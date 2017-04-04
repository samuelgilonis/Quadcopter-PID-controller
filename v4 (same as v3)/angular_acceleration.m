function omegadot = angular_acceleration(inputs,omega,I,L,b,k)

    i1=inputs(1);
    i2=inputs(2);
    i3=inputs(3);
    i4=inputs(4);
    
    p=omega(1);
    q=omega(2);
    r=omega(3);
    
    Ixx=I(1,1);
    Iyy=I(2,2);
    Izz=I(3,3);
    
    actuator_action = [
        L*k*(i1-i3)
        L*k*(i2-i4)
        b*(i1-i2+i3-i4)
        ];
    
    dragtorque=[
        0
        0
        b*(i1-i2+i3-i4)
        ];
    
    gyrotorque=[
        (Iyy-Izz)*q*r
        (Izz-Ixx)*p*r
        (Ixx-Iyy)*p*q
        ];
    
    tau = actuator_action+dragtorque+gyrotorque;
    
    %Now use the Euler equation for rigid body motion to obtain angular
    %acceleration:
    
    omegadot=inv(I)*(actuator_action-cross(omega,I*omega));


end




