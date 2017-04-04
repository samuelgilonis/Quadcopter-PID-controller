function XY_meas
global A

A.X_meas = A.X+A.X_error(A.counter);     %erros is +- 1 cm
A.Y_meas = A.Y+A.Y_error(A.counter);     %erros is +- 1 cm
end