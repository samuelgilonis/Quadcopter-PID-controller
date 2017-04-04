global A

   [A.X22,A.Y22,A.Z22]=rotateXYZ(A.X2,A.Y2,A.Z2,A.phi,A.theta,A.psi);
   set(A.L2,'xdata',A.X22+A.X,'ydata',A.Y22+A.Y,'zdata',A.Z22+A.Z);

   [A.X22,A.Y22,A.Z22]=rotateXYZ(A.FPX,A.FPY,A.FPZ,A.phi,A.theta,A.psi);
   set(A.L3,'xdata',A.X22+A.X,'ydata',A.Y22+A.Y,'zdata',A.Z22+A.Z);
   
   [A.X22,A.Y22,A.Z22]=rotateXYZ(A.RPX,A.RPY,A.RPZ,A.phi,A.theta,A.psi);
   set(A.L4,'xdata',A.X22+A.X,'ydata',A.Y22+A.Y,'zdata',A.Z22+A.Z);
   
   [A.X22,A.Y22,A.Z22]=rotateXYZ(A.rPX,A.rPY,A.rPZ,A.phi,A.theta,A.psi);
   set(A.L5,'xdata',A.X22+A.X,'ydata',A.Y22+A.Y,'zdata',A.Z22+A.Z);
   
   [A.X22,A.Y22,A.Z22]=rotateXYZ(A.LPX,A.LPY,A.LPZ,A.phi,A.theta,A.psi);
   set(A.L6,'xdata',A.X22+A.X,'ydata',A.Y22+A.Y,'zdata',A.Z22+A.Z);
   
   [A.X22,A.Y22,A.Z22]=rotateXYZ(A.X1,A.Y1,A.Z1,A.phi,A.theta,A.psi);
   set(A.L1,'xdata',A.X22+A.X,'ydata',A.Y22+A.Y,'zdata',A.Z22+A.Z);
   