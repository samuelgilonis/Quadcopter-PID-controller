%This script is to run the simulation multiple times in order to gather
%mean results.

function meanrisetime = meanresult(controller,numsim)
    %numsim is the number of times the simulation is to be run   
    
    %define arrays:    
    x=[];
    y=[];
    z=[];
    
    xdot=[];
    ydot=[];
    zdot=[];
    
    phi=[];
    theta=[];
    psi=[];
    
    phidot=[];
    thetadot=[];
    psidot=[];
    
    risetime=[];
    
    %extract results from simulations:    
    for n=1:numsim;
        if strcmpi(controller,'PID')==1;
            result=nographsimulate(PID);
        end
        if strcmpi(controller,'PD')==1;
            result=nographsimulate(PD);
        end
        
                
        x(n,:)= result.x(1,:);
        y(n,:)= result.x(2,:);
        z(n,:)= result.x(3,:);
        
        xdot(n,:)=result.vel(1,:);
        ydot(n,:)=result.vel(2,:);
        zdot(n,:)=result.vel(3,:);
        
        phi(n,:)=result.theta(1,:);
        theta(n,:)=result.theta(2,:);
        psi(n,:)=result.theta(3,:);
        
        phidot(n,:)=result.angvel(1,:);
        thetadot(n,:)=result.angvel(2,:);
        psidot(n,:)=result.angvel(3,:);
        
        risetime(n)=result.risetime;
        
    end
    
    times=result.t;
    
    %take mean results:
    meanx=mean(x);
    meany=mean(y);
    meanz=mean(z);
    
    meanxdot=mean(xdot);
    meanydot=mean(ydot);
    meanzdot=mean(zdot);
    
    meanphi=mean(phi);
    meantheta=mean(theta);
    meanpsi=mean(psi);
    
    meanphidot=mean(phidot);
    meanthetadot=mean(thetadot);
    meanpsidot=mean(psidot);
    
    risetime(risetime==0)=[];
    meanrisetime=mean(risetime);
    
    %PLOT MEAN RESULTS:    
    figure
    plots=[subplot(2,1,1), subplot(2,1,2)];
    
    %VELOCITIES
    subplot(plots(1));    
    plot(times,meanxdot, '--b', 'Linewidth',1.2)
    titlestr1=strcat({'Mean velocities when simulated '},num2str(numsim),{' times'});
    title(titlestr1)
    xlabel('time (s)')
    ylabel('m/s')
    hold on
    plot(times,meanydot, 'r', 'Linewidth',1.2)
    hold on
    plot(times,meanzdot, ':g', 'Linewidth',1.2)
    legend('x','y','z')
    
    %DISPLACEMENTS
    subplot(plots(2));
    plot(times,meanx, '--b', 'Linewidth',1.2)
    titlestr2=strcat({'Mean displacements when simulated '},num2str(numsim),{' times'});
    title(titlestr2)
    xlabel('time (s)')
    ylabel('metres')
    hold on
    plot(times,meany, 'r', 'Linewidth',1.2)
    hold on
    plot(times,meanz, ':g', 'Linewidth',1.2)
    
    figure
    plots=[subplot(2,1,1), subplot(2,1,2)];
    
    %ANGULAR VELOCITIES
    subplot(plots(1));    
    plot(times,meanphidot, 'r', 'Linewidth',1.2)
    titlestr3=strcat({'Mean angular velocities when simulated '},num2str(numsim),{' times'});
    title(titlestr3)
    xlabel('time (s)')
    ylabel('radians/s')
    hold on
    plot(times,meanthetadot, '--b', 'Linewidth',1.2)
    hold on
    plot(times,meanpsidot, ':g', 'Linewidth',1.2)
    legend('Roll','Pitch','Yaw')
    
    %ANGULAR DISPLACEMENTS
    subplot(plots(2));
    plot(times,meanphi, 'r', 'Linewidth',1.2)
    titlestr4=strcat({'Mean angular displacements when simulated '},num2str(numsim),{' times'});
    title(titlestr4)
    xlabel('time (s)')
    ylabel('radians')
    hold on
    plot(times,meantheta, '--b', 'Linewidth',1.2)
    hold on
    plot(times,meanpsi, ':g', 'Linewidth',1.2)
    
    %PATH PLOT
    xmax=max(meanx)+10;
    xmin=min(meanx);
    ymax=max(meany)+10;
    ymin=min(meany);
    zmax=max(meanz)+10;
    zmin=min(meanz);    
    
    figure;
    plot3(meanx,meany,meanz,'r','LineWidth',1.5)
    axis([xmin,xmax,ymin,ymax,zmin,zmax])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    posstr=strcat('x=',num2str(meanx(length(meanx)))...
        ,{', y='},num2str(meany(length(meany))),{', z='},num2str(meanz(length(meanz))));
    text(meanx(length(meanx)),meany(length(meany)),meanz(length(meanz)),posstr);
    trise=strcat({'mean rise time = '},num2str(meanrisetime),'s');
    text(meanx(length(meanx)),meany(length(meany)),0.9*meanz(length(meanz)),trise);
    titlestr5=strcat({'Mean path of quadcopter when simulated '},num2str(numsim),{' times'});
    title(titlestr5)
    

