function omegadot = angular_acceleration(inputs,omega,I,L,b,k)
    tau=torques(inputs,L,b,k);
    
    %Now use the Euler equation for rigid body motion to obtain angular
    %acceleration:
    
    omegadot=inv(I)*(tau-cross(omega,I*omega));


end

