function m = meantimes()
    
    series=[];
    n=1;
    for i = 1:12
        n=n*2;
        series(i)=n;
    end
    
    %PID
    %mean data
%     mt=[16.08,15.2,15.88,15.795,15.8361,16.0645,15.6602,16.1424,16.1836,16.1197,16.1841,16.1236];
    %gross data
%     mt=[14.93, 15.2, 15.88, 15.795, 15.8631, 16.0645, 15.6602, 16.1424, 16.0877, 16.1607, 16.1872, 16.1442];

    %PD
    %mean data
%     mt=[];
    %gross data
%     mt=[];
    
    
    figure
    plot(series,mt,'r','LineWidth', 2)
    set(gca,'XScale','log')
    title('Mean rise time against number of simulations')
    
    