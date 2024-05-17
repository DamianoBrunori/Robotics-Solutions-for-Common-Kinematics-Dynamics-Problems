% REMARK:
% In the following examples, the time is used, but it can be easily
% modified by using/considering the space. In addition, a fixed timestep is
% used (it could be the case in which we need to use a 'variable' timestep
% in order to accomplish a mandatory passage associated with specific tie
% instants)
% --> In questo esempio viene utilizzato il tempo (ma si puo'
% tranquillamente modificare con lo spazio) ed inoltre viene considerato un timestep scelto da me
% (potrebbe succedere che abbia un passaggio obbligatorio per determinati punti in determinati istanti,
% avendo dunque un timestep variabile).

syms tau real

% Positions, velocity and acceleration equations expressed w.r.t. 'tau' (to be modified at wish):
eqn_pos = ; 
eqn_vel = ;
eqn_acc = ;

% Final time instant:
T = ;

joints_number = ;
% Sampling time (if you want a more precise chart, then you need to choose a smaller timestep):
timestep = ;
initial_instant = ;

time_instants = initial_instant:timestep:T;

% The following 3 vectors are made as follows:
%   - each row corresponds to a joint;
%   - each row's element is the joint value associated with the considered row.
positions = zeros(joints_number, length(time_instants));
velocities = zeros(joints_number, length(time_instants));
accelerations = zeros(joints_number, length(time_instants));

for joint=1:1:joints_number
    for t=0:timestep:T
        positions(joint, count) = subs(eqn_pos(joint), tau, t/T);
        velocities(joint, count) = subs(eqn_vel(joint), tau, t/T);
        accelerations(joint, count) = subs(eqn_acc(joint), tau, t/T);
        count = count + 1;
    end
    count = 1; 
end

% ------------------------------------------------------------------------------------------------
% POSITION Plot:
figure('Name', 'JOINTS TRAJECTORIES');
plot(time_instants, positions(1:joints_number, 1:length(positions)))
xlabel('Time');
% The unit measure along the Y axis obviously depends on your choice (usually deg):
ylabel('deg O rad');
% ------------------------------------------------------------------------------------------------

% ------------------------------------------------------------------------------------------------
% VELOCITY Plot: 
%figure('Name', 'JOINTS VELOCITIES');
%plot(time_instants, velocities(1:joints_number, 1:length(velocities)))
%xlabel('Time');  
% The unit measure along the Y axis obviously depends on your choice (usually deg):
%ylabel('deg/s O rad/s');
% ------------------------------------------------------------------------------------------------

% ------------------------------------------------------------------------------------------------
% ACCELERATION Plot:
%figure('Name', 'JOINTS ACCELERATIONS');
%plot(time_instants, accelerations(1:joints_number, 1:length(accelerations)))
%xlabel('Time');  
% % The unit measure along the Y axis obviously depends on your choice (usually deg):
%ylabel('deg/s^2 O rad/s^2');
% ------------------------------------------------------------------------------------------------

grid on
