global A

x1=-.27;
x2=.27;
y1=-.01;
y2=.01;
z1=-.01;
z2=.01;

acon=[x1 y1 z1; 
   x2 y1 z1;
   x2 y2 z1;
   x1 y2 z1;
   x1 y1 z2;
   x2 y1 z2;
   x2 y2 z2;
   x1 y2 z2];

bcon=[1 2 6 5;              
     2 3 7 6;
     3 4 8 7;
     4 1 5 8;
     1 2 3 4;
     5 6 7 8];

 
 body1=patch('faces',bcon,...
     'vertices',acon,...
     'facecolor',[.8 .8 .8],...
     'edgecolor',[0 0 0],'facecolor',[.4 .5 1]);
 
y1=-.27;
y2=.27;
x1=-.01;
x2=.01;
z1=-.01;
z2=.01;

acon=[x1 y1 z1; 
   x2 y1 z1;
   x2 y2 z1;
   x1 y2 z1;
   x1 y1 z2;
   x2 y1 z2;
   x2 y2 z2;
   x1 y2 z2];

 body2=patch('faces',bcon,...
     'vertices',acon,...
     'facecolor',[.8 .8 .8],...
     'edgecolor',[0 0 0],'facecolor',[.4 .5 1]);
 
 t=0:pi/10:2*pi;
 X=.13*cos(t);
 Y=.13*sin(t);
 Z=zeros(size(t))+.015;
 C=zeros(size(t));
 A.C = C;
 
 RotorF = patch(X+.27,Y,Z,C,'facealpha',.3,'facecolor','k');
 RotorB = patch(X-.27,Y,Z,C,'facealpha',.3,'facecolor','k');
 RotorL = patch(X,Y+.27,Z,C,'facealpha',.3,'facecolor','k');
 RotorR = patch(X,Y-.27,Z,C,'facealpha',.3,'facecolor','k');
 
 A.Body1X = get(body1,'xdata');
 A.Body1Y = get(body1,'ydata');
 A.Body1Z = get(body1,'zdata');
 
 A.Body2X = get(body2,'xdata');
 A.Body2Y = get(body2,'ydata');
 A.Body2Z = get(body2,'zdata');
  
 A.RotorFX = get(RotorF,'xdata');
 A.RotorFY = get(RotorF,'ydata');
 A.RotorFZ = get(RotorF,'zdata');
  
 A.RotorBX = get(RotorB,'xdata');
 A.RotorBY = get(RotorB,'ydata');
 A.RotorBZ = get(RotorB,'zdata');
  
 A.RotorRX = get(RotorR,'xdata');
 A.RotorRY = get(RotorR,'ydata');
 A.RotorRZ = get(RotorR,'zdata');
  
 A.RotorLX = get(RotorL,'xdata');
 A.RotorLY = get(RotorL,'ydata');
 A.RotorLZ = get(RotorL,'zdata');
   
%  xlabel('x')
%  grid on
%   axis([-1 1 -1 1 -1 1]);
  axis equal
  
