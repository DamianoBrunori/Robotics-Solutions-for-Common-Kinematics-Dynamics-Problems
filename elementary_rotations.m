% Elementary matrices for ROLL, PITCH and YAW

computationOK1 = [false false false false];

while true
    
    if all(computationOK1)
        break
    else
        get(0,'DefaultUicontrolFontsize')
        choice = menu('Simboical Angle Selection', 'roll angle (X)', 'pitch angle (Z)', 'yaw angle (Y)', 'rotation axis order');
    end
    
    
    if choice == 1
        prompt = {'Enter the ROLL angle'};
        dlg_title = 'ROLL (X)';
        answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed the ROLL value';
            msgbox(message);
            computationOK1(1) = false;
            continue;
        else
            computationOK1(1) = true;
        end
        
        syms(answer{1});
        roll = sym(answer{1});
    elseif choice == 2
        prompt = {'Enter the PITCH angle'};
        dlg_title = 'PITCH (Z)';
        answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed the PITCH value';
            msgbox(message);
            computationOK1(2) = false;
            continue;
        else
            computationOK1(2) = true;
        end
        
        syms(answer{1});
        pitch = sym(answer{1});
    elseif choice == 3
        prompt = {'Enter the YAW angle'};
        dlg_title = 'YAW (Y)';
        answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed the YAW value';
            msgbox(message);
            computationOK1(3) = false;
            continue;
        else
            computationOK1(3) = true;
        end
        
        syms(answer{1});
        yaw = sym(answer{1});
    elseif choice == 4
        prompt = {'first axis', 'second axis', 'third axis'};
        dlg_title = 'ROTATION';
        answer = inputdlg(prompt, dlg_title, [1, length(dlg_title)+40]);
        
        empty_field = find(cellfun('isempty',answer));
        if ~isempty(empty_field)
            message = 'You missed one or more rotation angles';
            msgbox(message);
            computationOK1(4) = false;
            continue;
        else
            computationOK1(4) = true;
        end
        
        rotation_order = cell(1,3);          
        for i=1:1:3
            rotation_order{i} = char(answer(i));
        end
    end
end
        
% ROLL (X):
R_roll = [1     0             0;
          0     cos(roll)     -sin(roll);
          0     sin(roll)     cos(roll)];

% PITCH (Y)
R_pitch = [cos(pitch)     -sin(pitch)         0;
         sin(pitch)       cos(pitch)          0;  
         0                0                   1];

% YAW (Z)      
R_yaw = [cos(yaw)     0         sin(yaw);
         0            1         0;
         -sin(yaw)    0         cos(yaw)];


syms tmp;
rotation_matrices_sorted(1:3, 1:3, 1:3) = tmp;     
     
for i=1:1:3
    if rotation_order{i} == 'x'     
        rotation_matrices_sorted(:, :, i) = R_roll;
    elseif rotation_order{i} == 'y'
        rotation_matrices_sorted(:, :, i) = R_yaw;  
    elseif rotation_order{i} == 'z'     
        rotation_matrices_sorted(:, :, i) = R_pitch;
    end
end

% REVERSE order multiplication for FIXED axes (ROLL, PITCH, YAW:
RPY_associated_rotation_matrix = rotation_matrices_sorted(:, :, 3) * rotation_matrices_sorted(:, :, 2) * rotation_matrices_sorted(:, :, 1); 
RPY_associated_rotation_matrix = simplify(RPY_associated_rotation_matrix);

EULER_associated_rotation_matrix = rotation_matrices_sorted(:, :, 1) * rotation_matrices_sorted(:, :, 2) * rotation_matrices_sorted(:, :, 3);
EULER_associated_rotation_matrix = simplify(EULER_associated_rotation_matrix);


% --------------- Additional desired computations: ---------------

% //////////////////////////////////////////////////////////////////////////////////////////////////////////
% To evaluate the matrix do the following (remember to apply 'degtorad()' to every angles' values):
%{
EULER_associated_rotation_matrix = eval(subs(EULER_associated_rotation_matrix, [angoli], [valori_angoli]));
RPY_associated_rotation_matrix = eval(subs(RPY_associated_rotation_matrix, [angoli], [valori_angoli]));
%}
% //////////////////////////////////////////////////////////////////////////////////////////////////////////



% //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
% In order to compute the T matrix (4x4 homogeneous matrix), after the evaluation of the previous matri, uncomment the following lines:
%{
T(4,4) = nan;
% The following vector must be transposed:
aPab = [inserisci valori]'; % --> represents the displacement betweeen the origins of the 2 reference frames A and B
for i=1:1:4
    if i == 4
        T(i,:) = [0 0 0 1];
        break;
    end
    T(i,1:3) = EULER_associated_rotation_matrix(i, :);
    T(i,4) = aPab(i,1);
end
%}
% /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



% //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
% In order to compute aPa (i.e., the vector from OA to P expressed in frame A), after computing T, uncomment the following lines:
%{
% The following vector must be transposed:
bPb = [inserisci valori]'; % --> represents the vector from OB to P expressed in frame B
bPb = cat(1, bPb, 1); % --> it is needed in order to transform 'bPb' in homogeneous coordinates
aPa = T * bPb; 
%}
% //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

% ------------------------------------------------------------------------------------------------------------------------------------------