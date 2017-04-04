% this function will plot the Z value with the desired one. 
global A
cla
hold on
plot(A.t_plot(1:A.counter),A.O1_plot(1:A.counter),'r')
plot(A.t_plot(1:A.counter),A.O2_plot(1:A.counter),'g')
plot(A.t_plot(1:A.counter),A.O3_plot(1:A.counter),'b')
plot(A.t_plot(1:A.counter),A.O4_plot(1:A.counter),'k')
% plot(A.t_plot(1:A.counter),A.Z_ref_plot(1:A.counter),'b')
% plot(A.t_plot(1:A.counter),A.Z_dis_plot(1:A.counter),'g')
legend('front','right','rear','left')
xlabel('time (s)')
ylabel('value')
title('Forces and Torques vs. time')