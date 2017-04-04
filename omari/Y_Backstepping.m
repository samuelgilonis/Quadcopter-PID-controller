global A

if(A.U1~=0)
A.U2 = .1*(-5*(A.Y - A.Y_des) -10*A.Y_dot - 9*A.U1*A.S_psi*A.C_phi ...
    -4*A.U1*A.psi_dot*A.C_psi*A.C_phi + A.U1*A.psi_dot^2*A.S_psi*A.C_phi ...
    +2*A.U1*A.psi_dot*A.S_psi*A.S_phi + A.U1*A.psi_dot*A.phi_dot*A.C_psi*A.S_phi ...
    -A.U1*A.phi_dot*A.psi_dot*A.C_psi*A.S_phi - A.U1*A.phi_dot^2*A.S_psi*A.C_phi)/(A.U1*A.C_psi*A.C_phi);
else
A.U2 = 0;
end