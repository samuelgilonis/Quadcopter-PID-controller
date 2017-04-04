global A

load Quadrotor

A.Body1 = patch('xdata',A.Body1X,'ydata',A.Body1Y,'zdata',A.Body1Z,'facealpha',.3,'facecolor','b');
A.Body2 = patch('xdata',A.Body2X,'ydata',A.Body2Y,'zdata',A.Body2Z,'facealpha',.3,'facecolor','b');
A.RotorF = patch('xdata',A.RotorFX,'ydata',A.RotorFY,'zdata',A.RotorFZ,'facealpha',.3,'facecolor','k');
A.RotorB = patch('xdata',A.RotorBX,'ydata',A.RotorBY,'zdata',A.RotorBZ,'facealpha',.3,'facecolor','k');
A.RotorR = patch('xdata',A.RotorRX,'ydata',A.RotorRY,'zdata',A.RotorRZ,'facealpha',.3,'facecolor','k');
A.RotorL = patch('xdata',A.RotorLX,'ydata',A.RotorLY,'zdata',A.RotorLZ,'facealpha',.3,'facecolor','k');

