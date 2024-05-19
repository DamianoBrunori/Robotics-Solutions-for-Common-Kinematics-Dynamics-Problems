# Robotics-Solutions-for-Common-Kinematics-Dynamics-Problems

A list of Matlab's files to solve some common Robotics' problems (a minimalist GUI is also provided in some cases).
These files were tested on **Matlab R2015a** version.

**Some of the files could need a few or several changes to be adapted to the desired case**. The ones that could need more changes are, for example, the files 'rotation_check.m', 'inverse_kinematics.m', 'polynomial_interpolation_sym_func.m',
'joints_trajectories_PLOT.m', 'trajectories_coefficients.m'. But some of them (e.g., 'DH_GUI.m') are provided also with a graphical interface in such a way to be as generic as possible to make them suitable for the majority of possible cases.
Some of the desired results (and also other additional results) sometimes are obtained directly in the Command Window and sometimes are stored separately (in
the latter case obviously it is needed to type the variable name related to the desired value(s) in the Command Window after running the proper file '.m').
**Some of the cases provided could throw an error if the specific case is not handled by the considered file '.m'.**

**These '.m' files simply contain a personal list of possible and specific robotics problems to be solved as an exercise, and the aim of this repository is just to make them available so that everyone can use them (or adapt them to their needings, depending on the specific use case).**

Possible usages:

1) in order to compute the matrix 'T' starting from the D-H (Denavit Hartenberg) and its related variables:
   
    - run the file 'DH_GUI.m';


2) in order to compute the elementary rotations (Roll, Pitch, Yaw angles):
    
    - run the file 'elementary_rotations.m'; 


3) in order to check if a matrix is effectively a rotation matrix:

	- run the file 'rotation_check.m'


4) in order to perform the kinematic inversion either with the Gradient or the Newton methods:

	- run the file 'inverse_kinematics.m'


5) in order to plan trajectories (coefficients computation + plotting) starting from the 'extended' form of the selected polynomials:

	- run the file 'polynomial_interpolation_sym_func.m'

   Also, in order to plot the position, velocity and acceleration of the single joints:
		
	- you could run the file 'joints_trajectories_PLOT.m'
	
   Furthermore, in order perform a simple coefficients computation:
		
	- you could run the file 'trajectories_coefficients.m'
	
   Finally, it is worth highlighting that the file 'splines_composition_plot' was used to implement in a more generic fashion what was already included 'polynomial_interpolation_sym_func.m'.
	

**FINAL REMARK:**
The most complete file (where it is possible to find both the coeffients computation and the plotting of position, velocity, acceleration for one and only one joint)
is the file 'polynomial_interpolation_sym_func.m'. For any issues with a robot/manipulator with more than one joint, if you want to get results for all the available and needed joints,
then it is sufficient replacing (time by time) the values of the symbolic variables related to 'q' with the values of the i-th 'q' of your interest. 
