% Muhannad Al-Omari
% AUS

% In this script we will define all the variables that will be used in the
% simulation platform.

% Also we will build the Quadrotor model here.


% clear all
global A

% 3d Quadmodel
copter_model_3D


% Camera
A.Camera_View = 0;
A.psi_cam = 0;

% Invironment parametes
A.g = 9.81;     % Gravity
A.m = 1;      % Quadrotor mass
A.Ts = .01;     % Sampling time (50 Hz)
A.init = 0;     % used in initilization 

A.b = 54.2E-6;    % Lift force coeffecient
A.l = .24;     % Radius of the Quadrotor
A.d = 1.1E-6;    % Drag force coeffecient

A.Motors_limit = 500^2; % motors upper limit
A.Motors_lowerlimit = -1*((400)^2); % motors lower limit

% PID parameters

% A.Z_KP = .9;      % KP value in altitude control
% A.Z_KI = 0.3;     % KI value in altitude control
% A.Z_KD = 1.9;     % KD value in altitude control

A.Z_KP = 10/1.7;    % KP value in altitude control
A.Z_KI = 2/1.98;    % KI value in altitude control
A.Z_KD = 12/1.980;  % KD value in altitude control

A.X_KP = 5*pi/180;          % KP value in X_position control
A.X_KD = -1*pi/180;         % KD value in X_position control

A.Y_KP = 5*pi/180;          % KP value in Y_position control
A.Y_KD = -1*pi/180;         % KD value in Y_position control

A.phi_KP = 12;      % KP value in roll control
A.phi_KI = 3;     % KI value in roll control            it was .02 !!!!!!!
A.phi_KD = -.5;     % KD value in roll control

% A.phi_KP = .4;   % KP value in roll control
% A.phi_KI = .1; % KI value in roll control
% A.phi_KD = -.07; % KD value in roll control

A.theta_KP = 12;    % KP value in pitch control
A.theta_KI = 3;     % KI value in pitch control
A.theta_KD = -.5;   % KD value in pitch control

% A.theta_KP = .4;  % KP value in pitch control
% A.theta_KI = .1;  % KI value in pitch control
% A.theta_KD = -.07; % KD value in pitch control

% A.psi_KP = .5; % KP value in yaw control
% A.psi_KI = 0.1;  % KI value in yaw control
% A.psi_KD = -0.5; % KD value in yaw control

A.psi_KP = 1.6;     % KP value in yaw control
A.psi_KI = .15;     % KI value in yaw control
A.psi_KD = -.2;     % KD value in yaw control

% dirty derivative parameter
A.tau = 1/5;
  
% Initial conditions
A.X = 0;        % Initial position in X direction EF
A.Y = 0;        % Initial position in Y direction EF
A.X_BF = 0;        % Initial position in X direction BF
A.Y_BF = 0;        % Initial position in Y direction BF
A.Z = 0;        % Initial position in Z direction EF

A.X_dot = 0;    % Initial velocity in X direction EF
A.Y_dot = 0;    % Initial velocity in Y direction EF
A.X_dot_BF = 0;    % Initial velocity in X direction BF
A.Y_dot_BF = 0;    % Initial velocity in Y direction BF
A.Z_dot = 0;    % Initial velocity in Z direction EF

A.p = 0;        % Initial p value (angular rate rotation about X BF)
A.q = 0;        % Initial q value (angular rate rotation about Y BF)
A.r = 0;        % Initial r value (angular rate rotation about Z BF)

A.phi = 0;      % Initial phi value (rotation about X EF)
A.theta = 0;    % Initial theta value (rotation about Y EF)
A.psi = 0;      % Initial psi value (rotation about Z EF)

A.Z_kalman = 0;   % Initial kalman filter Z value
A.X_kalman = 0;   % Initial kalman filter X value
A.Y_kalman = 0;   % Initial kalman filter Y value
A.phi_kalman = 0;   % Initial kalman filter phi value (rotation about X EF)
A.theta_kalman = 0;   % Initial kalman filter theta value (rotation about Y EF)
A.psi_kalman = 0;   % Initial kalman filter psi value (rotation about Z EF)

A.Ixx = 8.1E-3;     % Inertia about X axis
A.Iyy = 8.1E-3;     % Inertia about Y axis
A.Izz = 14.2E-3;    % Inertia about Z axis
A.Jtp = 104E-6;     % Propelers inertia

A.U1 = 0;       % Thrust
A.U2 = 0;       % Torque about X axis BF
A.U3 = 0;       % Torque about Y axis BF
A.U4 = 0;       % Torque about Z axis BF
A.O = 0;        % sum of all motor speeds

A.O1 = 0;       % Front motor speed
A.O2 = 0;       % Right motor speed
A.O3 = 0;       % Rear motor speed
A.O4 = 0;       % Left motor speed

% Desired variables
A.Z_des = 0;            % desired value of Z
A.X_des_EF = 0;         % desired value of X in Earth frame
A.Y_des_EF = 0;         % desired value of Y in Earth frame
A.X_des = 0;            % desired value of X in Body frame
A.Y_des = 0;            % desired value of Y in Body frame

