
function g = grapher(result)
    times=result.t;
       
    %SIMULATION DATA FOR PRIMARY GRAPHS    
    xvels=result.vel(1,:);
    yvels=result.vel(2,:);
    zvels=result.vel(3,:);    
       
    phis=result.theta(1,:);
    thetas=result.theta(2,:);
    psis=result.theta(3,:);
    
    phisdot=result.angvel(1,:);
    thetasdot=result.angvel(2,:);
    psisdot=result.angvel(3,:);
    
    risetime=result.risetime;
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %SIMULATION DATA FOR SECONDARY GRAPHS
    phides=result.phides;
    thetades=result.thetades;
    
    xs=result.x(1,:);
    ys=result.x(2,:);
    zs=result.x(3,:);
    
    xerrors=result.errors(1,:);
    yerrors=result.errors(2,:);
    zerrors=result.errors(3,:);
    
    thrust=result.thrust;
    
    xmax=max(xs);
    xmin=min(xs);
    ymax=max(ys);
    ymin=min(ys);
    zmax=max(zs);
    zmin=min(zs);
    
    integralerrors=result.integralerrors;
    intz=integralerrors(3,:);
    intpsi=integralerrors(6,:);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %PRIMARY GRAPHS
    
%     figure;
%     plots=[subplot(2,1,1), subplot(2,1,2)];
%     
%     %ANGULAR VELOCITIES
%     subplot(plots(1));    
%     plot(times,phisdot, 'r', 'Linewidth',1.2)
%     title('Angular Velocities')
%     xlabel('time (s)')
%     ylabel('radians/s')
%     hold on
%     plot(times,thetasdot, '--b', 'Linewidth',1.2)
%     hold on
%     plot(times,psisdot, ':g', 'Linewidth',1.2)
%     legend('Roll','Pitch','Yaw')
%     
%     %ANGULAR DISPLACEMENTS
%     subplot(plots(2));
%     plot(times,phis, 'r', 'Linewidth',1.2)
%     title('Angular Displacements')
%     xlabel('time (s)')
%     ylabel('radians')
%     hold on
%     plot(times,thetas, '--b', 'Linewidth',1.2)
%     hold on
%     plot(times,psis, ':g', 'Linewidth',1.2)
%     
%     figure
%     plots=[subplot(2,1,1), subplot(2,1,2)];
%     %VELOCITIES
%     subplot(plots(1));    
%     plot(times,xvels, '--b', 'Linewidth',1.2)
%     title('Velocities')
%     xlabel('time (s)')
%     ylabel('m/s')
%     hold on
%     plot(times,yvels, 'r', 'Linewidth',1.2)
%     hold on
%     plot(times,zvels, ':g', 'Linewidth',1.2)
%     legend('x','y','z')
%     
%     %DISPLACEMENTS
%     subplot(plots(2));
%     plot(times,xs, '--b', 'Linewidth',1.2)
%     title('Displacements')
%     xlabel('time (s)')
%     ylabel('metres')
%     hold on
%     plot(times,ys, 'r', 'Linewidth',1.2)
%     hold on
%     plot(times,zs, ':g', 'Linewidth',1.2)
    
%     %PATH PLOT
%     figure;
%     plot3(xs,ys,zs,'r','LineWidth',1.5)
%     axis([xmin,xmax,ymin,ymax,zmin,zmax])
%     xlabel('x')
%     ylabel('y')
%     zlabel('z')
%     grid on
%     posstr=strcat('x=',num2str(xs(length(result.x)))...
%         ,{', y='},num2str(ys(length(result.x))),{', z='},num2str(zs(length(result.x))));
%     text(xs(length(result.x)),ys(length(result.x)),zs(length(result.x)),posstr);
%     tsettle=strcat({'rise time = '},num2str(result.risetime),'s');
%     if result.risetime==0
%         tsettle=strcat('Settled state not reached');
%     end
%     text(xs(length(result.x)),ys(length(result.x)),0.9*zs(length(result.x)),tsettle);
%     title('Path of Quadcopter')
    
