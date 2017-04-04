%This is a graphical simulation of the quadcopter's motion

%CREATE THE GRAPH

function v = grapher(results)
    figure;
    %Keeps the plots on the same graph
    plots = [subplot(2,1,1), subplot(2,1,2)];
    %Creates 3 plots for the 3D visualisation and for angular velocity and
    %displacement against time.
    
    % Use the bottom two parts for angular velocity and displacement.
    for t = 1:2:length(results.t);
        subplot(plots(1));
        multiplot(results, results.angvel, t);
        xlabel('Time (s)');
        ylabel('Angular Velocity (rad/s)');
        title('Angular Velocity');
        legend

        subplot(plots(2));
        multiplot(results, results.theta, t);
        xlabel('Time (s)');
        ylabel('Angular Displacement (rad)');
        title('Angular Displacement');
        legend
    end
    
end
    
    function multiplot(results, values, ind)
    % Select the parts of the results to plot.
    times = results.t(:, 1:ind);
    values = values(:, 1:ind);

    % Plot in RGB, with different markers for different components.
    plot(times, values(1, :), 'r-', times, values(2, :), 'g', times, values(3, :), 'b-.');
    
    % Set axes to remain constant throughout plotting.
    xmin = min(results.t);
    xmax = max(results.t);
    ymin = 1.1 * min(min(values));
    ymax = 1.1 * max(max(values));
    axis([xmin xmax ymin ymax]);
end