A.phi_des = 0;          % desired value of phi
A.theta_des = 0;    % desired value of theta
A.psi_des = 0;          % desired value of psi

% Quadrotor Model

% % Body frame (Front and Rear side)
% A.X1 = [-A.l A.l]+A.X;    
% A.Y1 = [0 0]+A.Y;
% A.Z1 = [0 0]+A.Z;
% [A.X1,A.Y1,A.Z1]=rotateXYZ(A.X1,A.Y1,A.Z1,A.phi,A.theta,A.psi);
% 
% % Front propeler
% A.FPX = [.1*cos(0) .1*cos(pi/4) .1*cos(pi/2) .1*cos(3*pi/4) .1*cos(pi) .1*cos(5*pi/4) .1*cos(6*pi/4) .1*cos(7*pi/4) .1*cos(2*pi)]+A.l+A.X;  % Front propoler X
% A.FPY = [.1*sin(0) .1*sin(pi/4) .1*sin(pi/2) .1*sin(3*pi/4) .1*sin(pi) .1*sin(5*pi/4) .1*sin(6*pi/4) .1*sin(7*pi/4) .1*sin(2*pi)]+A.Y;         % Front propoler Y
% A.FPZ = [0 0 0 0 0 0 0 0 0]+A.Z;         % Front propoler Z
% [A.FPX,A.FPY,A.FPZ]=rotateXYZ(A.FPX,A.FPY,A.FPZ,A.phi,A.theta,A.psi);
% 
% % Rear propeler
% A.RPX = [.1*cos(0) .1*cos(pi/4) .1*cos(pi/2) .1*cos(3*pi/4) .1*cos(pi) .1*cos(5*pi/4) .1*cos(6*pi/4) .1*cos(7*pi/4) .1*cos(2*pi)]-A.l+A.X;  % Rear propoler X
% A.RPY = [.1*sin(0) .1*sin(pi/4) .1*sin(pi/2) .1*sin(3*pi/4) .1*sin(pi) .1*sin(5*pi/4) .1*sin(6*pi/4) .1*sin(7*pi/4) .1*sin(2*pi)]+A.Y;         % Rear propoler Y
% A.RPZ = [0 0 0 0 0 0 0 0 0]+A.Z;         % Rear propoler Z
% [A.RPX,A.RPY,A.RPZ]=rotateXYZ(A.RPX,A.RPY,A.RPZ,A.phi,A.theta,A.psi);
% 
% % Body frame (Right and Left side)
% A.X2 = [0 0]+A.X;    
% A.Y2 = [-A.l A.l]+A.Y;
% A.Z2 = [0 0]+A.Z;
% [A.X2,A.Y2,A.Z2]=rotateXYZ(A.X2,A.Y2,A.Z2,A.phi,A.theta,A.psi);
% 
% % Right propeler
% A.rPX = [.1*cos(0) .1*cos(pi/4) .1*cos(pi/2) .1*cos(3*pi/4) .1*cos(pi) .1*cos(5*pi/4) .1*cos(6*pi/4) .1*cos(7*pi/4) .1*cos(2*pi)]+A.X;  % Right propoler X
% A.rPY = [.1*sin(0) .1*sin(pi/4) .1*sin(pi/2) .1*sin(3*pi/4) .1*sin(pi) .1*sin(5*pi/4) .1*sin(6*pi/4) .1*sin(7*pi/4) .1*sin(2*pi)]+A.l+A.Y;         % Right propoler Y
% A.rPZ = [0 0 0 0 0 0 0 0 0]+A.Z;         % Right propoler Z
% [A.rPX,A.rPY,A.rPZ]=rotateXYZ(A.rPX,A.rPY,A.rPZ,A.phi,A.theta,A.psi);
% 
% % Left propeler
% A.LPX = [.1*cos(0) .1*cos(pi/4) .1*cos(pi/2) .1*cos(3*pi/4) .1*cos(pi) .1*cos(5*pi/4) .1*cos(6*pi/4) .1*cos(7*pi/4) .1*cos(2*pi)]+A.X;  % Left propoler X
% A.LPY = [.1*sin(0) .1*sin(pi/4) .1*sin(pi/2) .1*sin(3*pi/4) .1*sin(pi) .1*sin(5*pi/4) .1*sin(6*pi/4) .1*sin(7*pi/4) .1*sin(2*pi)]-A.l+A.Y;   % Left propoler Y
% A.LPZ = [0 0 0 0 0 0 0 0 0]+A.Z;         % Left propoler Z
% [A.LPX,A.LPY,A.LPZ]=rotateXYZ(A.LPX,A.LPY,A.LPZ,A.phi,A.theta,A.psi);
% 
% A.L1 = line(A.X1,A.Y1,A.Z1,'linewidth',3,'color','b');
% A.L2 = line(A.X2,A.Y2,A.Z2,'linewidth',3,'color','r');
% A.L3 = line(A.FPX,A.FPY,A.FPZ,'linewidth',3,'color','g');
% A.L4 = line(A.RPX,A.RPY,A.RPZ,'linewidth',3,'color','k');
% A.L5 = line(A.rPX,A.rPY,A.rPZ,'linewidth',3,'color','k');
% A.L6 = line(A.LPX,A.LPY,A.LPZ,'linewidth',3,'color','k');

