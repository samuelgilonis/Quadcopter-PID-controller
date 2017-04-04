
function g = grapher(result)
    times=result.t;
    
    xs=result.x(1,:);
    ys=result.x(2,:);
    zs=result.x(3,:);
    
    xvels=result.vel(1,:);
    yvels=result.vel(2,:);
    zvels=result.vel(3,:);    
       
    phis=result.theta(1,:);
    thetas=result.theta(2,:);
    psis=result.theta(3,:);
    
    phisdot=result.angvel(1,:);
    thetasdot=result.angvel(2,:);
    psisdot=result.angvel(3,:);
    
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
    plot(times,xvels, 'r', 'Linewidth',1.2)
    title('Velocities')
    xlabel('time (s)')
    ylabel('m/s')
    hold on
    plot(times,yvels, '--b', 'Linewidth',1.2)
    hold on
    plot(times,zvels, ':g', 'Linewidth',1.2)
    legend('x','y','z')
    
    subplot(plots(2));
    plot(times,xs, 'r', 'Linewidth',1.2)
    title('Displacements')
    xlabel('time (s)')
    ylabel('metres')
    hold on
    plot(times,ys, '--b', 'Linewidth',1.2)
    hold on
    plot(times,zs, ':g', 'Linewidth',1.2)
    
end