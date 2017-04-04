function c = PID()
    c = @(state, thetadot) pid_controller(state, thetadot);
end

function [inputs,state] = pid_controller(state, thetadot)
    %the "state" argument is the structured array from which the controller
    %must access the necessary information. This is the controller_params
    %struct in the simulator code.
    
    %Gain Parameters
    Kp_phi = 5;
    Kd_phi = 4;
    Ki_phi = 0;

    Kp_theta = Kp_phi;
    Kd_theta = Kd_phi;
    Ki_theta = Ki_phi;

    Kp_psi = 5;
    Kd_psi = 4;
    Ki_psi = 0.06;

    Kp_x = 0.3*pi/180;
    Kd_x = 0.5*pi/180;
%     Ki_x = 1.5e-4*pi/180;
    Ki_x = 0.0;

    Kp_y = Kp_x;
    Kd_y = Kd_x;
%     Ki_y = Ki_x;
    Ki_y = 0.0;

    Kp_z = 1.2e6;
    Kd_z = -2.4e6;
    Ki_z = 2.0e5;

    %Create the theta (orientation) vector in the structured array if it does
    %not yet exist. This will be updated each time this code is run in the
    %simulator for-loop.
    if ~isfield(state,'orientation')
        state.orientation = zeros (3,1);
    end
    
    if ~isfield(state,'errors')
        state.errors = zeros (3,1);
    end
    
    if ~isfield(state,'integral')
        state.integral = zeros (6,1);
    end

    %Now create the inputs that will be sent to the quadcopter.
    %There are four inputs (an angular velocity^2 for each prop)
    inputs = zeros(4,1);

    %Now extract from the structured array the necessary information to compute
    %the inputs.
    
    x_des=state.xdes;
    y_des=state.ydes;
    z_des=state.zdes;
    
    x=state.x(1);
    y=state.x(2);
    z=state.x(3);
    
    error_x=x_des-x;
    error_y=y-y_des;
    error_z=z_des-z;
    errors=[error_x;error_y;error_z];
    
    vels=state.xdot;
    xdot=vels(1);
    ydot=vels(2);
    zdot=vels(3);
    
    errordot_x=xdot;
    errordot_y=-ydot;
    errordot_z=zdot;
        
    int_x=state.integral(1);
    int_y=-state.integral(2);
    int_z=state.integral(3);
    int_phi=state.integral(4);
    int_theta=state.integral(5);
    int_psi=state.integral(6);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %The roll and pitch angles give y and x motion respectively. Therefore
    %PD controllers governing the desired roll and pitch angles can allow us to control x and y
    %positions.
       
    phi_des= Kp_y*error_y + Kd_y*errordot_y + Ki_y*int_y;
    if phi_des>pi/4
        phi_des=pi/4;
    end
    if phi_des<-pi/4
        phi_des=-pi/4;
    end
    
    theta_des= Kp_x*error_x + Kd_x*errordot_x + Ki_x*int_x;
    if theta_des>pi/4
        theta_des=pi/4;
    end
    if theta_des<-pi/4
        theta_des=-pi/4;
    end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     phi_des= 0.0;
%     theta_des=0.0;
    psi_des=0.0;
    
    phi=state.orientation(1);
    theta=state.orientation(2);
    psi=state.orientation(3);
    
    phidot=thetadot(1);
    thetadot2=thetadot(2);
    psidot=thetadot(3);
    
    error_phi=phi_des-phi;
    error_theta=theta_des-theta;
    error_psi=psi_des-psi;
    
    e = zeros(3,1);
    e(1)=Kp_phi*-error_phi+Kd_phi*phidot+Ki_phi*int_phi;
    e(2)=Kp_theta*-error_theta+Kd_theta*thetadot2+Ki_theta*int_theta;
    e(3)=Kp_psi*-error_psi+Kd_psi*psidot+Ki_psi*int_psi;

    e_phi=e(1);
    e_theta=e(2);
    e_psi=e(3);

    Ixx=state.I(1,1);
    Iyy=state.I(2,2);
    Izz=state.I(3,3);

    b=state.b;
    k=state.k;
    L=state.L;
    m=state.m;
    g=state.g;
    dt=state.dt;
    
    allerrors=[error_x;error_y;error_z;error_phi;error_theta;error_psi];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Now compute total thrust (to simplify input equations)
    
    %To have attitude control (z-axis motion) we are going to need a
    %controller to govern the thrust. If thrust = m*g/(k*cos(phi)*cos(theta));
    %then the quadcopter will always be kept at a level altitude but we
    %want to be able to have the altitude as an input.
    
    thrust=Kp_z*error_z + Kd_z*errordot_z + Ki_z*int_z;
    if thrust<0
        thrust=0;
    end
    
    % thrust = m*g/(k*cos(phi)*cos(theta));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Now compute the propeller angular velocities for a given orientation.
    inputs(1)= thrust/4 - (2*b*e_phi*Ixx + k*L*e_psi*Izz)/(4*b*L*k);
    inputs(2)= thrust/4 - (2*b*e_theta*Iyy - k*L*e_psi*Izz)/(4*b*L*k);
    inputs(3)= thrust/4 - (-2*b*e_phi*Ixx + k*L*e_psi*Izz)/(4*b*L*k);
    inputs(4)= thrust/4 + (2*b*e_theta*Iyy + k*L*e_psi*Izz)/(4*b*L*k);

    %Now advance the controller state (this essentially means updating the
    %orientation vector:

    state.orientation = state.orientation + state.dt*thetadot;
    state.integral = state.integral + dt*allerrors;
    state.phi_des=phi_des;
    state.theta_des=theta_des;
    state.errors=errors;
    state.thrust=thrust;
   
end

