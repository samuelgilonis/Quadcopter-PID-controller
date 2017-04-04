function tau = torques(inputs,L,b,k);
%Note that inputs here denote the gamma values (angular velocity^2) NOT
%angular velocity itself.
    tau = [
        L*k*(inputs(1)-inputs(3))
        L*k*(inputs(2)-inputs(4))
        b*(inputs(1)-inputs(2)+inputs(3)-inputs(4))
        ];
        
%This function computes the torques on the quadcopter in F_B based upon the
%angular velocities of each propeller.


end

