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