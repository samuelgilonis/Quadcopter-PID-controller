function Forces
global A
% this function will calculates the forces and torques on the quadrotor
% give the speed of each propeler.

% Inputs
% O1 = Front (CCW)
% O2 = Right (CW)
% O3 = Rear (CCW)
% O4 = Left (CW)

% Outputs
% U1 = Throttle
% U2 = Roll movement
% U3 = Pitch movement
% U4 = Yaw movement

% Constants
% l = Where l [m] is the distance between the center of the quadrotor and 
% the center of a propeller.
% b = 

%   A.U11_plot(A.counter) = A.U1;
A.U1 = A.b*(sign(A.O1)*A.O1^2 + sign(A.O2)*A.O2^2 + sign(A.O3)*A.O3^2 + sign(A.O4)*A.O4^2);
  A.U1_plot(A.counter) = A.U1;
  
%   A.U21_plot(A.counter) = A.U1;
A.U2 = A.b*A.l*(sign(A.O4)*A.O4^2 - sign(A.O2)*A.O2^2);
  A.U2_plot(A.counter) = A.U2;
  
%   A.U31_plot(A.counter) = A.U1;
A.U3 = A.b*A.l*(sign(A.O3)*A.O3^2 - sign(A.O1)*A.O1^2);
  A.U3_plot(A.counter) = A.U3;
  
%   A.U41_plot(A.counter) = A.U1;
A.U4 = A.d*(sign(A.O2)*A.O2^2 + sign(A.O4)*A.O4^2 - sign(A.O1)*A.O1^2 - sign(A.O3)*A.O3^2);
  A.U4_plot(A.counter) = A.U4;
  
A.O = (-A.O1 + A.O2 - A.O3 + A.O4);
  A.O_plot(A.counter) = A.O;


end