% dummy variables
A.X22 = 0;
A.Y22 = 0;
A.Z22 = 0;
A.var1 = 0;

% plotting variables                % they will remain up to 10 min
A.Z_plot = zeros(1,60*10/A.Ts);      % the Z actual value
A.Z_ref_plot = zeros(1,60*10/A.Ts);  % the Z reference value
A.Z_dis_plot = zeros(1,60*10/A.Ts);  % the Z disturbance value
A.Z_kalman_plot = zeros(1,60*10/A.Ts);  % the Z kalman value

A.X_plot = zeros(1,60*10/A.Ts);      % the X actual value
A.X_ref_plot = zeros(1,60*10/A.Ts);  % the X reference value
A.X_dis_plot = zeros(1,60*10/A.Ts);  % the X disturbance value
A.X_kalman_plot = zeros(1,60*10/A.Ts);  % the X kalman value

A.Y_plot = zeros(1,60*10/A.Ts);      % the Y actual value
A.Y_ref_plot = zeros(1,60*10/A.Ts);  % the Y reference value
A.Y_dis_plot = zeros(1,60*10/A.Ts);  % the Y disturbance value
A.Y_kalman_plot = zeros(1,60*10/A.Ts);  % the Y kalman value

A.phi_plot = zeros(1,60*10/A.Ts);      % the phi actual value
A.phi_ref_plot = zeros(1,60*10/A.Ts);  % the phi reference value
A.phi_dis_plot = zeros(1,60*10/A.Ts);  % the phi disturbance value
A.phi_kalman_plot = zeros(1,60*10/A.Ts);  % the phi kalman value

A.theta_plot = zeros(1,60*10/A.Ts);      % the theta actual value
A.theta_ref_plot = zeros(1,60*10/A.Ts);  % the theta reference value
A.theta_dis_plot = zeros(1,60*10/A.Ts);  % the theta disturbance value
A.theta_kalman_plot = zeros(1,60*10/A.Ts);  % the theta kalman value

A.psi_plot = zeros(1,60*10/A.Ts);      % the phi actual value
A.psi_ref_plot = zeros(1,60*10/A.Ts);  % the phi reference value
A.psi_dis_plot = zeros(1,60*10/A.Ts);  % the phi disturbance value
A.psi_kalman_plot = zeros(1,60*10/A.Ts);  % the psi kalman value

A.t_plot = [0:A.Ts:60*10-A.Ts];       % the time values
A.counter = 1;                      % the counter that holds the time value

A.U11_plot = zeros(1,60*10/A.Ts);      % the throttle plot
A.U21_plot = zeros(1,60*10/A.Ts);      % the Roll plot
A.U31_plot = zeros(1,60*10/A.Ts);      % the Pitch plot
A.U41_plot = zeros(1,60*10/A.Ts);      % the Yaw plot

A.U1_plot = zeros(1,60*10/A.Ts);      % the throttle plot
A.U2_plot = zeros(1,60*10/A.Ts);      % the Roll plot
A.U3_plot = zeros(1,60*10/A.Ts);      % the Pitch plot
A.U4_plot = zeros(1,60*10/A.Ts);      % the Yaw plot

A.O1_plot = zeros(1,60*10/A.Ts);      % the front motore plot
A.O2_plot = zeros(1,60*10/A.Ts);      % the right motore plot
A.O3_plot = zeros(1,60*10/A.Ts);      % the rear motore plot
A.O4_plot = zeros(1,60*10/A.Ts);      % the left motore plot


% Disturbanses variables
A.Z_dis = 0;            % disturbance in Z direction
A.X_dis = 0;            % disturbance in X direction
A.Y_dis = 0;            % disturbance in Y direction

A.psi_dis = 0;            % disturbance in Yaw direction
A.theta_dis = 0;            % disturbance in Pitch direction
A.phi_dis = 0;            % disturbance in Roll direction

% Measured varaibled
A.Z_meas = 0;
A.phi_meas = 0;
A.theta_meas = 0;
A.psi_meas = 0;

% Error signal
% rng(1)
A.Z_error = randn(1,60*10/A.Ts)*.02;

% rng(2)
A.phi_error = randn(1,60*10/A.Ts)*.02;

% rng(3)
A.theta_error = randn(1,60*10/A.Ts)*.02;

% rng(4)
A.psi_error = randn(1,60*10/A.Ts)*.02;

% rng(5)
A.X_error = randn(1,60*10/A.Ts)*.01;

% rng(6)
A.Y_error = randn(1,60*10/A.Ts)*.01;

% Flags for plotting and real time
A.flag = 0;

% sines and cosines

A.C_phi = cos(A.phi);
A.C_theta = cos(A.theta);
A.C_psi = cos(A.psi);

A.S_phi = sin(A.phi);
A.S_theta = sin(A.theta);
A.S_psi = sin(A.psi);

