% this function will plot the Z value with the desired one. 
global A
figure
hold on
plot(A.t_plot(1:A.counter),A.theta_plot(1:A.counter)+A.theta_error(1:A.counter),'y')
plot(A.t_plot(1:A.counter),A.theta_plot(1:A.counter),'r')
plot(A.t_plot(1:A.counter),A.theta_ref_plot(1:A.counter),'b')
plot(A.t_plot(1:A.counter),A.theta_dis_plot(1:A.counter),'g')
plot(A.t_plot(1:A.counter),A.theta_kalman_plot(1:A.counter),'color',[1 .4 .8])
legend('measured response','actual response','set value','disturbances','kalman filter')
xlabel('time (s)')
ylabel('theta (rad)')
title('theta vs. time')