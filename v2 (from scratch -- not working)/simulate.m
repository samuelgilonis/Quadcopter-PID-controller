function simulate()

    m=0.5;  %mass of quadcopter
    g=9.81; %gravitational acceleration
    l=0.25; %length of quadcopter arms
    K=3e-6; %thrust constant of proportionality
    B=1e-7; %drag constant of proportionality
    I=diag([5e-3, 5e-3, 10e-3]);    %symmetrical inertial matrix

    Cx=0.25;    %frictional coefficients
    Cy=0.25;
    Cz=0.25;

    start_time=0;   %simulation times
    end_time=5;
    dt=0.005;

    times=start_time:dt:end_time;
    N=numel(times);

    position=[0;0;10];
    orientation=zeros(3,1);
    velocities=zeros(3,1);

    phi_des=0;  %defining the desired orientation of the quadcopter
    theta_des=0;
    psi_des=0;
    desired_orientation=[phi_des;theta_des;psi_des];


    eulerdot=deg2rad(randi([-90,90],3,1)); %eulerdot represents the time
                                           %derivatives of the Euler angles. 
                                           %this line sets an initial
                                           %disturbance for the controller to 
                                           %stabilise.

    %Now create arrays for the outputs
    position_out=zeros(3,N);
    velocity_out=zeros(3,N);
    orientation_out=zeros(3,N);
    eulerdot_out=zeros(3,N);
    inputs_out=zeros(4,N);
    PE_out=zeros(3,N);

    ind=0; %creates a counter for the for-loop to help store ouputs

    for t = times
        ind=ind+1;

        %Caculate acceleration and angular acceleration

       [inputs,previous_error2] = PD(m,g,K,B,I,l,start_time,end_time,...
    dt,orientation,desired_orientation,eulerdot);

        previous_error=previous_error2;

        acc=acceleration(orientation,m,K,inputs,velocities,Cx,Cy,Cz,g);

        angular_velocities=thetadot2omega(eulerdot,orientation);

        ang_acc=angular_acceleration(I,l,K,B,inputs,angular_velocities);

        %Advance system state

        angular_velocities=angular_velocities+ang_acc*dt;
        eulerdot=omega2thetadot(angular_velocities,orientation);
        orientation=orientation+eulerdot*dt;
        velocities=velocities+acc*dt;
        position=position+velocities*dt;

        %Store simulation state for ouput
        position_out(:,ind)=position;
        velocity_out(:,ind)=velocities;
        orientation_out(:,ind)=orientation;
        eulerdot_out(:,ind)=eulerdot;
        inputs_out(:,ind)=inputs;
        PE_out(:,ind)=previous_error;
        
    end
    
    %Store outputs in a structured array
    result = struct('position',position_out,'orientation',orientation_out...
        ,'velocity',velocity_out,'angvel',eulerdot_out,'t',times, 'dt',dt,'input',inputs_out)
    
    figure;
    %Keeps the plots on the same graph
    plots = [subplot(2,1,1), subplot(2,1,2)];
    %Creates 3 plots for the 3D visualisation and for angular velocity and
    %displacement against time.
    
    %Plot results
    for t = 1:2:length(result.t);
        subplot(plots(1));
        multiplot(result, result.angvel, t);
        xlabel('Time (s)');
        ylabel('Angular Velocity (rad/s)');
        title('Angular Velocity');

        subplot(plots(2));
        multiplot(result, result.orientation, t);
        xlabel('Time (s)');
        ylabel('Angular Displacement (rad)');
        title('Angular Displacement');
    end
    
end








