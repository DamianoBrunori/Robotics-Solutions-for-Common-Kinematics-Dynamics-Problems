% To be defined here the parameters for which the 'R_to_check' has to be a rotation matrix:
syms a real

% To be defined here the matrix that has to be checked (It is a rotation matrix or not? If yes, for which values of its parameters?):
R_to_check = [ -0.5     -a      0;
               0        0       -1;
               a        -0.5    0];

% Check if 'R_to_check' is an orthonormal matrix (i.e., if it is a square matrix and its inverse is equal to its transpose):

% Square checking:
if size(R_to_check,1) ~= size(R_to_check,2)
    fprintf('Matrix is NOT a SQUARE matrix');
    return;
end

% Checking right values for orthogonality (to be modified here the symboic value at wish):
orthogonality_sol = solve(inv(R_to_check) == R_to_check', a);
if isempty(orthogonality_sol)
    fprintf('No possible values found to obtain an orthogonal matrix');
    return;
end

% Checking right values for determinant (it has to be equal to 1):
determinant_sol = solve(det(R_to_check) == 1, a);
if isempty(determinant_sol)
    fprintf('No possible values found to obtain a determinant equal to 1');
    return;
end

% To be checked which values occur both in 'determinant_sol' and in
% 'orthogonality_sol'; only take these values (or one of them that
% satisfies both the parts) and use it/them for the next passages (you
% should possibly modify the index of 'determinant_sol(i)'):

% To be modified the symbolic variable and the index extracted from 'determinant_sol':
R_rotation_evaluated = eval(subs(R_to_check, a, determinant_sol(2)));

sin_theta = 1/2 * ( sqrt( (R_rotation_evaluated(1,2) - R_rotation_evaluated(2,1))^2 + (R_rotation_evaluated(1,3) - R_rotation_evaluated(3,1))^2 + (R_rotation_evaluated(2,3) - R_rotation_evaluated(3,2))^2));

if sin_theta == 0
    fprintf('Sin_tehta is equal to 0 and then you cannot use the formulas here implemented (see block7, slide 19)');
    return;
end

cos_theta = 1/2 * (R_rotation_evaluated(1,1) + R_rotation_evaluated(2,2) + R_rotation_evaluated(3,3) - 1);

theta = atan2(sin_theta, cos_theta); % --> 'theta' computed for the chosen solution
theta_grad = radtodeg(theta)

r = 1/(2*sin(theta)) * [ R_rotation_evaluated(3,2) - R_rotation_evaluated(2,3); % --> 'r' computed for the chosen solution
                     R_rotation_evaluated(1,3) - R_rotation_evaluated(3,1);
                     R_rotation_evaluated(2,1) - R_rotation_evaluated(1,2)]


