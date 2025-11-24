% Jessica Panuccio
% Elliptical Orbit Calculator


% Earth-Centered Elliptical Orbit MATLAB Calculator
% Computes orbital mechanics variables using inputs for unit type,
% perigee altitude, apogee altitude, and true anomaly.

 
clc
clear all
close all
%% Orbital Calculator
%% Unit Conversions
    % Conversion Factors
        nmi_to_ft = 6076.115485564304 / 1;      % [ft]
        ft_to_nmi = 1 / 6076.115485564304;      % [nmi]
        km_to_ft = 3280.839895013123 / 1;       % [ft]
        ft_to_km = 1 / 3280.839895013123;       % [km]
        nmi_to_km = 1 * nmi_to_ft * ft_to_km;   % [km]
        km_to_nmi = 1 * km_to_ft * ft_to_nmi;   % [nmi]
        km_to_m = 1000 / 1;                     % [m]
        nmi_to_m = nmi_to_km * km_to_m;         % [m]
        sec_to_min = 1 / 60;                    % [min]
        rad_to_deg = 180/pi;                    % [deg]
        deg_to_rad = pi/180;                    % [rad]
%% Inputs
    % Constants
        % Radius of Earth
            re_km = 6378.145;                             % Radius of Earth [km]
            re_nmi = re_km * km_to_ft * ft_to_nmi;        % Radius of Earth [nmi]
            re_ft = re_km * km_to_ft;                     % Radius of Earth [ft]
        % Gravitational Parameter
            mu_m = 398691.2;                              % Gravitational Parameter [km^3/sec^2]
            mu_e_ft = 1.407646882e16;                     % Gravitational Parameter [ft^3/sec^2]
            mu_e = mu_e_ft * (ft_to_nmi)^3;               % Gravitational Parameter [nmi^3/sec^2]
    % Request User Input
        % Units
            unit_prompt = "Enter input unit type, (1=km 2=nmi) :";
            unit = input(unit_prompt);
            
            if unit == 1
                % Metric
                    re = re_km;
                    mu = mu_m;
                    
                    % Perigee altitude
                        hp_prompt = "Enter the Perigee altitude [km] :";
                        hp = input(hp_prompt);                           % Desired Perigee altitude
                    % Apogee altitude
                        ha_prompt = "Enter the Apogee altitude [km] :";
                        ha = input(ha_prompt);                           % Desired Apogee altitude
            else
                % English
                    re = re_nmi;
                    mu = mu_e;
                    
                    % Perigee altitude
                        hp_prompt = "Enter the Perigee altitude [nmi] :";
                        hp = input(hp_prompt);                          % Desired Perigee altitude
                    % Apogee altitude
                        ha_prompt = "Enter the Apogee altitude [nmi] :";
                        ha = input(ha_prompt);                           % Desired Apogee altitude
            end
        % True Anomaly Angle
            true_anomaly_prompt = "True Anomaly [deg] :";
            theta_d = input(true_anomaly_prompt);            % [deg]
            theta = theta_d * pi/180;                       % [rad]
 
%% Calculate
    % Prep
        rp = hp + re;       % Periapsis Radius
        ra = ha + re;       % Apoapsis Radius
    
    % Outputs
        % Semimajor axis,a (km and nmi)
            a = (ra + rp)/2;    
        % Eccentricity,e (e)
            e = (ra - rp)/(ra + rp);
        % Semilatus rectum,p (km and nmi)
            p = rp * (1 + e);
        % Radial velocity,vr (km/sec and nmi/sec)
            vr = (sqrt(mu/p)) * e * sin(theta);
        % Normal velocity,nv (km/sec and nmi/sec)
            vn = (sqrt(mu/p)) * (1 + e*cos(theta));
        % Total velocity,v (km/sec and nmi/sec)
            vt = sqrt(vn^2 + vr^2);
        % Velocity at Perigee,vp (km/sec and nmi/sec)
            vp = (sqrt(mu/p)) * (1+e);
        % Velocity at Apogee,va (km/sec and nmi/sec)
            va = (sqrt(mu/p)) * (1-e);
        % Period,T of the orbit (min)
            T = (2 * pi * a^(3/2)) / sqrt(mu);            
        % Specific angular momentum,h (m2/sec and ft2/sec)
            h = rp * vp;
        % Radius,r of the orbit at the true anomaly angle (km and nmi)
            r = (h^2 / mu) * (1/(1 + e*cos(theta)));
        % Energy,eps at the true anomaly angle (m2/sec2 and ft2/sec2)
            eps = -mu/(2*a);
        % Required escape velocity,vesc at the true anomaly angle (km/sec and nmi/sec)
            vesc = sqrt((2*mu) / r);
        % Flight path angle,gamma at the true anomaly angle (deg) [careful of the sign]
            gamma = atan((e*sin(theta)) / (1 + e*cos(theta)));
        % Specific angular momentum,h (m2/sec and ft2/sec)
            %(above)
