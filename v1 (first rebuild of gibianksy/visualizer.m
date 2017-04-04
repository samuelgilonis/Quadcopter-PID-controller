%This is a graphical simulation of the quadcopter's motion

%CREATE THE GRAPH

function v = visualizer(data)
    figure;
    %Keeps the plots on the same graph
    plots = [subplot(2,1,1), subplot(2,1,2)];
    %Creates 3 plots for the 3D visualisation and for angular velocity and
    %displacement against time.
    
    % Use the bottom two parts for angular velocity and displacement.
    for t = 1:2:length(data.t);
        subplot(plots(1));
        multiplot(data, data.angvel, t);
        xlabel('Time (s)');
        ylabel('Angular Velocity (rad/s)');
        title('Angular Velocity');

        subplot(plots(2));
        multiplot(data, data.theta, t);
        xlabel('Time (s)');
        ylabel('Angular Displacement (rad)');
        title('Angular Displacement');
    end
    
end
    
    function multiplot(data, values, ind)
    % Select the parts of the data to plot.
    times = data.t(:, 1:ind);
    values = values(:, 1:ind);

    % Plot in RGB, with different markers for different components.
    plot(times, values(1, :), 'r-', times, values(2, :), 'g', times, values(3, :), 'b-.');
    
    % Set axes to remain constant throughout plotting.
    xmin = min(data.t);
    xmax = max(data.t);
    ymin = 1.1 * min(min(values));
    ymax = 1.1 * max(max(values));
    axis([xmin xmax ymin ymax]);
end