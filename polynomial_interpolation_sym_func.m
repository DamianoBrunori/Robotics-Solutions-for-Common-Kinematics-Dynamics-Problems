% Symbolic definition of the variable related to the polynomials (in the following use case this variable is represented by the time, but
% obviously it can also be represented/replaced by the space):
syms t real

% Symbolic definition of the sampling points where the trajectory must be evaluated (in the following use case we have time samples, but
% obviously they can also be represented/replaced by space samples):
syms t0 t1 t2 tf real

% Symbolic definition of the values related to the 'q_i' positions that we need to use:
syms q0 q1 q2 qf real

% Symbolic definition of the polynomials' COEFFICIENTS (in this specific case, we have 3 coefficients' groups for 3 polynoamials 4-3-4):
syms a0_pol_1 a1_pol_1 a2_pol_1 a3_pol_1 a4_pol_1 real % --> 5 coefficients for a polynomial of degree 4
syms a0_pol_2 a1_pol_2 a2_pol_2 a3_pol_2 real% --> 4 coefficients for a polynomial of degree 3
syms a0_pol_3 a1_pol_3 a2_pol_3 a3_pol_3 a4_pol_3 real % --> 5 coefficients for a polynomial of degree 4

% Setting the lists (as many as the polynomials) containing the coefficients belonging to each defined polynomial:
coefficients_for_pol_1 = [a0_pol_1 a1_pol_1 a2_pol_1 a3_pol_1 a4_pol_1];
coefficients_for_pol_2 = [a0_pol_2 a1_pol_2 a2_pol_2 a3_pol_2];
coefficients_for_pol_3 = [a0_pol_3 a1_pol_3 a2_pol_3 a3_pol_3 a4_pol_3];

number_of_coefficient_for_pol_1 = length(coefficients_for_pol_1);
number_of_coefficient_for_pol_2 = length(coefficients_for_pol_2);
number_of_coefficient_for_pol_3 = length(coefficients_for_pol_3);

% Definition of the INTERPOLATING POLYNOMIALS (4-3-4 in this use case):
pol_1 = symfun(a0_pol_1 + a1_pol_1*t + a2_pol_1*t^2 + a3_pol_1*t^3 + a4_pol_1*t^4, [t]); % -> first polynomial  of degree 4
pol_2 = symfun(a0_pol_2 + a1_pol_2*t + a2_pol_2*t^2 + a3_pol_2*t^3, [t]); % --> second polynomial of degree 3
pol_3 = symfun(a0_pol_3 + a1_pol_3*t + a2_pol_3*t^2 + a3_pol_3*t^3 + a4_pol_3*t^4, [t]); % -> third polynomial of degree 4

pol_1_dot = diff(pol_1, t);
pol_2_dot = diff(pol_2, t);
pol_3_dot = diff(pol_3, t);

pol_1_dot_dot = diff(pol_1_dot, t);
pol_2_dot_dot = diff(pol_2_dot, t);
pol_3_dot_dot = diff(pol_3_dot, t);

% ---------------------------------------------------- CONDITIONS --------------------------------------------------

% Conditions to be set on pos, vel, acc (related to the previous polynomials) in oder to define the trajectory
% (they obviously vary based on the considered case):

% First polynomial conditions:
cond1 = pol_1(t0) == q0;
cond2 = pol_1_dot(t0) == 0;
cond3 = pol_1_dot_dot(t0) == 0;
cond4 = pol_1(t1) == q1;

% Second polynomial conditions:
cond5 = pol_2(t1) == q1;
cond6 = pol_2(t2) == q2;

% Third polynomial conditions:
cond7 = pol_3(t2) == q2;
cond8 = pol_3(tf) == qf;
cond9 = pol_3_dot(tf) == 0;
cond10 = pol_3_dot_dot(tf) == 0;

% Continuity conditions on vel, acc in t1:
cond11 = pol_1_dot(t1) == pol_2_dot(t1);
cond12 = pol_1_dot_dot(t1) == pol_2_dot_dot(t1);

% Continuity conditions on vel, acc in t2:
cond13 = pol_2_dot(t2) == pol_3_dot(t2);
cond14 = pol_2_dot_dot(t2) == pol_3_dot_dot(t2);

% -------------------------------------------------------------------------------------------------------------------

% The following 2 lines have to be modified according to the imposed
% conditions and to the coefficients related to the current considered trajectories:
conditions = [cond1 cond2 cond3 cond4 cond5 cond6 cond7 cond8 cond9 cond10 cond11 cond12 cond13 cond14];
coefficients_to_find_out = [a0_pol_1 a1_pol_1 a2_pol_1 a3_pol_1 a4_pol_1 a0_pol_2 a1_pol_2 a2_pol_2 a3_pol_2 a0_pol_3 a1_pol_3 a2_pol_3 a3_pol_3 a4_pol_3];

SIMBOLIC_coefficients_evaluation = solve(conditions, coefficients_to_find_out);
coefficients_names = fieldnames(SIMBOLIC_coefficients_evaluation);
number_of_coefficients = length(coefficients_names);

% In the following 2 lines, you must isnert the symbolic variables to be replaced with the corresponding numeric values;
% In this specific use case we have t0, t1, t2, tf, q0, q1, q2, qf (obviosuly they can be changed based on the case to be analyzed)
% -- Pay attention to the "variable-value association" between the 2 vectors --:
simbolic_variables_to_substitute = [t0, t1, t2, tf, q0, q1, q2, qf];
values_to_substitute_for_numerical_evaluation = [0, 2, 4, 6, 0, 10, 80, 90];

NUMERICAL_coefficients_evaluation = zeros(1, number_of_coefficients);

