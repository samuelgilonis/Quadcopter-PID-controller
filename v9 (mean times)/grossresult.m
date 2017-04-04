%This script is to run the simulation multiple times in order to gather
%mean results.

function meanrisetime = grossresult(controller,numsim)
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
    
    %take mean results:
    meanx=mean(x);
    meany=mean(y);
    meanz=mean(z);
    
    risetime(risetime==0)=[];
    meanrisetime=mean(risetime);
    
    times=result.t;

    %PLOT ALL RESULTS:    
    figure
    plots=[subplot(2,1,1), subplot(2,1,2)];
    
    %VELOCITIES
    subplot(plots(1));    
    xdotplot=plot(times,xdot, 'b', 'Linewidth',1.2);
    titlestr1=strcat({'Velocities when simulated '},num2str(numsim),{' times'});
    title(titlestr1)
    xlabel('time (s)')
    ylabel('m/s')
    hold on
    ydotplot=plot(times,ydot, 'r', 'Linewidth',1.2);
    hold on
    zdotplot=plot(times,zdot, 'g', 'Linewidth',1.2);
    xgroup=hggroup;
    ygroup=hggroup;
    zgroup=hggroup;
    set(xdotplot,'Parent',xgroup)
    set(ydotplot,'Parent',ygroup)
    set(zdotplot,'Parent',zgroup)
    set(get(get(xgroup,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on');
    set(get(get(ygroup,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on');
    set(get(get(zgroup,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on');
    legend('x','y','z')
    
    %DISPLACEMENTS
    subplot(plots(2));
    plot(times,x, 'b', 'Linewidth',1.2)
    titlestr2=strcat({'Displacements when simulated '},num2str(numsim),{' times'});
    title(titlestr2)
    xlabel('time (s)')
    ylabel('metres')
    hold on
    plot(times,y, 'r', 'Linewidth',1.2)
    hold on
    plot(times,z, 'g', 'Linewidth',1.2)
    
    figure
    plots=[subplot(2,1,1), subplot(2,1,2)];
    
    %ANGULAR VELOCITIES
    subplot(plots(1));    
    phidotplot=plot(times,phidot, 'r', 'Linewidth',1.2);
    titlestr3=strcat({'Angular velocities when simulated '},num2str(numsim),{' times'});
    title(titlestr3)
    xlabel('time (s)')
    ylabel('radians/s')
    hold on
    thetadotplot=plot(times,thetadot, 'b', 'Linewidth',1.2);
    hold on
    psidotplot=plot(times,psidot, 'g', 'Linewidth',1.2);
    phigroup=hggroup;
    thetagroup=hggroup;
    psigroup=hggroup;
    set(phidotplot,'Parent',phigroup)
    set(thetadotplot,'Parent',thetagroup)
    set(psidotplot,'Parent',psigroup)
    set(get(get(phigroup,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on');
    set(get(get(thetagroup,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on');
    set(get(get(psigroup,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','on');
    legend('Roll','Pitch','Yaw')
    
    %ANGULAR DISPLACEMENTS
    subplot(plots(2));
    plot(times,phi, 'r', 'Linewidth',1.2)
    titlestr4=strcat({'Angular displacements when simulated '},num2str(numsim),{' times'});
    title(titlestr4)
    xlabel('time (s)')
    ylabel('radians')
    hold on
    plot(times,theta, 'b', 'Linewidth',1.2)
    hold on
    plot(times,psi, 'g', 'Linewidth',1.2)

    
    %PATH PLOT
    xmax=max(meanx)+10;
    xmin=min(meanx);
    ymax=max(meany)+10;
    ymin=min(meany);
    zmax=max(meanz)+10;
    zmin=min(meanz);    
    
    figure;
    for j=1:numsim
        plot3(x(j,:),y(j,:),z(j,:),'r','LineWidth',0.8)
        hold on
    end

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
    titlestr5=strcat({'Paths of quadcopter when simulated '},num2str(numsim),{' times'});
    title(titlestr5)


    
    
