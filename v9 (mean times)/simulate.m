function result = simulate(controller, x_desired,y_desired,z_desired)
    %SET DEFAULT DESIRED COORDINATES
    if nargin<2
        x_desired=100;
        y_desired=100;
        z_desired=100;
    end

    %SIMULATION TIMES

    start_time = 0;
    end_time = 120;
    dt = 0.02;
    times = start_time:dt:end_time;
    N = numel(times);    
   
    %DEFINE PHYSICAL CONSTANTS (FOR A HYPOTHETICAL QUADCOPTER)
    
    g = 9.81;
    m = 0.5;
    L = 0.25;
    k = 3e-6;
    b = 1e-7;
    I = diag([5e-3, 5e-3, 10e-3]);
    kd = 0.25;

    %INITIAL SIMULATION STATE

    %the x vector triple denotes quadcopter position
    x=[0 0 10].';

    %now create empty triples for xdot (time derivate of x) and theta
    %(orientation of the quadcopter using the Euler angles). 

    xdot=zeros(3,1);
    theta=zeros(3,1);

    %thetadot denotes the angular velocities which can be set to an initial
    %disturbance.

    if nargin==0
        thetadot=zeros(3,1);
    else
%        thetadot=deg2rad(randi([-90,90],3,1));
       thetadot=zeros(3,1);
       thetadot=[0.6;0.6;0.6];
    end
    
    %CREATE ARRAYS AND STRUCTURED ARRAY FOR THE OUTPUTS
    
    xout=zeros(3,N);
    xdotout=zeros(3,N);
    thetaout=zeros(3,N);
    thetadotout=zeros(3,N);
    inputout=zeros(4,N);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %These arrays are to store data that is not critical for controller
    %simulation but is needed for secondary graphs (used in controller
    %design).
    
    phi_desout=zeros(1,N);
    theta_desout=zeros(1,N);
    errors=zeros(3,N);
    thrust=zeros(1,N);
    integralerrors=zeros(6,N);
    risetime=0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %PARAMETERS FOR THE CONTROLLER
    controller_params = struct('dt',dt,'I',I,'k',k,'L',L,'b',b,'m',m,'g',g,...
        'xdes',x_desired,'ydes',y_desired,'zdes',z_desired);  

    %STEP THROUGH SIMULATION, UPDATING STATE OF QUADCOPTER
    
    count=0;
    graphendtime=0;
    graphendcount=0;

    for t = times
        count=count+1;
        
        controller_params.xdot=xdot;
        controller_params.x=x;
        
        %Here we need to take an input from the controller, or if no
        %controller is specified then we can use some default input. The
        %inputs are values of gamma (angular velocity^2) for each propeller
             
        if nargin==0
            in=zeros(4,1);
            in(1)=700;
            in(2)=750;
            in(3)=700;
            in(4)=750;
            in=in.^2;
        else
            [in,controller_params] = controller(controller_params,thetadot);
        end

        %COMPUTE FORCES, TORQUES AND ACCELERATIONS
        
        %Define angular velocity, omega
        omega = thetadot2omega(thetadot,theta);
        %Define acceleration, a
        a=acceleration(in, theta, xdot, m, g, k, kd);
        %Define anglular acceleration, omegadot
        omegadot=angular_acceleration(in,omega,I,L,b,k);
        
        %STORE RISE TIME
        if risetime==0
            if x(1)>0.95*x_desired && x(1)<1.05*x_desired...
                    && x(2)>0.95*y_desired && x(2)<1.05*y_desired...
                    && x(3)>0.95*z_desired && x(3)<1.05*z_desired
                risetime=times(count);
            end
        end
        
        %STORE GRAPH END TIME
        if risetime ~= 0
            graphendtime=risetime+10;
            if graphendcount==0
                if times(count)>graphendtime
                    graphendcount=count;
                end
            end
        end
                  
        %ADVANCE SYSTEM STATE
        
        omega = omega + omegadot*dt;
        thetadot = omega2thetadot(omega,theta);
        theta = theta + thetadot*dt;
        xdot = xdot + a*dt;
        x = x + xdot*dt;
        
        %STORE SIMULATION STATE FOR OUTPUT
        xout(:,count)=x;
        xdotout(:,count)=xdot;
        thetaout(:,count)=theta;
        thetadotout(:,count)=thetadot;
        inputout(:,count)=in;
        phi_desout(:,count)=controller_params.phi_des;
        theta_desout(:,count)=controller_params.theta_des;
        errors(:,count)=controller_params.errors;
        thrust(:,count)=controller_params.thrust;
        %integralerrors(:,count)=controller_params.integral;
        
    end
    
        
    %PUT OUTPUT INFORMATION INTO A STRUCTURED ARRAY:
    result = struct('x',xout,'theta',thetaout,'vel',xdotout,'angvel'...
        ,thetadotout,'t',times, 'dt',dt,'input',inputout,'phides'...
        ,phi_desout,'thetades',theta_desout,'errors',errors,'thrust',thrust...
        ,'integralerrors',integralerrors,'risetime',risetime...
        ,'gecount',graphendcount');  
    
    %PLOT RESULTS
    grapher(result)

    
    
    

    
    

         
       
        
 end