for i=1:1:number_of_coefficients
    current_coefficient = getfield(SIMBOLIC_coefficients_evaluation, coefficients_names{i});
    NUMERICAL_coefficients_evaluation(i) = subs(current_coefficient, simbolic_variables_to_substitute, values_to_substitute_for_numerical_evaluation);
end

% Print on the Command Window the names of the coefficients and their corresponding values:
coefficients_names'
NUMERICAL_coefficients_evaluation



% _________________________________________________________ PLOTTING _________________________________________________________

% Set as many 'start_pol' and as many 'end_pol' as the used polynomials:
start_pol_1 = 1; % --> It indicates where STARTING to take the coefficients (from the list of those available) for the first polynomial 
end_pol_1 = number_of_coefficient_for_pol_1; % --> It indicates where FINISHING to take the coefficients (from the list of those available) for the first polynomial 

start_pol_2 = number_of_coefficient_for_pol_1 + 1; % --> It indicates where starting to take the coefficients (from the list of those available) for the second polynomial
end_pol_2 = start_pol_2 + (number_of_coefficient_for_pol_2 - 1); % --> It indicates where FINISHING to take the coefficients (from the list of those available) for the second polynomial

start_pol_3 = end_pol_2 + 1; % --> It indicates where STARTING to take the coefficients (from the list of those available) for the third polynomial
end_pol_3 = start_pol_3 + (number_of_coefficient_for_pol_3- 1); % --> It indicates where FINISHING to take the coefficients (from the list of those available) for the third polynomial

% POSITION w.r.t. 't':
spline1_POS = subs(pol_1, coefficients_for_pol_1, NUMERICAL_coefficients_evaluation(1, start_pol_1:end_pol_1));
spline2_POS = subs(pol_2, coefficients_for_pol_2, NUMERICAL_coefficients_evaluation(1, start_pol_2:end_pol_2));
spline3_POS = subs(pol_3, coefficients_for_pol_3, NUMERICAL_coefficients_evaluation(1, start_pol_3:end_pol_3));

% VELOCITY w.r.t. 't':
spline1_VEL = subs(pol_1_dot, coefficients_for_pol_1, NUMERICAL_coefficients_evaluation(1, start_pol_1:end_pol_1));
spline2_VEL = subs(pol_2_dot, coefficients_for_pol_2, NUMERICAL_coefficients_evaluation(1, start_pol_2:end_pol_2));
spline3_VEL = subs(pol_3_dot, coefficients_for_pol_3, NUMERICAL_coefficients_evaluation(1, start_pol_3:end_pol_3));

% ACCELERATION w.r.t. 't':
spline1_ACC = subs(pol_1_dot_dot, coefficients_for_pol_1, NUMERICAL_coefficients_evaluation(1, start_pol_1:end_pol_1));
spline2_ACC = subs(pol_2_dot_dot, coefficients_for_pol_2, NUMERICAL_coefficients_evaluation(1, start_pol_2:end_pol_2));
spline3_ACC = subs(pol_3_dot_dot, coefficients_for_pol_3, NUMERICAL_coefficients_evaluation(1, start_pol_3:end_pol_3));

% 'Sampling interval' to be set at wish (depending on the desired accuracy for the chart):
timestep = 0.1;
% Initial time to be set (insert the 't0' value):
start_t = 0;
% Final time to be set (insert the 'tf' value):
end_t = 6; 

time_instants = start_t:timestep:end_t;

% To be defined the list of the START time instant for each spline (except for the first spline);
% obviously this must be modified based on the number of splines (and hence on the interavals that have been set):
starts_list = [2, 4];

% The following 'sets' obviously must be fulfilled with as many splines (pos, vel, acc, respectively) as the used polynomials:
POSITION_spline_set = {spline1_POS, spline2_POS, spline3_POS};
VELOCITY_spline_set = {spline1_VEL, spline2_VEL, spline3_VEL};
ACCELERATION_spline_set = {spline1_ACC, spline2_ACC, spline3_ACC};

POSITION_values_to_plot = zeros(1, length(time_instants));
VELOCITY_values_to_plot = zeros(1, length(time_instants));
ACCELERATION_values_to_plot = zeros(1, length(time_instants));

count = 1;
count_spline = 1;
for sample=start_t:timestep:end_t
    if ismember(sample, starts_list)
        count_spline = count_spline + 1;
    end
    POSITION_values_to_plot(1, count) = eval(subs(POSITION_spline_set{:, count_spline}, t, sample)); 
    VELOCITY_values_to_plot(1, count) = eval(subs(VELOCITY_spline_set{:, count_spline}, t, sample));
    ACCELERATION_values_to_plot(1, count) = eval(subs(ACCELERATION_spline_set{:, count_spline}, t, sample));
    
    count = count + 1;
end

figure('Name', 'POSITION');
plot(time_instants, POSITION_values_to_plot)
xlabel('Time or Space');
ylabel('Position');

figure('Name', 'VELOCITY');
plot(time_instants, VELOCITY_values_to_plot)
xlabel('Time or Space');
ylabel('Velocity');

figure('Name', 'ACCELERATION');
plot(time_instants, ACCELERATION_values_to_plot)
xlabel('Time or Space');
ylabel('Acceleration');

grid on

% __________________________________________________________________________________________________________________


% --------------------------------------------------------------------------------------------------------
% In order to evaluate the value of a spline in a specific time instant, you can uncomment the folllowing lines (with i = 1,...total number of splines):
% SPLINE_i_POS(istante_di_interesse_per_la_spline_i)
% SPLINE_i_VEL(istante_di_interesse_per_la_spline_i)
% SPLINE_i_ACC(istante_di_interesse_per_la_spline_i)
% --------------------------------------------------------------------------------------------------------