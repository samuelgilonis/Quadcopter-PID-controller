function IMU_meas
global A

A.phi_meas = A.phi+A.phi_error(A.counter)     %erros is +- 2 cm
end