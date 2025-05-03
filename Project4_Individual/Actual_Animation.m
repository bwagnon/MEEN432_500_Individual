        %% Animates the Simulated Path of the Car on the Track %%

% Initialize animated line for path
path = animatedline('Color', 'b', 'LineWidth', 1);

% Imports the X and Y Coordinates from Simulink Model
X = out.X.Data;
Y = out.Y.Data;

% Animation loop
for i = 1:length(X)
    
    % Get current angle on track
    theta = out.psi.Data(i);

    % Rotation matrix
    R_M = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    Rotated_XY = R_M * [car_X; car_Y];

    % Update vehicle position
    Vertices = [Rotated_XY(1,:) + X(i); Rotated_XY(2,:) + Y(i)]';

    % Update path
    addpoints(path, X(i), Y(i));
    drawnow
    pause(0.0001)

end

