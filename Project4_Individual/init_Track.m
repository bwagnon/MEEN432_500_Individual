%%   ---------   Track Initialization for Project 4   ---------   %%
%%%   ------------------   TD := TrackData   -----------------   %%%


% Define Track Parameters
TD.R = 200;               % Radius of track curves         [m]
TD.LC = pi*TD.R;          % Length of track curves         [m] 
TD.LS = 900;              % Length of track straightaways  [m]
TD.W = 15;                % Track Width                    [m]
TD.HW = TD.W / 2;         % Half of Track Width            [m]    

TD.L_tot = 2*TD.LS + 2*TD.LC;      % Total Track Length    [m]
R = TD.R;

% Theoretical Angles for car to follow around track
Theoretical_Angles.theta1 = linspace(0, 0, 100);
Theoretical_Angles.theta2 = linspace(0, pi, 100);
Theoretical_Angles.theta3 = linspace(pi, pi, 100);
Theoretical_Angles.theta4 = linspace(pi, 2*pi, 100);
TD.theoretical_angle = [ Theoretical_Angles.theta1, Theoretical_Angles.theta2,...
                         Theoretical_Angles.theta3, Theoretical_Angles.theta4 ];


%%% --------------------- CREATE TRACK CENTERLINE --------------------- %%%

% First straight section
TD.x_straight1 = linspace(0, TD.LS, 100);            % [0, 900]        {100}
TD.y_straight1 = zeros(size(TD.x_straight1));        % [0, 0]          {100}

% First curve (semi-circle)
TD.theta1 = linspace(-pi/2, pi/2, 100);              % [-π/2, π/2]     {100} 
TD.x_curve1 = TD.LS + R*cos(TD.theta1);              % [900:900+R:900] {100}
TD.y_curve1 = R + R*sin(TD.theta1);                  % [0, 2R]         {100}

% Second straight section
TD.x_straight2 = linspace(TD.LS, 0, 100);            % [900, 0]        {100}
TD.y_straight2 = (2*R)*ones(size(TD.x_straight2));   % [2R, 2R]        {100}

% Second curve (semi-circle)
TD.theta2 = linspace(pi/2, 3*pi/2, 100);             % [π/2, 3π/2]     {100}
TD.x_curve2 = R*cos(TD.theta2);                      % [0:-R:0]        {100}
TD.y_curve2 = R + R*sin(TD.theta2);                  % [2R, 0]         {100}

% Combine arrays into X and Y array
TD.X_track = [TD.x_straight1, TD.x_curve1, TD.x_straight2, TD.x_curve2];
TD.Y_track = [TD.y_straight1, TD.y_curve1, TD.y_straight2, TD.y_curve2];


%%% ------------- COMPUTE INNER AND OUTER TRACK BOUNDARIES ------------ %%%

% Inner Tracklines
TD.x_straight_inner1 = linspace(0, TD.LS, 100);
TD.y_straight_inner1 = zeros(size(TD.x_straight1)) + TD.HW;

TD.x_curve_inner1 = TD.LS + (R - TD.HW) * cos(TD.theta1);
TD.y_curve_inner1 = R + (R - TD.HW) * sin(TD.theta1);

TD.x_straight_inner2 = linspace(TD.LS, 0, 100);
TD.y_straight_inner2 = (2*R - TD.HW) * ones(size(TD.x_straight2));

TD.x_curve_inner2 = (R - TD.HW) * cos(TD.theta2);
TD.y_curve_inner2 = R + (R - TD.HW) * sin(TD.theta2);

TD.X_inner = [TD.x_straight_inner1, TD.x_curve_inner1, TD.x_straight_inner2, TD.x_curve_inner2];
TD.Y_inner = [TD.y_straight_inner1, TD.y_curve_inner1, TD.y_straight_inner2, TD.y_curve_inner2];


% Outer Tracklines
TD.x_straight_outer1 = linspace(0, TD.LS, 100);
TD.y_straight_outer1 = zeros(size(TD.x_straight1)) - TD.HW;

TD.x_curve_outer1 = TD.LS + (R + TD.HW) * cos(TD.theta1);
TD.y_curve_outer1 = R + (R + TD.HW) * sin(TD.theta1);

TD.x_straight_outer2 = linspace(TD.LS, 0, 100);
TD.y_straight_outer2 = (2*R + TD.HW) * ones(size(TD.x_straight2));

TD.x_curve_outer2 = (R + TD.HW) * cos(TD.theta2);
TD.y_curve_outer2 = R + (R + TD.HW) * sin(TD.theta2);

TD.X_outer = [TD.x_straight_outer1, TD.x_curve_outer1, TD.x_straight_outer2, TD.x_curve_outer2];
TD.Y_outer = [TD.y_straight_outer1, TD.y_curve_outer1, TD.y_straight_outer2, TD.y_curve_outer2];


%%% -------------------------- PLOT THE TRACK ------------------------- %%%

hold on
plot(TD.X_track, TD.Y_track, 'k--');
plot(TD.X_inner, TD.Y_inner, 'k', 'LineWidth', 0.8);  % Inner boundary
plot(TD.X_outer, TD.Y_outer, 'k', 'LineWidth', 0.8);  % Outer boundary
axis equal
title('Race Track');
xlabel('X [m]');
ylabel('Y [m]');
axis([-300 1200 -100 500]);  % Fixes Aspect Ratio