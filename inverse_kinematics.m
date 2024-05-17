% To be modified here at wish:
syms q1 q2 real
% To be modified here at wish:
q_list = [q1, q2];

% DIRECT KINEMATICS MATRIX
% To be modified here at wish (insert as a column vector) . . .
f_r = [ cos(q1)/5 - q2*sin(q1);
        sin(q1)/5 + q2*cos(q1)]; % d1 + . . .

iterations_number = nan;
stopping_threshold = nan;
singularity_closeness_threshold = nan;
initial_guess(1:length(q_list)) = nan;
% TO be modified based on the component of the desired 'p':
p_desired(1:2) = nan;
alpha_step_size = nan;

computationOK1 = [false false false false];
computationOK2 = [false false false false];

choice = menu('Do you want to use a fixed number of iterations ?', 'Yes', 'No');

while true

    if all(computationOK1)
        break
    else
        get(0,'DefaultUicontrolFontsize')
        iteration_choice = menu('Main parameters setting', 'iterations number', 'initial guess', 'step size', 'p (or r) desired');
    end
    
    if choice == 1
        if iteration_choice == 1
            prompt = {'Enter the iterations number'};
            dlg_title = 'ITERATIONS';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            empty_field = find(cellfun('isempty',answer));
            if ~isempty(empty_field)
                message = 'You missed the number of iterations';
                msgbox(message);
                computationOK1(1) = false;
                continue;
            else
                computationOK1(1) = true;
            end

            iterations_number = str2num(answer{1});
        elseif iteration_choice == 2
            element_for_initial_guess = length(initial_guess);
            for i=1:1:element_for_initial_guess
                prompt{i} = num2str(i); 
            end
            dlg_title = 'INITIAL GUESS';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            empty_field = find(cellfun('isempty',answer));
            if ~isempty(empty_field)
                message = 'You missed one or more values for INITIAL GUESS';
                msgbox(message);
                computationOK1(2) = false;
                continue;
            else
                computationOK1(2) = true;
            end

            for i=1:1:element_for_initial_guess
                initial_guess(i) = str2num(answer{i});
            end
        elseif iteration_choice == 3
            prompt = {'Enter AlPHA value for the STEP SIZE'};
            dlgtitle = 'STEP SIZE';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            empty_field = find(cellfun('isempty',answer));
            if ~isempty(empty_field)
                message = 'You missed the step size value';
                msgbox(message);
                computationOK1(3) = false;
                continue;
            else
                computationOK1(3) = true;
            end

            alpha_step_size = str2num(answer{1});
        elseif iteration_choice == 4
            % To be modified here based on the size of the desired 'p' (prompt will contain as many 'numbers' as the size of the desired 'p'):
            prompt = {'1', '2'};
            dlgtitle = 'P DESIRED';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            empty_field = find(cellfun('isempty',answer));
            if ~isempty(empty_field)
                message = 'You missed one or more values for P DESIRED';
                msgbox(message);
                computationOK1(4) = false;
                continue;
            else
                computationOK1(4) = true;
            end

            elements_for_p_desired = length(p_desired);
            for i=1:1:elements_for_p_desired
                p_desired(i) = str2num(answer{1});
            end
        end

    elseif choice == 2
        
        if all(computationOK1)
            break
        else
            get(0,'DefaultUicontrolFontsize')
            inner_choiche = menu('Main parameters setting', 'initial guess', 'step size', 'p (or r) desired', 'stopping threshold', 'closeness to a singularity');
        end

        if inner_choice == 1
            prompt = {'1', '2', '3'};
            dlg_title = 'INITIAL GUESS';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            empty_field = find(cellfun('isempty',answer));
            if ~isempty(empty_field)
                message = 'You missed one or values for INITIAL GUESS';
                msgbox(message);
                computationOK2(1) = false;
                continue;
            else
                computationOK2(1) = true;
            end

            elements_for_initial_guess = length(initial_guess);
            for i=1:1:elements_for_initial_guess
                initial_guess(i) = str2num(answer{i});
            end

        elseif inner_choice == 2
            prompt = {'Enter AlPHA value for the STEP SIZE'};
            dlg_title = 'STEP SIZE';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            if ~isempty(empty_field)
                message = 'You missed the value for STEP SIZE';
                msgbox(message);
                computationOK2(2) = false;
                continue;
            else
                computationOK2(2) = true;
            end

            alpha_step_size = str2num(answer{1});

        elseif inner_choice == 3
            prompt = {'1', '2', '3'};
            dlg_title = 'P DESIRED';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            if ~isempty(empty_field)
                message = 'You missed one or values for P DESIRED';
                msgbox(message);
                computationOK2(3) = false;
                continue;
            else
                computationOK2(3) = true;
            end

            elements_for_p_desired = length(p_desired);
            for i=1:1:elements_for_p_desired
                p_desired(i) = str2num(answer{1});
            end

        elseif inner_choice == 4
            prompt = {'threshold for ALGORITHM INCREMENT stopping criteria'};
            dlg_title = 'STOPPING CRITERIA';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            if ~isempty(empty_field)
                message = 'You missed the values for STOPPING CRITERIA';
                msgbox(message);
                computationOK2(4) = false;
                continue;
            else
                computationOK2(4) = true;
            end

            stopping_threshold = str2num(answer{1});

        elseif inner_choice == 5
            prompt = {'threshold to indicates the SINGULARITY CLOSENESS'};
            dlg_title = 'SINGULARITY CLOSENESS';
            answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);

            if ~isempty(empty_field)
                message = 'You missed the values for SINGULARITY CLOSENESS';
                msgbox(message);
                computationOK2(4) = false;
                continue;
            else
                computationOK2(4) = true;
            end

            singularity_closeness_threshold = str2num(answer{1});
        end
        
    end

