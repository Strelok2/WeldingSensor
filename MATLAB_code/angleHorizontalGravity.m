function angles_horizontal = angleHorizontalGravity(g_x, g_y, g_z)
    % Ensure input vectors are of the same length
    if length(g_x) ~= length(g_y) || length(g_y) ~= length(g_z)
        error('Input vectors must be of the same length.');
    end
    
    % Initialize the output array
    n = length(g_x);
    angles_horizontal = zeros(n, 1);
    
    % Calculate angles for each time point
    for i = 1:n
        % Calculate magnitude of gravity vector
        g = sqrt(g_x(i)^2 + g_y(i)^2 + g_z(i)^2);
        
        % Normalize gravity vector
        if g ~= 0
            g_hat_z = g_z(i) / g;
        else
            error('Gravity vector magnitude is zero at index %d. Check input data.', i);
        end
        
        % Calculate angle between gravity vector and horizontal plane
        angles_horizontal(i) = acosd(g_hat_z); % acosd gives angle in degrees
    end
end