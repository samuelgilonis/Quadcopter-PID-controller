function meantimes = totalgrossresult(controller)
    series=[];
    n=1;
    for i = 1:9
        n=n*2;
        series(i)=n;
    end
    
    meantimes=[];
    
    count=0;
    for j = series
        count=count+1;
        if strcmpi(controller,'PID')==1;
            meantimes(count)=grossresult('PID',j);
        end
        if strcmpi(controller,'PD')==1;
            meantimes(count)=grossresult('PD',j);
        end
    end
    
    figure
    plot(series,meantimes, 'r', 'Linewidth',1.2)
    titlestr=strcat({'Mean rise time against number of simulations for a '}...
        ,controller,{' controller'});
    title(titlestr)
    xlabel('Number of simulations')
    ylabel('Mean rise time')