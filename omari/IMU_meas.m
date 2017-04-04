function IMU_meas
global A

A.phi_meas = A.phi+A.phi_error(A.counter);     %erros is +- 2 mrad
A.theta_meas = A.theta+A.theta_error(A.counter);     %erros is +- 2 mrad
A.psi_meas = A.psi+A.psi_error(A.counter);     %erros is +- 2 mrad

end