end

graph = false;
graph_choice = menu('Do you want to create also a graph for joint variables and error ?', 'Yes', 'No');

if graph_choice == 1
    graph = true;
elseif graph_choice == 2
    graph = false;
end

if graph == true
    iterations_number_for_plot = iterations_number + 1;
    cartesian_error_components(1:iterations_number_for_plot, 1:elements_for_p_desired) = nan;
    cartesian_error_components(1, 1:elements_for_p_desired) = 0;
    components = length(cartesian_error_components(1,1:end));
    num_variables = length(q_list);
    q_variables(1:iterations_number_for_plot, 1:num_variables) = nan;
    q_variables(1, 1:num_variables) = 0;
    error_position_norm(1:iterations_number_for_plot) = nan;
end

if choice == 1
    prev_q = initial_guess;
    Jacobian = jacobian(f_r, q_list);
    
    singular_threshold = 0.5;
    increment_threshold = 0.02;
    
    for iteration=1:1:iterations_number
        
        if iteration ~= 1
            algorithm_increment = norm(q_variables(iteration, 1:end) - q_variables(iteration-1, 1:end));
            if algorithm_increment <= increment_threshold
                fprintf('Stopping Criteria Verified');
                break;
            end
        end
        
        % Ensure which it starts with Gradient descendent method:
        if (iteration ~= 1) && (algorithm_increment < increment_threshold) && (det(Jacobian) <= singular_threshold)
            fprintf('NEWTON Method');
            [prev_q, error_components, error_norm] = newton_for_inv_kinematics(prev_q, p_desired, f_r, alpha_step_size, q_list, Jacobian, graph);
            if graph == true
                cartesian_error_components(iteration+1, 1:elements_for_p_desired) = error_components;
                q_variables(iteration+1, 1:num_variables) = prev_q;
                error_position_norm(iteration+1) = error_norm;
            end
            
        else
            fprintf('GRADIENT Method');
            [prev_q, error_components, error_norm] = gradient_for_inv_kinematics(prev_q, p_desired, f_r, alpha_step_size, q_list, Jacobian, graph);
            if graph == true
                cartesian_error_components(iteration+1, 1:elements_for_p_desired) = error_components;
                q_variables(iteration+1, 1:num_variables) = prev_q;
                error_position_norm(iteration+1) = error_norm;
            end
        end
        fprintf('Iteration: %d\n', iteration)
    end
    
else
    while (algorithm_increment > stopping_threshold)
        % TO BE IMPLEMENTED . . .
    end
end

if graph == true
    for i=1:1:elements_for_p_desired
        figure('Name', ['Components Joint q', num2str(i)]);
        % Plotting the joint variables components:
        %subplot(2,2,1);
        plot(0:iterations_number, q_variables(1:iterations_number_for_plot,i));
        xlabel('Iterations');
        ylabel(['q', num2str(i)]);
        set(gca, 'XTick', 0:2:iterations_number_for_plot); 
    end
    
    i = i + 1;
    figure('Name', ['Cartesian Error Components', num2str(i)]);
    
    % Plotting the error components:
    subplot(2,2,1);
    plot(0:iterations_number, cartesian_error_components(1:iterations_number_for_plot,1));
    xlabel('Iterations');   
    ylabel('ex');
    set(gca, 'XTick', 1:2:iterations_number_for_plot);
    
    subplot(2,2,2);
    plot(0:iterations_number, cartesian_error_components(1:iterations_number_for_plot,2));
    xlabel('Iterations');
    ylabel('ey');
    set(gca, 'XTick', 1:2:iterations_number_for_plot);

    subplot(2,2,[3,4]);
    plot(0:iterations_number, cartesian_error_components(1:iterations_number_for_plot,3));
    xlabel('Iterations');
    ylabel('ez');
    set(gca, 'XTick', 1:1:iterations_number_for_plot);
    
    % Plotting the norm error:
    i = i + 1;
    figure('Name', ['Norm of Cartesian Position Error', num2str(i)]);
    plot(0:iterations_number, error_position_norm(1:iterations_number_for_plot));
    xlabel('Iterations');
    ylabel('Norm Error');
    set(gca, 'XTick', 1:2:iterations_number_for_plot);
    
elseif graph == false
    return;
end