%     %UPDATING PATH PLOT
    figure;
    for i=1:2:length(result.x)
        plot3(xs(1:i),ys(1:i),zs(1:i),':r')
        hold on
        scatter3(xs(i),ys(i),zs(i),'r')
        hold off
        axis([xmin,xmax,ymin,ymax,zmin,zmax])
        posstr2=strcat({' x = '},num2str(xs(i)),{', y = '},num2str(ys(i)),{', z = '},num2str(zs(i)));
        text(xs(i),ys(i),0.9*zs(i),posstr2)
        clock=strcat({'  t = '},num2str(times(i)), 's');
        text(xs(i),ys(i),zs(i),clock)
        title('Path of Quadcopter')       
        grid on       
        drawnow
    end
        
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %SECONDARY GRAPHS
%     figure;
%     plots=[subplot(3,1,1), subplot(3,1,2), subplot(3,1,3)];
%
%     %DESIRED ROLL AND PITCH AGAINST TIME
%     subplot(plots(1));
%     plot(times,phides, 'r', 'Linewidth',1.2)
%     hold on
%     plot(times,thetades,'--b','Linewidth',1.2)
%     title('Desired Roll and Pitch Angles Against Time')
%     xlabel('time (s)')
%     ylabel('radians')
%     legend('Roll','Pitch')
%
%     %DESIRED ROLL AGAINST Y COORDINATE
%     subplot(plots(2));
%     plot(ys,phides, 'r', 'Linewidth',1.2)
%     title('Desired Roll Angle Against y-coordinate')
%     xlabel('y (m)')
%     ylabel('radians')
%     legend('Roll')
%
%     %DESIRED PITCH AGAINST X COORDINATE
%     subplot(plots(3));
%     plot(xs,thetades, '--b', 'Linewidth',1.2)
%     title('Desired Pitch Angle Against x-coordinate')
%     xlabel('x (m)')
%     ylabel('radians')
%     legend('Pitch')
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %THRUST AGAINST TIME
%     figure;
%     plots=[subplot(2,1,1), subplot(2,1,2)];
%     subplot(plots(1));
%     plot(times,thrust,'k','LineWidth',1.2)
%     title('Thrust against time')
%     xlabel('time (s)')
%     ylabel('thrust')
%
%     %THRUST AGAINST Z-COORDINATE
%     subplot(plots(2));
%     plot(zs,thrust,'r','LineWidth',1.2)
%     title('Thrust against z-coordinate')
%     xlabel('z-coordinate (m)')
%     ylabel('thrust (N)')

    %Z-INTEGRAL ERROR AGAINST TIME
%     figure;
%     plots=[subplot(2,1,1), subplot(2,1,2)];
%     subplot(plots(1));
%     plot(times,intz,'k','LineWidth',1.2)
%     title('Integral of error in z against time')
%     xlabel('time (s)')
%     ylabel('integral of error in z')
%
%    %Z-INTEGRAL ERROR AGAINST Z-COORDINATE 
%     subplot(plots(2));
%     plot(zs,intz,'r','LineWidth',1.2)
%     title('Integral of error in z against z-coordinate')
%     xlabel('z-coordinate (m)')
%     ylabel('integral of error in z')

%     %YAW-INTEGRAL ERROR AGAINST TIME
%     figure;
%     plots=[subplot(2,1,1), subplot(2,1,2)];
%     subplot(plots(1));
%     plot(times,intpsi,'k','LineWidth',1.2)
%     title('Integral of error in yaw against time')
%     xlabel('time (s)')
%     ylabel('integral of error in yaw')
% %
% %    %Z-INTEGRAL ERROR AGAINST Z-COORDINATE 
%     subplot(plots(2));
%     plot(psis,intpsi,'r','LineWidth',1.2)
%     title('Integral of error in yaw against yaw angle')
%     xlabel('yaw angle (rad)')
%     ylabel('integral of error in yaw')
%     
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
psis(length(psis))    
    
end