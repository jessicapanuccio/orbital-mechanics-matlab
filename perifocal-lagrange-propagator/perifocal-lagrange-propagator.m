%% Units
    % 1 nm = 6076.115485564304 ft
    % meu 398601.2 km3/sec2
    % meu 1.407646882e16 ft3/sec2
%% Declare Function
    function [r_v,v_v,h,e,vr0,r,f,g,fdot,gdot]=f_g_f(r0_v,v0_v,d_theta,unit_type)
        % Units
            nmi_over_ft = 1 / 6076.115485564304;         % [nmi/ft]   
            ft_over_nmi = 6076.115485564304 / 1;         % [ft/nmi]
        if unit_type == 1
            % Metric
                % Constants
                    meu = 398601.2;                                                             % meu, Gravitational Parameter [km^3/sec^2]
                % Calculations & Outputs
                    r0_s = sqrt(dot(r0_v,r0_v));                                                % r0_s, initial position scalar, (km)
                    v0_s = sqrt(dot(v0_v,v0_v));                                                % v0_s, initial velocity scalar, (km/sec)
                    vr0 = dot(r0_v,v0_v) / r0_s;                                                % vr0, initial radial velocity, (km/sec)
                    h = r0_s * sqrt(v0_s^2 - vr0^2);                                            % h, specific angular momentum, (km^2/sec)
                    r = (h^2/meu) * (1/(1+((((h^2/(meu*r0_s))-1).*cosd(d_theta)) - (((h*vr0)/meu)*sind(d_theta)))));           % r, magnitude of final position vector, (km)
                    f = 1 - (((meu*r)/h^2)*(1-cosd(d_theta)));                                  % f, Lagrange Coefficients, (---)
                    g = ((r*r0_s) / h) * sind(d_theta);                                         % g, Lagrange Coefficients, (sec)
                    fdot = (meu/h) * ((1-cosd(d_theta))/sind(d_theta)) * (((meu/h^2)*(1-cosd(d_theta)))-(1/r0_s)-(1/r));    % fdot, Lagrange Coefficients, (1/sec)
                    gdot = 1-(((meu*r0_s)/h^2)*(1-cosd(d_theta)));                              % gdot, Lagrange Coefficients, (---)                
                    r_v = (f*r0_v) + (g*v0_v);                                                  % r_v, final position vector, (km)
                    v_v = (fdot*r0_v) + (gdot*v0_v);                                            % v_v, final velocity vector, (km/sec)
                    e = sqrt( ((h*vr0)/meu)^2 + (((h^2)/(meu*r0_s))-1)^2 );                     % e, eccentricity of the orbit, (---)
        else
            % British
                % Constants
                    meu = 1.407646882e16;                                                       % meu, Gravitational Parameter [ft^3/sec^2]
                    %meu = 1.407646882e16 * (nmi_over_ft)^3;                                     % meu, Gravitational Parameter [nmi^3/sec^2]
                % Calculations & Outputs
                    r0_s = sqrt(dot(r0_v,r0_v));                                                % r0_s, initial position scalar, (nmi)
                    v0_s = sqrt(dot(v0_v,v0_v));                                                % v0_s, initial velocity scalar, (nmi/sec)
                    vr0 = dot(r0_v,v0_v) / r0_s;                                                % vr0, initial radial velocity, (nmi/sec)
                    h = (r0_s * sqrt(v0_s^2 - vr0^2)) * (ft_over_nmi^2);                        % h, specific angular momentum, (ft^2/sec)
                    r = nmi_over_ft*((h^2/meu) * (1/(1+((((h^2/(meu*r0_s*ft_over_nmi))-1)*cosd(d_theta)) - (((h*vr0*ft_over_nmi)/meu)*sind(d_theta))))));           % r, magnitude of final position vector, (nmi)
                    f = 1 - (((meu*r*ft_over_nmi)/h^2)*(1-cosd(d_theta)));                                  % f, Lagrange Coefficients, (---)
                    g = ((r*ft_over_nmi*r0_s*ft_over_nmi) / h) * sind(d_theta);                                         % g, Lagrange Coefficients, (sec)
                    fdot = (meu/h) * ((1-cosd(d_theta))/sind(d_theta)) * (((meu/h^2)*(1-cosd(d_theta)))-(1/(r0_s*ft_over_nmi))-(1/(r*ft_over_nmi)));    % fdot, Lagrange Coefficients, (1/sec)
                    gdot = 1-(((meu*r0_s*ft_over_nmi)/h^2)*(1-cosd(d_theta)));                              % gdot, Lagrange Coefficients, (---)                
                    r_v = (f*r0_v) + (g*v0_v);                                                  % r_v, final position vector, (nmi)
                    v_v = (fdot*r0_v) + (gdot*v0_v);                                            % v_v, final velocity vector, (nmi/sec)
                    e = sqrt( ((h * vr0*ft_over_nmi)/meu)^2 + (((h^2)/(meu*r0_s*ft_over_nmi))-1)^2 );                     % e, eccentricity of the orbit, (---)
        end
    end
