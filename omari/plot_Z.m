% this function will plot the Z value with the desired one. 
global A
figure
% cla
hold on
plot(A.t_plot(1:A.counter),A.Z_plot(1:A.counter)+A.Z_error(1:A.counter),'y')
plot(A.t_plot(1:A.counter),A.Z_plot(1:A.counter),'r','linewidth',1)
plot(A.t_plot(1:A.counter),A.Z_ref_plot(1:A.counter),'b')
plot(A.t_plot(1:A.counter),A.Z_dis_plot(1:A.counter),'g')
plot(A.t_plot(1:A.counter),A.Z_kalman_plot(1:A.counter),'color',[1 .4 .8])
legend('measured response','actual response','set value','disturbances','kalman filter')

xlabel('time (s)')
ylabel('altitude (m)')
title('altitude vs. time')