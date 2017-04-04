% this function will plot the Z value with the desired one. 
global A
figure
% cla
hold on
plot3(A.X_plot(1:A.counter-1),A.Y_plot(1:A.counter-1),A.Z_plot(1:A.counter-1))
view(30,30)
grid on
axis equal
axis([min(A.X_plot)-.2 max(A.X_plot)+.2 min(A.Y_plot)-.2 max(A.Y_plot)+.2 min(A.Z_plot)-.2 max(A.Z_plot)+.2])
% plot(A.t_plot(1:A.counter),A.Y_plot(1:A.counter),'r','linewidth',1)
% plot(A.t_plot(1:A.counter),A.Y_ref_plot(1:A.counter),'b')
% plot(A.t_plot(1:A.counter),A.Y_dis_plot(1:A.counter),'g')
legend('Actual path')

xlabel('X axis (m)')
ylabel('Y axis (m)')
zlabel('Z axis (m)')

title('path traveled')