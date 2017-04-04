%This is the simulation environment in which one may test controllers for
%the quadcopter. It takes an input from the controller, which will be on a 
%separate script) which will be some function of time.
function result = simulate(controller, start_time, end_time, dt)

    %SIMULATION TIMES

    %This creates an array of times from the start time to the end time in
    %increments of dt. Therefore times(5) will, in the case that the start
    %time=0, end time=0 and dt=0.005, yield the value 0.02 as the first value
    %in the array is 0. The default times are set below in case the user
    %does not input them. The 'nargin' function counts the number of
    %arguments inputted by the user.

    if nargin<4
        start_time = 0;
        end_time = 90;
        dt = 0.005;
    end

    times = start_time:dt:end_time;
    
   
    %DEFINE PHYSICAL CONSTANTS (FOR A HYPOTHETICAL QUADCOPTER
    
    %From the model we need to know the following about the quadcopter and
    %its environment: gravitational accelaration, mass of quadcopter,
    %length from centre of quadcopter to centre of propellers, the constant
    %k that relates the thrust to the square of the angular velocity, the
    %constant b that relates the torque from drag to the square of angular
    %velocity, the inertia matrix for the quadcopter, the constant kd that
    %relates drag to linear velocity. 
    
    g = 9.81;
    m = 0.5;
    L = 0.25;
    k = 3e-6;
    b = 1e-7;
    I = diag([5e-3, 5e-3, 10e-3]);
    kd = 0.25;
    
    %Number of points in the simulation (i.e. the number of points at which the
    %position and orientation of the quadcopter are evaluate)
    %This is given by the inbuilt function 'numel' which gives number of
    %elements in an array

    N = numel(times);

    %INITIAL SIMULATION STATE

    %the x vector triple denotes quadcopter position,where the 'z' value starts
    %at ten so that it is elevated from the floor. (ground effect is not taken
    %into account in this model so this is probably not necessary). The (.')
    %operand denotes transpose so that x is a column vector. We could also habe
    %written x= [0;0;10];

    x=[0 0 10].';

    %now create empty triples for xdot (time derivate of x) and theta
    %(orientation of the quadcopter using the Euler angles). This is done using
    %the 'zeros' function which creates matrices of zeros. E.g. zeros(m,n)
    %creates a matrix with m rows and n columns where all entries are zero.

    xdot=zeros(3,1);
    theta=zeros(3,1);

    %If we are not simulating wit a controler then we would not want a 
    %disturbance but if we are then we want the initial simulation state of
    %the thetadot triple to be some disturbance in the angular velocity. 
    %The following code creates a random angular velocity about each of the
    %Euler angles between 90 deg/s and -90deg/s

    if nargin==0
        thetadot=zeros(3,1);
    else
        thetadot=deg2rad(randi([-90,90],3,1));
    end

    %We have now set the initial simulation state, meaning the position,
    %orientation and initial angular velocity of the quadcopter. 
    
    %CREATE ARRAYS AND STRUCTURED ARRAY FOR THE OUTPUTS
    
    %The arrays for the ouputs each have 3 components and we need to record
    %there values for each 'time', therefore we need N of them so we use
    %3xN matrices. The input from the controller wil have 4 components
    %therefore it is a 4xN matrix
    
    xout=zeros(3,N);
    xdotout=zeros(3,N);
    thetaout=zeros(3,N);
    thetadotout=zeros(3,N);
    inputout=zeros(4,N);
    
    %PARAMETERS FOR THE CONTROLLER
    controller_params = struct('dt',dt,'I',I,'k',k,'L',L,'b',b,'m',m,'g',g);  

    %STEP THROUGH SIMULATION, UPDATING STATE OF QUADCOPTER

    %We do this using a for-loop telling MatLab to run through the calculations
    %for every time. 
    
    %First create a counter that keeps track of which iteration the program
    %is in.
    
    count=0;

    for t = times
        count=count+1;
        
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
        
        %ADVANCE SYSTEM STATE
        
        %This is coded in the reverse order of what would seem intuitive so
        %that the code has updated versions of each variable that it needs.
        
        omega = omega + omegadot*dt;
        thetadot = omega2thetadot(omega,theta);
        theta = theta + thetadot*dt;
        xdot = xdot + a*dt;
        x = x + xdot*dt;
        
        %The for-loop will cycle through this N times for every time
        %increment. We now need to store these values so that they can be
        %plotted:
        
        %STORE SIMULATION STATE FOR OUTPUT
        xout(:,count)=x;
        xdotout(:,count)=xdot;
        thetaout(:,count)=theta;
        thetadotout(:,count)=thetadot;
        inputout(:,count)=in;
        
        
        
        
    end
        
    
    %PUT OUTPUT INFORMATION INTO A STRUCTURED ARRAY:
    result = struct('x',xout,'theta',thetaout,'vel',xdotout,'angvel',thetadotout,'t',times, 'dt',dt,'input',inputout);  
    
    grapher(result)
    

         
       
        
 end