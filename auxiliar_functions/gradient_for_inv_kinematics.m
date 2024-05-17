function [next_q, error_components, error_norm] = gradient_for_inv_kinematics(prev_q, p_d, f_r, alpha, q_list, Jacobian, graph)
    
    % error = [r_d - f_r(q^k)], where 'k' indicates only the k-th iteration and NOT the power
    %prev_q
    error = p_d' - f_r;
    if graph == true
        error_components = eval(subs(error, q_list, prev_q));
        error_norm = norm(error_components);
    else
        error_components = nan;
        error_norm = nan;
    end
    %error = subs(error, q_list, prev_q);
    %error
    
    %prev_Jacobian = subs(Jacobian, q_list, prev_q);
    %prev_Jacobian
    
    %next_q = prev_q' + (alpha * prev_Jacobian') * error;
    next_q = prev_q + ((alpha * Jacobian') * error)'; 
    next_q = eval(subs(next_q, q_list, prev_q));
    %next_q
end