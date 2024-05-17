joints_number = nan;
alphas_cell = nan;
thetas_cell = nan;
a_s_cell = nan;
d_s_cell = nan;

next_prompt = {};

computationOK = [false false false false false];

while true
    
    if all(computationOK)
        break
    else
        get(0,'DefaultUicontrolFontsize')
        choice = menu('Select the parameters', 'joint number', 'alpha', 'theta', 'a', 'd');
    end
    
    if choice == 1
        prompt = {'Enter the number of the joints'};
        dlg_title = 'JOINTS';
        answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);
        joints_number = str2num(answer{1});
        if isempty(joints_number)
            message = 'You missed the number of the joints';
            msgbox(message);
            computationOK(1) = false;
        else
            computationOK(1) = true;
        end
        
        for joint=1:1:joints_number
            next_prompt{joint} = num2str(joint);  
        end
    
    elseif choice == 2
        dlg_title = 'Enter the values for ALPHA angles';
        answer = inputdlg(next_prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed one or more ALPHA values';
            msgbox(message);
            computationOK(2) = false;
        else
            computationOK(2) = true;
        end
        
        alphas_cell = answer;
    
    elseif choice == 3
        dlg_title = 'Enter the values for THETA angles';
        answer = inputdlg(next_prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed one or more thetas_cell values';
            msgbox(message);
            computationOK(3) = false;
        else
            computationOK(3) = true;
        end
        
        thetas_cell = answer;
    
    elseif choice == 4
        dlg_title = 'Enter the values for A distances';
        answer = inputdlg(next_prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed one or more A values';
            msgbox(message);
            computationOK(4) = false;
        else
            computationOK(4) = true;
        end
        
        a_s_cell = answer;
    
    elseif choice == 5
        dlg_title = 'Enter the values for D distances';
        answer = inputdlg(next_prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed one or more D values';
            msgbox(message);
            computationOK(5) = false;
        else
            computationOK(5) = true;
        end
        
        d_s_cell = answer;
    
    end
    
end

syms tmp

alphas(1:1, 1:joints_number) = tmp; 
thetas(1:1, 1:joints_number) = tmp;
a_s(1:1, 1:joints_number) = tmp;
d_s(1:1, 1:joints_number) = tmp;

variables_parameters = []; % --> it will store the list of the symbolic parameters (e.g. q1, q2, a1, d2, L, M, . . .)

for i=1:1:joints_number
    
    if isempty(str2num(alphas_cell{i}))
        if alphas_cell{i}(1) == '-'
            simbolic = alphas_cell{i}(1, 2:end);
            variables_parameters = cat(2, variables_parameters, sym(simbolic, 'real'));
            syms(simbolic, 'real');
            alphas(1,i) = -sym(simbolic, 'real');
        else
            variables_parameters = cat(2, variables_parameters, sym(alphas_cell{i}, 'real'));
            syms(alphas_cell{i}, 'real');
            alphas(1,i) = sym(alphas_cell{i}, 'real');
        end
    else
        alphas(1,i) = str2num(alphas_cell{i});

    end    
    if isempty(str2num(thetas_cell{i}))
        
        if thetas_cell{i}(1) == '-'
            simbolic = thetas_cell{i}(1, 2:end);
            variables_parameters = cat(2, variables_parameters, sym(simbolic), 'real');
            syms(simbolic, 'real');
            thetas(1,i) = -sym(simbolic, 'real');
        else
            variables_parameters = cat(2, variables_parameters, sym(thetas_cell{i}, 'real'));
            syms(thetas_cell{i}, 'real');
            thetas(1,i) = sym(thetas_cell{i}, 'real');
        end
    else
        thetas(1,i) = str2num(thetas_cell{i});
    end
    if isempty(str2num((a_s_cell{i})))
        if a_s_cell{i}(1) == '-'
            simbolic = a_s_cell{i}(1, 2:end);
            variables_parameters = cat(2, variables_parameters, sym(simbolic, 'real'));
            syms(simbolic, 'real');
            a_s(1,i) = -sym(simbolic, 'real');
        else
            variables_parameters = cat(2, variables_parameters, sym(a_s_cell{i}, 'real'));
            syms(a_s_cell{i}, 'real');
            a_s(1,i) = sym(a_s_cell{i}, 'real');
        end
    else
        a_s(1,i) = str2num(a_s_cell{i});
    end
    if isempty(str2num(d_s_cell{i}))
        
        if d_s_cell{i}(1) == '-'
            simbolic = d_s_cell{i}(1, 2:end);
            variables_parameters = cat(2, variables_parameters, sym(simbolic, 'real'));
            syms(simbolic, 'real');
            d_s(1,i) = -sym(simbolic, 'real');
        else
            variables_parameters = cat(2, variables_parameters, sym(d_s_cell{i}, 'real'));
            syms(d_s_cell{i}, 'real');
            d_s(1,i) = sym(d_s_cell{i}, 'real');
        end
    else
        d_s(1,i) = str2num(d_s_cell{i});

    end
end

DH_table(1:4, 1:joints_number) = tmp; % --> the parameters in the DH table are 4
DH_table(1,:) = alphas;
DH_table(2,:) = thetas;
DH_table(3,:) = a_s;
DH_table(4,:) = d_s;

%DH_matrices_radians(1:4, 1:4, 1:joints_number) = tmp;
homogeneous_transformation_matrices(1:4, 1:4, 1:joints_number) = tmp;

for current_joint=1:1:joints_number
    current_parameters = DH_table(:,current_joint); % --> we have 4 parameter for each row in the DH table
    % i_th Denavit-Hartenberg matrix:
    current_DH_matrix = compute_DH_matrix(current_parameters(1), current_parameters(2), current_parameters(3), current_parameters(4));
    %DH_matrices_radians(:,:,current_joint) = current_DH_matrix_radians;
    homogeneous_transformation_matrices(:,:,current_joint) = current_DH_matrix;
end

direct_kinematics = eye(4);

for joint=1:1:joints_number
    direct_kinematics = simplify(direct_kinematics * homogeneous_transformation_matrices(:,:,joint));
end

% You can choose if applying the operation's simplification at each
% multiplication or at the end of all the multiplications (se in the
% following commented line):
%direct_kinematics = simplify(direct_kinematics);

% p end-effector in h (homogeneous) coordinates (it is the last column of the direct_kinematics matrix)
p_ee_h = direct_kinematics(:,4); % --> the direct kinematics matrix (it also includes the '1' of the homogeneous form)
R_ee_h = direct_kinematics(:, 1:3);

values_parameters = nan;
variables_parameters = sort(variables_parameters);

p_desired = nan;

computationOK2 = [false false];

choice = menu('Do you want to perform a numerical solution for a position 0pd (in frame 0) of a Npd (desired position in the last frame N)?','Yes','No');
if choice == 0 || choice == 2
    return;
end

while true
    
    if all(computationOK2)
        break
    else
        get(0,'DefaultUicontrolFontsize')
        choice = menu('Enter the values', 'Parameters', 'P desired');
    end
    
    if choice == 1
       
        parameters_prompt = {};
        parameters_number = length(variables_parameters);
        for i=1:1:parameters_number
            parameters_prompt{i} = char(variables_parameters(i));
        end
    
        dlg_title = 'SETTING';
        answer = inputdlg(parameters_prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed one or more PARAMETERS values';
            msgbox(message);
            computationOK2(1) = false;
            continue;
        else
            computationOK2(1) = true;
        end
        
        for i=1:1:parameters_number
            if ismember(variables_parameters(i), alphas) || ismember(variables_parameters(i), thetas)
                values_parameters(i) = degtorad(str2num(answer{i})); % --> otherwise it will return a result in radians (e.g., -> cos(90)=-0.4481 instead of cos(90)=0)
                % Actually we do not get exactly 0, ma a value very close
                % to 0 (later on it could be necessary to such values
                % exactly equal to 0)
            else
                values_parameters(i) = str2num(answer{i});
            end
        end
        
    elseif choice == 2
        
        % TO BE IMPLEMENTED the possibility to ad a symbolic 'pd' . . .
        
        p_desired_prompt = {};
        for i=1:1:3
            p_desired_prompt{i} = num2str(i);
        end
        
        dlg_title = 'P DESIRED';
        answer = inputdlg(p_desired_prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed one or more P DESIRED values';
            msgbox(message);
            computationOK2(2) = false;
            continue;
        else
            computationOK2(2) = true;
        end
        
        
        p_desired_length = length(p_desired_prompt);
        for i=1:1:p_desired_length
            p_desired(i) = str2num(answer{i});
        end
        
    end

end

% p desired (in frame N, i.e. the last one) in homogeneous coordinates:
p_desired_h = cat(2, p_desired, 1); % --> ('1' to get the 'homogeneous shape')

% 0 p desired (in frame 0) in homogeneous coordinates (SYMBOLIC):
zero_p_desired_h = direct_kinematics * p_desired_h';

% Numerical Evaluation:
zero_p_desired_h_NUMERICAL = subs(zero_p_desired_h, variables_parameters, values_parameters);
% Uncomment the following line if you want to get the result in the 'decimal format' (and not in the 'fraction format'):
%zero_p_desired_h_NUMERICAL = eval(zero_p_desired_h_NUMERICAL);

% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% REMARK --> Always applying 'degtorad()' on angles (in degrees) when replacing them from the command window
% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\