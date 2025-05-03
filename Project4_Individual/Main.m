
simTime = 3600;           % Simulation Time [sec]

run init_Car.m
run init_Track.m

model = "P4_Wk3";

set_param(model, 'Solver', 'ode4')
set_param(model, 'FixedStep', '1')
    
out = sim(model);

run Actual_Animation.m