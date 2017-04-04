function [inputs,previous_error2] = PD(m,g,K,B,I,l,start_time,end_time...
    ,dt,orientation,desired_orientation,eulerdot)
%eulerdot represents the time derivatives of the euler angles.

    inputs=zeros(4,1);
    previous_error2=zeros(3,1); %At the end of the code the function will set 
                                %the error as the new previous error. In
                                %themain simulator code previous_error2
                                %will be set as the previous_error argument
                                %for this function.

    Ixx=I(1,1);
    Iyy=I(2,2);
    Izz=I(3,3);
    
    phi=orientation(1);
    theta=orientation(2);
    psi=orientation(3);
    
    Kp_phi=4;  %the tuning parameters
    Kd_phi=3;
    Kp_theta=4;
    Kd_theta=3;
    Kp_psi=4;
    Kd_psi=3;
    
    phi_des=desired_orientation(1);
    theta_des=desired_orientation(2);
    psi_des=desired_orientation(3);
    
    error_phi=phi_des-phi;
    error_theta=theta_des-theta;
    error_psi=psi_des-psi;

    
%     errordot_phi=(error_phi-previous_error_phi)/dt;
%     errordot_theta=(error_theta-previous_error_theta)/dt;
%     errordot_psi=(error_psi-previous_error_psi)/dt;

    errordot_phi=eulerdot(1);
    errordot_theta=eulerdot(2);
    errordot_psi=eulerdot(3);
    
    thrust=m*g/(K*cos(phi)*cos(theta));
    
    e_phi=Kp_phi*error_phi+Kd_phi*errordot_phi;
    e_theta=Kp_theta*error_theta+Kd_theta*errordot_theta;
    e_psi=Kp_psi*error_psi+Kd_psi*errordot_psi;
    
    inputs(1)=thrust/4 + 1/(4*l*B*K)*(-2*B*e_phi*Iyy-l*K*e_psi*Izz);
    
    inputs(2)=thrust/4 + 1/(4*l*B*K)*(-2*B*e_theta*Ixx-l*K*e_psi*Izz);
    
    inputs(3)=thrust/4 + 1/(4*l*B*K)*(2*B*e_phi*Iyy+ l*K*e_psi*Izz);
    
    inputs(4)=thrust/4 + 1/(4*l*B*K)*(2*B*e_theta*Ixx-l*K*e_psi*Izz);

    
    orientation = orientation +dt*eulerdot;
end
    
    
        
        
   
        
    
    
    
