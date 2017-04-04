function in = arbitrary_inputs()
    in=zeros(4,1);
    in(1)=700;
    in(2)=750;
    in(3)=700;
    in(4)=750;
    in=in.^2;
%These are arbitrary test inputs that are not based on any controller, in
%order to test the simulator. If there was any disturbance then the
%quadcopter would catastrophically fail.

%The values shown after in(i) are the angular velocities of each propeller
%which are then squared to obtain the gamma value for simpler notation.


end

