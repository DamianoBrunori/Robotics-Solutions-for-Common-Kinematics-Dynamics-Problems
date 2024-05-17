% REMARK:
% The sampling time can be replaced by the sampling space; it will be needed
% a preliminary operation (diff, subs, etc.) in order to allow you to get
% the splines equations in such a way that they depend on only a single
% symbolic variable (namely on the variable indicating the sampling time or
% space along the X axis).

% Defintion of the symbolic variables:
syms t

% To be set the number of samples to use:
splines_number = 3;

% To be set as many sampling intervals as the number of the splines

% Set the sampling time of the spline 1:
start_1 = 1;
end_1 = 1;
% Set the sampling time of the spline 2:
start_2 = 2;
end_2 = 2.5;
% Set the sampling time of the spline 3:
start_3 = 2.5;
end_3 = 4;

query = true; % --> to be set to 'true' to enable the 'info' inside the 'plot'

% ---------------------- OPTIONAL --------------------------------------------
% Set the points for which you want to get more info (these are the 'knots' where we each spline starts and ends):
query_points = [1 2 2.5 4];
values_associated_to_query_points = zeros(1, length(query_points));
query_points_instants = query_points;
% -----------------------------------------------------------------------------

% To be defined the list of the STARTING time instant of each spline (except for the FIRST spline);
% this must be modified based on the number of the splines, and hence on the number of the intervals that have been set:
starts_list = [start_2, start_3];

% To be defined the sampling step:
timestep = 0.1;

% THe following 2 values must be changed based on the last interval that has been set:
start_last = start_3;
end_last = end_3;

time_instants = start_1:timestep:end_last;

% Set the splines functions used (pos, vel, acc, ...):
spline1 = (2733071886130243*(t - 1)^2)/8796093022208 - (2337247700130883*(t - 1)^3)/8796093022208 + 45;
spline2 = (5239959277068825*(t - 2)^3)/8796093022208 - (2139334727521901*(t - 2)^2)/4398046511104 - (1545598448522861*t)/8796093022208 + 1941422634522221/4398046511104;
spline3 = (4028924624692157*(t - 5/2)^2)/9895604649984 - (2841452066694077*t)/13194139533312 - (4424748810691517*(t - 5/2)^3)/29686813949952 + 13019787775472305/26388279066624;

% Set the following vector based on the splines previously defined:
splines_set = [[spline1], [spline2], [spline3]];

set_values_to_plot = zeros(1, length(time_instants));

count = 1;
count_spline = 1;
count_query_points = 1;
for sample=start_1:timestep:end_last
    % -------------------------------------------- OPTIONAL -------------------------------------------------------
    if ismember(sample, query_points)
        values_associated_to_query_points(count_query_points) = eval(subs(splines_set(:, count_spline), t, sample));
        count_query_points = count_query_points + 1;
    end
    % --------------------------------------------------------------------------------------------------------------
    if ismember(sample, starts_list)
        count_spline = count_spline + 1;
    end
    % YOU SHOULD REPLACE 't' WITH THE SYMBOLIC VARIABLE DEFINED CASE BY CASE:
    set_values_to_plot(1, count) = eval(subs(splines_set(:, count_spline), t, sample));
    count = count + 1;
end

% ------------------------------------------------------------------------------------------------
% PLOT the splines composition:
figure('Name', 'VAlue inserted by myself');
if query == true
    plot(time_instants, set_values_to_plot, query_points_instants, values_associated_to_query_points, 'ro');
    num_query_values = length(values_associated_to_query_points);
    txts = zeros(1, num_query_values);
    for elem=1:1:num_query_values
        txt = ['\leftarrow' num2str(values_associated_to_query_points(elem))];
        text(query_points_instants(elem) + 0.02, values_associated_to_query_points(elem), txt); 
    end
else
    plot(time_instants, set_values_to_plot);
end
xlabel('Time or Space');
ylabel('Position or Velocity or Acceleration');
grid on
% ------------------------------------------------------------------------------------------------
