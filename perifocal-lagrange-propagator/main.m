% Jessica Panuccio
 
clc
clear all
close all
%% Perifocal Frame and Lagrange Coefficients Calculator
%% Function Example
    %function [r_v,v_v,h,e,vr0,r,f,g,fdot,gdot]=f_g_f(r0_v,v0_v,d_theta,unit_type)
    %f_g_f
    %
    % Calculates the Lagrange Coefficients parameters
    % with input change in true anomaly
    %
    % [r_v,v_v,h,e,vr0,r,f,g,fdot,gdot]=f_g_f(r0_v,v0_v,d_theta,unit_type);
    %
    % INPUTS: 
    % r0_v, initial position vector, (km or nm)
    % v0_v, initial velocity vector, (km/sec or nm/sec)
    % d_theta, change in true anomaly (deg)
    % unit_type, 1=SI units and 2=British units
    %
    % OUTPUTS: 
    % r_v, final position vector, (km or nm)
    % v_v, final velocity vector, (km/sec or nm/sec)
    % h, specific angular momentum, (km^2/sec or ft^2/sec)
    % e, eccentricity of the orbit, (---)
    % vr0, initial radial velocity, (km/sec or nm/sec)
    % r, magnitude of final position vector, (km or nm)
    % f, Lagrange Coefficients, (---)
    % g, Lagrange Coefficients, (sec)
    % fdot, Lagrange Coefficients, (1/sec)
    % gdot, Lagrange Coefficients, (---)
%% Inputs
            % Enter case, (0=manual input): 0
                    case_prompt = "Enter case, (0=manual input):";
                        case1 = input(case_prompt);
            % Enter input unit type, (1=km 2=nm): 1
                    unit_prompt = "Enter input unit type, (1=km 2=nmi) :";
                        unit_type = input(unit_prompt);              
        if unit_type == 1
            % Enter the position vector, r0 [i j k] (km): [6000 5000 0]
                position_prompt = "Enter the position vector, r0 [i j k] (km):";
                    r0_v = input(position_prompt);
            % Enter the velocity vector, v0 [i j k] (km/sec): [0.4 3 0]
                velocity_prompt = "Enter the velocity vector, v0 [i j k] (km/sec):";
                    v0_v = input(velocity_prompt);
            % Enter change in true anomaly, dtheta (deg): 30
                true_anomaly_prompt = "Enter change in true anomaly, d_theta (deg):";
                    d_theta = input(true_anomaly_prompt);
        else
            % Enter the position vector, r0 [i j k] (km): [3.239740820734341e+03 2.699784017278617e+03 0]
                position_prompt = "Enter the position vector, r0 [i,j,k] (nmi):";
                    r0_v = input(position_prompt);
            % Enter the velocity vector, v0 [i j k] (km/sec): [0.215982721382289 1.619870410367171 0]
                velocity_prompt = "Enter the velocity vector, v0 [i,j,k] (nmi/sec):";
                    v0_v = input(velocity_prompt);
            % Enter change in true anomaly, dtheta (deg): 30
                true_anomaly_prompt = "Enter change in true anomaly, d_theta (deg):";
                    d_theta = input(true_anomaly_prompt);
        end
%% Call Function
    [r_v,v_v,h,e,vr0,r,f,g,fdot,gdot]=f_g_f(r0_v,v0_v,d_theta,unit_type);
%% Verify Identity Equality Constraint on the Lagrange Coefficients
%% Outputs
    if unit_type == 1
        % Metric Output
            fprintf('----------------------------------------------------------------------------------------------------------------------- \n')
            fprintf('Computer Project #2. INPUTS\n')
            fprintf('The initial radius vector is,     r0_v = %+.15ei %+.15ej %+.15ek (km) \n', r0_v)
            fprintf('The initial velocity vector is,   v0_v = %+.15ei %+.15ej %+.15ek (km/sec)\n', v0_v)
            fprintf('The initial delta theta is,    d_theta = %+.15e (deg) \n',d_theta)
            fprintf('----------------------------------------------------------------------------------------------------------------------- \n')
            fprintf('Computer Project #2. ANSWERS\n')
            fprintf('The final radius vector is,        r_v = %+.15ei %+.15ej %+.15ek (km)\n', r_v)
            fprintf('The final velocity vector is,      v_v = %+.15ei %+.15ej %+.15ek (km/sec)\n', v_v)
            fprintf('The momentum is,                     h = %+.15e (km^2/sec)\n', h)
            fprintf('The eccentricity is,                 e = %+.15e (---)\n', e)
            fprintf('The initial radial velocity is,    vr0 = %+.15e (km/sec)\n', vr0)
            fprintf('The final radius magnitude is,       r = %+.15e (km)\n', r)
            fprintf('The f function is,                   f = %+.15e (---)\n', f)
            fprintf('The g function is,                   g = %+.15e (sec)\n', g)
            fprintf('The fdot function is,             fdot = %+.15e (1/sec)\n', fdot)
            fprintf('The gdot function is,             gdot = %+.15e (---)\n', gdot)
            fprintf('f*gdot-fdot*g                          = %+.15e (---)\n', (f*gdot)-(fdot*g))
    else
        % British Output
            fprintf('----------------------------------------------------------------------------------------------------------------------- \n')
            fprintf('Computer Project #2. INPUTS\n')
            fprintf('The initial radius vector is,     r0_v = %+.15ei %+.15ej %+.15ek (nmi) \n', r0_v)
            fprintf('The initial velocity vector is,   v0_v = %+.15ei %+.15ej %+.15ek (nmi/sec)\n', v0_v)
            fprintf('The initial delta theta is,    d_theta = %+.15e (deg) \n',d_theta)
            fprintf('----------------------------------------------------------------------------------------------------------------------- \n')
            fprintf('Computer Project #2. ANSWERS\n')
            fprintf('The final radius vector is,        r_v = %+.15ei %+.15ej %+.15ek (nmi)\n', r_v)
            fprintf('The final velocity vector is,      v_v = %+.15ei %+.15ej %+.15ek (nmi/sec)\n', v_v)
            fprintf('The momentum is,                     h = %+.15e (ft^2/sec)\n', h)
            fprintf('The eccentricity is,                 e = %+.15e (---)\n', e)
            fprintf('The initial radial velocity is,    vr0 = %+.15e (nmi/sec)\n', vr0)
            fprintf('The final radius magnitude is,       r = %+.15e (nmi)\n', r)
            fprintf('The f function is,                   f = %+.15e (---)\n', f)
            fprintf('The g function is,                   g = %+.15e (sec)\n', g)
            fprintf('The fdot function is,             fdot = %+.15e (1/sec)\n', fdot)
            fprintf('The gdot function is,             gdot = %+.15e (---)\n', gdot)
            fprintf('f*gdot-fdot*g                          = %+.15e (---)\n', (f*gdot)-(fdot*g))
    end
