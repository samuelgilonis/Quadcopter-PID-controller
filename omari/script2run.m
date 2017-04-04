function script2run



%-----------------------------------------------------------------------%
%                                                                       %
%   This script simulates a quadrotor.                                  %
%                                                                       %
%   Done By: Muhannad A.R. Al-Omari                                     %
%   Supervised by : Dr. Mohammad Jaradat                                %
%   American University of Sharjah  (AUS)                               %
%                                                                       %
%-----------------------------------------------------------------------%

clear all
clc

global A

figure('units','normalized','position',[.1 .1 .8 .8],'name','Quadrotor AUS','numbertitle','off','color','w');
axes('units','normalized','position',[.2 .1 .6 .8]);
% subplot(2,1,1)
axis equal

%     subplot('position',[0.01, 0.01, 0.6, 0.6]);
%     axis([-1,5,-3,5,-.1, 2]);
%     set(gca,'visible','on')
    
All_Variables;

   quadmodel;
%    Map;
E1 = uicontrol('units','normalized','position',[.11 .85 .1 .07],'style','edit','fontsize',13,'string',0,'backgroundcolor','w');
% E2 = uicontrol('units','normalized','position',[.11 .75 .1 .07],'style','edit','fontsize',13,'string',0,'backgroundcolor','w');
% E3 = uicontrol('units','normalized','position',[.11 .65 .1 .07],'style','edit','fontsize',13,'string',0,'backgroundcolor','w');
E4 = uicontrol('units','normalized','position',[.11 .55 .1 .07],'style','edit','fontsize',13,'string',0,'backgroundcolor','w');
E5 = uicontrol('units','normalized','position',[.11 .45 .1 .07],'style','edit','fontsize',13,'string',0,'backgroundcolor','w');
E6 = uicontrol('units','normalized','position',[.11 .35 .1 .07],'style','edit','fontsize',13,'string',0,'backgroundcolor','w');

uicontrol('units','normalized','position',[.02 .83 .05 .07],'style','text','fontsize',13,'string','Altitude','backgroundcolor','w');
% uicontrol('units','normalized','position',[.02 .73 .05 .07],'style','text','fontsize',13,'string','Roll','backgroundcolor','w');
% uicontrol('units','normalized','position',[.02 .63 .05 .07],'style','text','fontsize',13,'string','Pitch','backgroundcolor','w');
uicontrol('units','normalized','position',[.02 .53 .05 .07],'style','text','fontsize',13,'string','Yaw','backgroundcolor','w');
uicontrol('units','normalized','position',[.02 .43 .05 .07],'style','text','fontsize',13,'string','X','backgroundcolor','w');
uicontrol('units','normalized','position',[.02 .33 .05 .07],'style','text','fontsize',13,'string','Y','backgroundcolor','w');

uicontrol('units','normalized','position',[.11 .25 .1 .07],'style','pushbutton','fontsize',13,'string','Go','callback',@Go1);

% Motors speed
uicontrol('units','normalized','position',[.85 .83 .05 .07],'style','text','fontsize',13,'string','Front M','backgroundcolor',[.5 .7 1]);
uicontrol('units','normalized','position',[.85 .73 .05 .07],'style','text','fontsize',13,'string','Right M','backgroundcolor',[.5 .7 1]);
uicontrol('units','normalized','position',[.85 .63 .05 .07],'style','text','fontsize',13,'string','Rear M','backgroundcolor',[.5 .7 1]);
uicontrol('units','normalized','position',[.85 .53 .05 .07],'style','text','fontsize',13,'string','Left M','backgroundcolor',[.5 .7 1]);

O1 = uicontrol('units','normalized','position',[.91 .86 .08 .05],'style','text','fontsize',13,'string','0','backgroundcolor','w');
O2 = uicontrol('units','normalized','position',[.91 .76 .08 .05],'style','text','fontsize',13,'string','0','backgroundcolor','w');
O3 = uicontrol('units','normalized','position',[.91 .66 .08 .05],'style','text','fontsize',13,'string','0','backgroundcolor','w');
O4 = uicontrol('units','normalized','position',[.91 .56 .08 .05],'style','text','fontsize',13,'string','0','backgroundcolor','w');

