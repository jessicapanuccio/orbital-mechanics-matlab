% Jessica Panuccio
 
clc
clear all
close all
%% General Coplanar Hohmann Transfer Program
%% Conversions
    nmi_over_ft = 1 / 6076.115485564304;     % [nmi/ft]
    ft_over_nmi = 6076.115485564304 / 1;     % [ft/nmi]
%% Constants
    meu_B = 1.407646882e16;       % gravitational parameter (ft^3/sec^2) 
    meu_SI = 398601.2;            % gravitational parameter (km^3/sec^2)
%% Inputs
    % r1_v_p, perigee radius of initial parking orbit 1 (km or nmi)
    % r1_v_a, apogee radius of initial parking orbit 1 (km or nmi)
    % r2_v_p, perigee radius of final parking orbit 2 (km or nmi)
    % r2_v_a, apogee radius of final parking orbit 2 (km or nmi)
    % flag_v, = 1, periapsis departure and apoapsis arrival
    % = 2, apoapsis departure and periapsis arrival
    % mu_v, gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
    % flag_units, 1=SI units (km) and 2=British units (nmi)
 
    % Case Inputs
        case_prompt = "Enter case, (0 = manual input) :";
            case_type = input(case_prompt);
        switch case_type
            case 0
                % Manual Input
                    unit_prompt = "Enter input unit type, (1=km 2=nmi) :";
                        flag_units = input(unit_prompt);              
                    if flag_units == 1
                        mu_v = meu_SI;
                        r1_v_p_prompt = "Enter the perigee radius of initial parking orbit 1, r1_v_p (km):";
                            r1_v_p = input(r1_v_p_prompt);
                        r1_v_a_prompt = "Enter the apogee radius of initial parking orbit 1, r1_v_a (km):";
                            r1_v_a = input(r1_v_a_prompt);    
                        r_v_p_prompt = "Enter the perigee radius of final parking orbit 2, r2_v_p (km):";
                            r2_v_p = input(r2_v_p_prompt);
                        r2_v_a_prompt = "Enter the apogee radius of final parking orbit 2, r2_v_a (km):";
                            r2_v_a = input(r2_v_a_prompt);
                        flag_v_prompt = "Enter the transfer type: = 1, periapsis departure and apoapsis arrival; and = 2, apoapsis departure and periapsis arrival :";
                            flag_v = input(flag_v_prompt);
                    else
                        mu_v = meu_B;
                        r1_v_p_prompt = "Enter the perigee radius of initial parking orbit 1, r1_v_p (nmi):";
                            r1_v_p = input(r1_v_p_prompt);
                        r1_v_a_prompt = "Enter the apogee radius of initial parking orbit 1, r1_v_a (nmi):";
                            r1_v_a = input(r1_v_a_prompt);
                        r_v_p_prompt = "Enter the perigee radius of final parking orbit 2, r2_v_p (nmi):";
                            r2_v_p = input(r2_v_p_prompt);
                        r2_v_a_prompt = "Enter the apogee radius of final parking orbit 2, r2_v_a (nmi):";
                            r2_v_a = input(r2_v_a_prompt);
                        flag_v_prompt = "Enter the transfer type: = 1 for periapsis departure and apoapsis arrival; and = 2 for apoapsis departure and periapsis arrival :";
                            flag_v = input(flag_v_prompt);
                    end
            case 1 
                r1_v_p = 6858;          % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = 7178;          % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = 21500;         % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = 21500;         % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = 1;             % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = meu_SI;          % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = 1;         % 1=SI units (km) and 2=British units (nmi)
            case 2
                r1_v_p = 6858;          % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = 7178;          % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = 21500;         % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = 21500;         % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = 2;             % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = meu_SI;          % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = 1;         % 1=SI units (km) and 2=British units (nmi)
            case 3
                r1_v_p = 7200;          % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = 8000;          % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = 10000;         % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = 15000;         % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = 1;             % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = meu_SI;          % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = 1;         % 1=SI units (km) and 2=British units (nmi)
            case 4
                r1_v_p = 7200;          % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = 8000;          % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = 10000;         % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = 15000;         % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = 2;             % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = meu_SI;          % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = 1;         % 1=SI units (km) and 2=British units (nmi)
            case 5
                r1_v_p = 7000;          % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = 7000;          % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = 10000;         % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = 14000;         % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = 1;             % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = meu_SI;          % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = 1;         % 1=SI units (km) and 2=British units (nmi)
            case 6
                r1_v_p = 7000;          % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = 7000;          % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = 10000;         % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = 14000;         % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = 2;             % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = meu_SI;          % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = 1;         % 1=SI units (km) and 2=British units (nmi)
            case 7
                r1_v_p = 4567;          % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = 6424;          % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = 7087;          % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = 11987;         % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = 1;             % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = meu_B;           % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = 2;         % 1=SI units (km) and 2=British units (nmi)
            case 8
                r1_v_p = 4567;          % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = 6424;          % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = 7087;          % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = 11987;         % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = 2;             % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = meu_B;           % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = 2;         % 1=SI units (km) and 2=British units (nmi)
            case 99
                % Blank Case
                r1_v_p = '';            % perigee radius of initial parking orbit 1 (km or nmi)
                r1_v_a = '';            % apogee radius of initial parking orbit 1 (km or nmi)
                r2_v_p = '';            % perigee radius of final parking orbit 2 (km or nmi)
                r2_v_a = '';            % apogee radius of final parking orbit 2 (km or nmi)
                flag_v = '';            % = 1, periapsis departure and apoapsis arrival
                                        % = 2, apoapsis departure and periapsis arrival
                mu_v = '';              % gravitational parameter (km^3/sec^2 or (ft^3/sec^2)
                flag_units = '';        % 1=SI units (km) and 2=British units (nmi)
        end
%% Call Function
    [d_V_d_v,d_V_a_v,d_V_t_v,TOF]=hohmann_f(r1_v_p,r1_v_a,r2_v_p,r2_v_a,flag_v,mu_v,flag_units);
%% Output
    % OUTPUTS: 
    % d_V_d_v, delta V required at departure point of transfer orbit (km/sec or nm/sec)
    % d_V_a_v, delta V required at arrival point of transfer orbit (km/sec or nm/sec)
    % d_V_t_v, total delta V requirement, i.e., d_V_d_v+ d_V_a_v (km/sec or nm/sec)
    % TOF, time of flight for transfer orbit (min)
    
    fprintf('----------------------------------------------------------------------------------------------------------------------- \n')
    fprintf('Computer Project #5. ANSWERS\n')
    switch flag_units
        case 1
            fprintf('The delta V required at departure point of transfer orbit,   d_V_d_v = %+.15e (km/sec) \n',d_V_d_v)
            fprintf('The delta V required at arrival point of transfer orbit,     d_V_a_v = %+.15e (km/sec) \n',d_V_a_v)
            fprintf('The total delta V requirement,                               d_V_t_v = %+.15e (km/sec) \n',d_V_t_v)
            fprintf('The time of flight for transfer orbit,                           TOF = %+.15e (min) \n',TOF)
        case 2
            fprintf('The delta V required at departure point of transfer orbit,   d_V_d_v = %+.15e (nmi/sec) \n',d_V_d_v)
            fprintf('The delta V required at arrival point of transfer orbit,     d_V_a_v = %+.15e (nmi/sec) \n',d_V_a_v)
            fprintf('The total delta V requirement,                               d_V_t_v = %+.15e (nmi/sec) \n',d_V_t_v)
            fprintf('The time of flight for transfer orbit,                           TOF = %+.15e (min) \n',TOF)
    end
