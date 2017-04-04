
function g = grapher(result)
    times=result.t;
       
        
    xvels=result.vel(1,:);
    yvels=result.vel(2,:);
    zvels=result.vel(3,:);    
       
    phis=result.theta(1,:);
    thetas=result.theta(2,:);
    psis=result.theta(3,:);
    
    phisdot=result.angvel(1,:);
    thetasdot=result.angvel(2,:);
    psisdot=result.angvel(3,:);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    phides=result.phides;
    thetades=result.thetades;
    
    xs=result.x(1,:);
    ys=result.x(2,:);
    zs=result.x(3,:);
    
    xerrors=result.errors(1,:);
    yerrors=result.errors(2,:);
    zerrors=result.errors(3,:);
    
    thrust=result.thrust;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure;
    plots=[subplot(2,1,1), subplot(2,1,2)];
    
    subplot(plots(1));    
    plot(times,phisdot, 'r', 'Linewidth',1.2)
    title('Angular Velocities')
    xlabel('time (s)')
    ylabel('radians/s')
    hold on
    plot(times,thetasdot, '--b', 'Linewidth',1.2)
    hold on
    plot(times,psisdot, ':g', 'Linewidth',1.2)
    legend('Roll','Pitch','Yaw')
    
    subplot(plots(2));
    plot(times,phis, 'r', 'Linewidth',1.2)
    title('Angular Displacements')
    xlabel('time (s)')
    ylabel('radians')
    hold on
    plot(times,thetas, '--b', 'Linewidth',1.2)
    hold on
    plot(times,psis, ':g', 'Linewidth',1.2)
    
    figure
    plots=[subplot(2,1,1), subplot(2,1,2)];
    
    subplot(plots(1));    
    plot(times,xvels, '--b', 'Linewidth',1.2)
    title('Velocities')
    xlabel('time (s)')
    ylabel('m/s')
    hold on
    plot(times,yvels, 'r', 'Linewidth',1.2)
    hold on
    plot(times,zvels, ':g', 'Linewidth',1.2)
    legend('x','y','z')
    
    subplot(plots(2));
    plot(times,xs, '--b', 'Linewidth',1.2)
    title('Displacements')
    xlabel('time (s)')
    ylabel('metres')
    hold on
    plot(times,ys, 'r', 'Linewidth',1.2)
    hold on
    plot(times,zs, ':g', 'Linewidth',1.2)
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure;
%     plots=[subplot(3,1,1), subplot(3,1,2), subplot(3,1,3)];
%     
%     subplot(plots(1));
%     plot(times,phides, 'r', 'Linewidth',1.2)
%     hold on
%     plot(times,thetades,'--b','Linewidth',1.2)
%     title('Desired Roll and Pitch Angles Against Time')
%     xlabel('time (s)')
%     ylabel('radians')
%     legend('Roll','Pitch')
%     
%     subplot(plots(2));
%     plot(ys,phides, 'r', 'Linewidth',1.2)
%     title('Desired Roll Angle Against y-coordinate')
%     xlabel('y (m)')
%     ylabel('radians')
%     legend('Roll')
%     
%     subplot(plots(3));
%     plot(xs,thetades, '--b', 'Linewidth',1.2)
%     title('Desired Pitch Angle Against x-coordinate')
%     xlabel('x (m)')
%     ylabel('radians')
%     legend('Pitch')
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure;
%     plots=[subplot(2,1,1), subplot(2,1,2)];
%     subplot(plots(1));
%     plot(times,thrust,'k','LineWidth',1.2)
%     title('Thrust against time')
%     xlabel('time (s)')
%     ylabel('')
%     
%     subplot(plots(2));
%     plot(zs,thrust,'r','LineWidth',1.2)
%     title('Thrust against z-coordinate')
%     xlabel('z-coordinate (m)')
%     ylabel('thrust (N)')
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
end