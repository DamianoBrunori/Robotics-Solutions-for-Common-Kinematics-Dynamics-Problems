function DH_matrix = compute_DH_matrix(alpha, theta, a, d)
    
    degrees_range = -360:1:360;
    
    % It is not possible to use cosd and sin with symbolic matlab, thus if the current angle is symbolic,
    % it is NOT needed to convert the angles from degrees to radians (thus for symbolic will be used radians).
    if ismember(theta, degrees_range)
        cos_theta = cosd(double(theta));
        sin_theta = sind(double(theta));
    % Otherwise use degrees. Mixing degrees and radians does not affect the final result, because degrees are used
    % in case of specific angles values (like 0, 90, ...) and then a specific value will be returned in
    % degrees; while radians are used in case of symbolic angle values (q1, a2, ...) and then will be returned symbolic
    % results (which will not evaluated).
    
    % REMARK: IF YOU EVALUTATE THE SYMBOLIC VALUES, THEY WILL RETURN RADIANS VALUES AND TO COMPARES TO THE DEGREES VALUE (WHICH ARE
    % IN THE MATRIX), IT IS NEEDED TO PERFORM THE CONVERTION THROUGH  'degtorad' function (indeed this procedure will be applied in 'DH_GUI.m').
    else
        cos_theta = cos(theta);
        sin_theta = sin(theta);
    end
    
    % The same procedure is performed for 'alpha' angle:
    if ismember(alpha, degrees_range)
        cos_alpha = cosd(double(alpha));
        sin_alpha = sind(double(alpha));
    else
        cos_alpha = cos(alpha);
        sin_alpha = sin(alpha);
        
    end
    
    DH_matrix = [cos_theta -cos_alpha*sin_theta sin_alpha*sin_theta a*cos_theta;
                         sin_theta cos_alpha*cos_theta -sin_alpha*cos_theta a*sin_theta;
                         0          sin_alpha            cos_alpha          d;
                         0          0                     0                 1];
    
    % It is not possible to use cosd and sin with symbolic matlab, thus it is needed to convert the angles from degrees to radians
    % (passing them to cos an sin) in order to obtain theta and alpha in degrees.
    %theta_grad = degtorad(theta);
    %alpha_grad = degtorad(alpha);
                     
    %DH_matrix_degrees = [cos(theta_grad)  -cos(alpha_grad)*sin(theta_grad)  sin(alpha_grad)*sin(theta_grad) a*cos(theta_grad);
    %                     sin(theta_grad)   cos(alpha_grad)*cos(theta_grad) -sin(alpha_grad)*cos(theta_grad) a*sin(theta_grad);
    %                     0                 sin(alpha_grad)                  cos(alpha_grad)                 d;
    %                     0                 0                                0                               1];
    
    % Set to 0 the values which are very close to the 0 (they are diferrent form 0 because of 'infinite' precision of Matlab)
    %index_to_set_to_zero = DH_matrix_degrees(:)<1e-6;
    %DH_matrix_degrees(index_to_set_to_zero) = 0;
    
                     
end

