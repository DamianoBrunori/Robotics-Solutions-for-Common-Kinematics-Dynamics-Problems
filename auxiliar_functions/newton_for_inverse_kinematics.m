function [next_q, error_components, error_norm] = newton_for_inverse_kinematics(prev_q, p_d, f_r, q_list, Jacobian, graph)
    
    % error = [r_d - f_r(q^k)], where 'k' indicates only the k-th iteration and NOT the power
    %prev_q
    error = p_d' - f_r;
    if graph == true
        error_components = eval(subs(error, q_list, prev_q));
        error_norm = norm(error_components);
    end
    %error = subs(error, q_list, prev_q);
    %error
    
    %prev_Jacobian = subs(Jacobian, q_list, prev_q);
    %prev_Jacobian
    
    %next_q = prev_q' + (alpha * prev_Jacobian') * error;
    Jacobian_inv = inv(Jacobian);
    next_q = prev_q + (Jacobian_inv * error)'; 
    next_q = eval(subs(next_q, q_list, prev_q));
    %next_q
end