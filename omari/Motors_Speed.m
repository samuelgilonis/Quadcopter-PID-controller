function Motors_Speed
global A

BB1 = A.U1/(4*A.b) - A.U3/(2*A.b*A.l) - A.U4/(4*A.d);
BB2 = A.U1/(4*A.b) - A.U2/(2*A.b*A.l) + A.U4/(4*A.d);
BB3 = A.U1/(4*A.b) + A.U3/(2*A.b*A.l) - A.U4/(4*A.d);
BB4 = A.U1/(4*A.b) + A.U2/(2*A.b*A.l) + A.U4/(4*A.d);

if abs(BB1)>A.Motors_limit
    BB1 = sign(BB1)*A.Motors_limit;
end

if abs(BB2)>A.Motors_limit
    BB2 = sign(BB2)*A.Motors_limit;
end

if abs(BB3)>A.Motors_limit
    BB3 = sign(BB3)*A.Motors_limit;
end

if abs(BB4)>A.Motors_limit
    BB4 = sign(BB4)*A.Motors_limit;
end

A.O1 = sign(BB1)*sqrt(abs(BB1));    % Front M
A.O2 = sign(BB2)*sqrt(abs(BB2));    % Right M
A.O3 = sign(BB3)*sqrt(abs(BB3));    % Rear M
A.O4 = sign(BB4)*sqrt(abs(BB4));    % Left M

A.O1_plot(A.counter) = A.O1;
A.O2_plot(A.counter) = A.O2;
A.O3_plot(A.counter) = A.O3;
A.O4_plot(A.counter) = A.O4;

end