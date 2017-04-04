function a = acceleration(inputs,angles,velocities,m,g,k,kd)

%The acceleration of the quadcopter is a function of gravity, the thrust
%and drag forces. From our model we have (a is the acceleration vector, v 
%is the velocity vector):

%m*a=[0 0 -mg].' + T_I +F_D
%   =[0 0 -mg].' + R*T_B + F_D
% therefore a = [0 0 -g].' + 1/m*(R*[0 0 k*sum(angular accelerations^2)] +
% kd*v)

%The angular velocities are the inputs, thrust (T is in F_B) is a function 
%of angular velocity and k. 

    gravity = [0 0 -g].';
    R = rotation(angles);
    T = R*thrust(inputs,k);
    Fd = -kd*velocities;
    
    a = [0 0 -g].' +1/m*T +1/m*Fd;
    

end

