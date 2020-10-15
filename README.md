# Active-Debris-Removal
Master Project on Active Derbis Removal - The Uninvited Group


DECAY :
   - Decay_Optimization.m : calculate the optimal foam ball radius to deorbit the given debris in 25 years using the DecayTime function.*

ASCENT PHASE :
   - GravityTurn3D.m : Integrates motion equations (in 3D and coded into Steer.m, Hopper_NoTurn.m, Orbiter3D.m, Prograde_Burn.m functions depending on fligth status) using ODE45        function. 

ASCENT PHASE (modified) : 
   - The modified version of ASCENT PHASE with calculation of energy. 

DELTA V & TIME :
   - dVextimation.m : this function will give you out all the possible combination of dv needed to reach the targets specified in the structure 'target'.    
   - deltaV.m : calculates the deltaV needed to go from one orbit to one other.
   - timextimation.m : takes the structure 'target' and calculates a time estimation of the whole manouvering time.



exatmo.m models the exponential atmosphere (IT IS REQUIRED TO COPY THIS FILE IN THE FOLDERS AS THE LINK HAS NOT BEEN MADE)


Thanks to the earth plot from Ryan Gray [1] adapted for the purpose of this project.

[1] : Ryan Gray (2020). 3D Earth Example (https://www.mathworks.com/matlabcentral/fileexchange/13823-3d-earth-example), MATLAB Central File Exchange. Retrieved October 14, 2020.
