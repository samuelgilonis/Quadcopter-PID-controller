% this function will plot the Z value with the desired one. 
global A
cla
hold on
plot(A.t_plot(1:A.counter-1),A.U1_plot(1:A.counter-1),'r')
plot(A.t_plot(1:A.counter-1),A.U2_plot(1:A.counter-1),'g')
plot(A.t_plot(1:A.counter-1),A.U3_plot(1:A.counter-1),'b')
plot(A.t_plot(1:A.counter-1),A.U4_plot(1:A.counter-1),'k')
% plot(A.t_plot(1:A.counter),A.Z_ref_plot(1:A.counter),'b')
% plot(A.t_plot(1:A.counter),A.Z_dis_plot(1:A.counter),'g')
legend('Throttle','Roll','Pitch','Yaw')
xlabel('time (s)')
ylabel('value')
title('Forces and Torques vs. time')