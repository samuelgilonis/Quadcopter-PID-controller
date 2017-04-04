function result = simulate2(controller, x_desired,y_desired,z_desired)
    if nargin<2
        x_desired=100;
        y_desired=100;
        z_desired=100;
    end
    result=nographsimulate(controller, x_desired,y_desired,z_desired);
    grapher(result)
end