% disturbances
% uicontrol('units','normalized','position',[.13+.77 .35 .08 .07],'style','pushbutton','fontsize',13,'string','Z','callback',@d1);
% uicontrol('units','normalized','position',[.02+.77 .35 .08 .07],'style','pushbutton','fontsize',13,'string','Yaw','callback',@d2);
% uicontrol('units','normalized','position',[.13+.77 .25 .08 .07],'style','pushbutton','fontsize',13,'string','Pitch','callback',@d3);
% uicontrol('units','normalized','position',[.02+.77 .25 .08 .07],'style','pushbutton','fontsize',13,'string','Roll','callback',@d4);

pop1 = uicontrol('units','normalized','position',[.02 .15 .19 .07],'style','popupmenu','fontsize',13,'string',{'3D view';'Camera view'},'callback',@view1,'value',1);

axis([-5 5 -5 5 0 2])
view(30,30)
grid on
hold on
%---------- Camera --------------------%


camproj perspective 
camva(25)

hlight = camlight('headlight'); 

lighting gouraud
set(gcf,'Renderer','OpenGL')

line([-1 1],[0 0],[0 0])
line([0 0],[-.5 .5],[0 0],'color','r')

%---------- starting the loop ----------%
while 1
tic;  
%---------- measuring the parameters ----------%
   Z_meas;
   XY_meas;
   IMU_meas;
   
%---------- Kalman filters ----------%
    Kalman_phi2;
    Kalman_theta2;
    Kalman_psi2;
    Kalman_Z2;
    Kalman_X2;
    Kalman_Y2;

%---------- perform PID controllers ----------%
   PID_X;
   PID_Y;
   PID_Z;
   PID_roll;
   PID_pitch;
   PID_heading;
% %       
%    PID_X_NC;
%    PID_Y_NC;
%    PID_Z_NC;
%    PID_roll_NC;
%    PID_pitch_NC;
%    PID_heading_NC;

%----------- limit the motors speed ----------%   
   Motors_Speed;
   Forces;
   
%---------- apply the equations of motion -----------%
   quadmodel;
%    toc
%    for i=1:length(xd)-50

%    end
   
%---------- Calculating Motors speed and displaying it ------------%

   set(O1,'string',num2str(A.O1));
   set(O2,'string',num2str(A.O2));
   set(O3,'string',num2str(A.O3));
   set(O4,'string',num2str(A.O4));
   
%---------- PLotting the quadrotor new position ----------%
   if(A.flag==3)
       
      plot_quad_3D;  
      switch(A.Camera_View)
          case 0
      campos([A.X+2 A.Y+2 A.Z+2])
      camtarget([A.X A.Y A.Z])
      camroll(0);
          case 1
      campos([A.X A.Y A.Z])
      camtarget([A.X+A.Z*sin(A.theta) A.Y+A.Z*sin(A.phi) 0])
      camroll(A.psi*180/pi-A.psi_cam)
      A.psi_cam = A.psi*180/pi;
      end
    

      drawnow
      A.flag=0;
   toc
      while(toc<.03)
      end
   end
   A.flag = A.flag+1;
   
   A.init = 1;  % stop the initilization in my code
end




%---------- Subfunctions -----------%

    function Go1(varargin)
        A.Z_des = str2double(get(E1,'string'));
%         A.phi_des = str2double(get(E2,'string'))*pi/180;
%         A.theta_des = str2double(get(E3,'string'))*pi/180;
        A.psi_des = str2double(get(E4,'string'))*pi/180;
        A.X_des_EF = str2double(get(E5,'string'));
        A.Y_des_EF = str2double(get(E6,'string'));
    end

% disturbances sub functions
%     function d1(varargin)   % disturbance in Z
%         A.Z_dis = -0.2*A.m*A.g;
%     end
% 
%     function d2(varargin)   % disturbance in Yaw
%         A.psi_dis = -200*A.Izz;
%     end
% 
%     function d3(varargin)   % disturbance in Pitch
%         A.theta_dis = -200*A.Iyy;
%     end
% 
%     function d4(varargin)   % disturbance in Roll
%         A.phi_dis = -200*A.Ixx;
%     end


    function view1(varargin)
       A.var1 = get(pop1,'value');
       switch A.var1
           case 1
               A.Camera_View = 0;
           case 2
               A.Camera_View = 1;
       end
    end

end