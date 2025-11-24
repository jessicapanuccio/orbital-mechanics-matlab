function [d_V_d_v,d_V_a_v,d_V_t_v,TOF]=hohmann_f(r1_v_p,r1_v_a,r2_v_p,r2_v_a,flag_v,mu_v,flag_units)
    % need to convert for British units! meu is in ft not nmi
    %hohmann_f
    %
    % Solves General Hohmann transfer for transferring
    % from one elliptic orbit to another elliptic orbit.
    %
    %
    % [d_V_d_v,d_V_a_v,d_V_t_v,TOF]=hohmann_f(r1_v_p,r1_v_a,r2_v_p,r2_v_a,flag_v,mu_v,flag_units);
    %
    % INPUTS: 
    % r1_v_p, perigee radius of initial parking orbit 1 (km or nm)
    % r1_v_a, apogee radius of initial parking orbit 1 (km or nm)
    % r2_v_p, perigee radius of final parking orbit 2 (km or nm)
    % r2_v_a, apogee radius of final parking orbit 2 (km or nm)
    % flag_v, = 1, periapsis departure and apoapsis arrival
    % = 2, apoapsis departure and periapsis arrival
    % mu_v, gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
    % flag_units, 1=SI units (km) and 2=British units (nm)
    %
    % OUTPUTS: 
    % d_V_d_v, delta V required at departure point of transfer orbit (km/sec or nm/sec)
    % d_V_a_v, delta V required at arrival point of transfer orbit (km/sec or nm/sec)
    % d_V_t_v, total delta V requirement, i.e., d_V_d_v+ d_V_a_v (km/sec or nm/sec)
    % TOF, time of flight for transfer orbit (min)
 
    % Conversions
        nmi_over_ft = 1 / 6076.115485564304;     % [nmi/ft]
        ft_over_nmi = 6076.115485564304 / 1;     % [ft/nmi]
         % Convert meu_SI
            if flag_units == 2
                mu_v = mu_v * (nmi_over_ft)^3;
            end
    % Reference Curtis Textbook pg. 292
        % Rename Variable for Textbook Nomenclature Consistency
            rA = r1_v_p;
            rAp = r1_v_a;
            rB = r2_v_a;
            rBp = r2_v_p;
        % Angular Momentum of Each Orbit
            h1 = sqrt(2 * mu_v) * sqrt((rA * rAp)/(rA + rAp));
            h2 = sqrt(2 * mu_v) * sqrt((rB * rBp)/(rB + rBp));
            h3 = sqrt(2 * mu_v) * sqrt((rA * rB)/(rA + rB));
            h3p = sqrt(2 * mu_v) * sqrt((rAp * rBp)/(rAp + rBp));
        % Velocities
            v_A_1 = h1 / rA;
            v_A_3 = h3 / rA;
            v_B_2 = h2 / rB;
            v_B_3 = h3 / rB;
            v_Ap_1 = h1 / rAp;
            v_Ap_3p = h3p / rAp;
            v_Bp_2 = h2 / rBp;
            v_Bp_3p = h3p / rBp;
        % Delta-V's
            del_v_A = abs(v_A_3 - v_A_1);
            del_v_B = abs(v_B_2 - v_B_3);
            del_v_Ap = abs(v_Ap_3p - v_Ap_1);
            del_v_Bp = abs(v_Bp_2 - v_Bp_3p);
        % Total Delta-V
            del_v_tot_3 = del_v_A + del_v_B;
            del_v_tot_3p = del_v_Ap + del_v_Bp; 
        % Time of Flight 
            % Semimajor Axis
                a_3 = (1/2) * (rA + rB);
                a_3p = (1/2) * (rAp + rBp);
            % Period
                T_3 = ((2*pi)/(sqrt(mu_v))) * (a_3)^(3/2);   % period for transfer orbit (sec)
                T_3p = ((2*pi)/(sqrt(mu_v))) * (a_3p)^(3/2); % period for transfer orbit (sec)
                T_3 = T_3 * (1/60);                          % period for transfer orbit (min)
                T_3p = T_3p * (1/60);                        % period for transfer orbit (min)
                
    switch flag_v
        case 1  
            d_V_d_v = del_v_A;            % delta V required at departure point of transfer orbit (km/sec or nm/sec)
            d_V_a_v = del_v_B;            % delta V required at arrival point of transfer orbit (km/sec or nm/sec)
            d_V_t_v = del_v_tot_3;        % total delta V requirement, i.e., d_V_d_v+ d_V_a_v (km/sec or nm/sec)
            TOF = T_3 / 2;                % TOF, time of flight for transfer orbit (min)
        case 2
            d_V_d_v = del_v_Ap;           % delta V required at departure point of transfer orbit (km/sec or nm/sec)
            d_V_a_v = del_v_Bp;           % delta V required at arrival point of transfer orbit (km/sec or nm/sec)
            d_V_t_v = del_v_tot_3p;       % total delta V requirement, i.e., d_V_d_v+ d_V_a_v (km/sec or nm/sec)
            TOF = T_3p / 2;               % TOF, time of flight for transfer orbit (min)
    end
end