%% Convert Units        
    if unit == 1
        % Semimajor axis,a (km and nmi)
            a_m = a;
            a_e = a * km_to_nmi;
        % Eccentricity,e (-)
            % unitless
        % Semilatus rectum,p (km and nmi)
            p_km = p;
            p_nmi = p * km_to_nmi;
        % Radial velocity,vr (km/sec and nmi/sec)
            vr_m = vr;
            vr_e = vr * km_to_nmi;
        % Normal velocity,nv (km/sec and nmi/sec)
            vn_m = vn;
            vn_e = vn * km_to_nmi;
        % Total velocity,v (km/sec and nmi/sec)
            vt_m = vt;
            vt_e = vt * km_to_nmi;
        % Velocity at Perigee,vp (km/sec and nmi/sec)
            vp_m = vp;
            vp_e = vp * km_to_nmi;
        % Velocity at Apogee,va (km/sec and nmi/sec)
            va_m = va;
            va_e = va * km_to_nmi;
        % Period,T of the orbit (min)
            TP = T * sec_to_min;
        % Radius,r of the orbit at the true anomaly angle (km and nmi)
            r_km = r;
            r_nmi = r * km_to_nmi;
        % Energy,eps at the true anomaly angle (m2/sec2 and ft2/sec2)
            eps_m = eps * (km_to_m)^2;
            eps_e = eps * (km_to_ft)^2;
        % Required escape velocity,vesc at the true anomaly angle (km/sec and nmi/sec)
            vesc_m = vesc;
            vesc_e = vesc * km_to_nmi;
        % Flight path angle,gamma at the true anomaly angle (deg) [careful of the sign]
            gm = gamma * rad_to_deg;
        % Specific angular momentum,h (m2/sec and ft2/sec)
            h_m = h * (km_to_m)^2;
            h_e = h * (km_to_ft)^2;
    else
        % Semimajor axis,a (nmi and km)
            a_e = a;
            a_m = a * nmi_to_km;
        % Eccentricity,e (-)
            % unitless
        % Semilatus rectum,p (nmi and km)
            p_nmi = p;
            p_km = p * nmi_to_km;
        % Radial velocity,vr (nmi/sec and km/sec)
            vr_e = vr;
            vr_m = vr * nmi_to_km;
        % Normal velocity,nv (nmi/sec and km/sec)
            vn_e = vn;
            vn_m = vn * nmi_to_km;
        % Total velocity,v (nmi/sec and km/sec)
            vt_e = vt;
            vt_m = vt * nmi_to_km;
        % Velocity at Perigee,vp (nmi/sec and km/sec)
            vp_e = vp;
            vp_m = vp * nmi_to_km;
        % Velocity at Apogee,va (nmi/sec and km/sec)
            va_e = va;
            va_m = va * nmi_to_km;
        % Period,T of the orbit (min)
            TP = T * sec_to_min;
        % Radius,r of the orbit at the true anomaly angle (nmi and km)
            r_nmi = r;
            r_km = r * nmi_to_km;
        % Energy,eps at the true anomaly angle (ft2/sec2 and m2/sec2)
            eps_e = eps * (nmi_to_ft)^2;
            eps_m = eps * (nmi_to_m)^2;
        % Required escape velocity,vesc at the true anomaly angle (nmi/sec and km/sec)
            vesc_e = vesc;
            vesc_m = vesc * nmi_to_km;
        % Flight path angle,gamma at the true anomaly angle (deg) [careful of the sign]
            gm = gamma * rad_to_deg;
        % Specific angular momentum,h (ft2/sec and m2/sec)
            h_e = h * (nmi_to_ft)^2;
            h_m = h * (nmi_to_m)^2;
    end
%% Outputs
    fprintf('The semimajor axis,     a  = %+.15e [km]         or  %+.15e [nmi]\n', a_m, a_e);
    fprintf('The eccentricity,       e  = %+.15e [-]\n', e);
    fprintf('The semilatus rectum,   p  = %+.15e [km]         or  %+.15e [nmi]\n', p_km, p_nmi);
    fprintf('The radial velocity,    vr = %+.15e [km/sec]     or  %+.15e [nmi/sec]\n', vr_m, vr_e);
    fprintf('The normal velocity,    vn = %+.15e [km/sec]     or  %+.15e [nmi/sec]\n', vn_m, vn_e);
    fprintf('The total velocity,     v  = %+.15e [km/sec]     or  %+.15e [nmi/sec]\n', vt_m, vt_e);
    fprintf('The perigee velocity,   vp = %+.15e [km/sec]     or  %+.15e [nmi/sec]\n', vp_m, vp_e);
    fprintf('The apogee velocity,    va = %+.15e [km/sec]     or  %+.15e [nmi/sec]\n', va_m, va_e);
    fprintf('The orbit period,       T  = %+.15e [min]\n', TP);
    fprintf('The radius at theta,    r  = %+.15e [km]         or  %+.15e [nmi]\n', r_km, r_nmi);
    fprintf('The energy at theta,    ep = %+.15e [m^2/sec^2]  or  %+.15e [ft^2/sec^2]\n', eps_m, eps_e);
    fprintf('The escape velocity,    ve = %+.15e [km/sec]     or  %+.15e [nmi/sec]\n', vesc_m, vesc_e);
    fprintf('The flight path angle,  gm = %+.15e [deg]\n', gm);
    fprintf('The angular momentum,   h  = %+.15e [m^2/sec]    or  %+.15e [ft^2/sec]\n', h_m, h_e);
