%% Animates the Car on the Track %%

% Initialize vehicle patch
car_length = 40;
car_width = 20;
car_X = car_length/2 * [-1 1 1 -1];
car_Y = car_width/2 * [-1 -1 1 1];
car = patch(car_X, car_Y, 'r');

% Initialize animated line for path
route = animatedline('Color', 'b', 'LineWidth', 2);

% Imports the X and Y Coordinates from Simulink Model
X = out.X.data;
Y = out.Y.data;

% Animation loop
for i = 1:length(X)

    % Starts the car in the proper angle
    if Y(i) == 0
        theta = 0;

    % Finds the angle the car is facing when on rest of the track
    else
        dx = X(i) - X(i-1);
        dy = Y(i) - Y(i-1);
        theta = atan2(dy, dx); % Angle of motion
    end

    % Rotation matrix to rotate car
    R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    Rotated_XY = R * [car_X; car_Y];

    % Update vehicle position
    car.Vertices = [Rotated_XY(1,:) + X(i); Rotated_XY(2,:) + Y(i)]';

    % Update path
    addpoints(route, X(i), Y(i));
    drawnow
    pause(0.0075)

end
