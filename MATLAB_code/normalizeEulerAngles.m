function normalized_angles = normalizeEulerAngles(euler_angles)
    % Normalize Euler angles so that the starting point is zero.
    % The function also handles the wrap-around at 360 degrees.
    %
    % Input:
    % euler_angles - Nx3 matrix of Euler angles (yaw, pitch, roll)
    %
    % Output:
    % normalized_angles - Nx3 matrix of normalized Euler angles

    % Ensure euler_angles is a matrix with 3 columns
    if size(euler_angles, 2) ~= 3
        error('Input must be an Nx3 matrix of Euler angles.');
    end

    % Initialize the output matrix
    normalized_angles = zeros(size(euler_angles));

    % Normalize each component (yaw, pitch, roll)
    for i = 1:3
        % Subtract the starting value to make the first element zero
        base_value = euler_angles(1, i);
        angles = euler_angles(:, i) - base_value;

        % Handle wrap-around at 360 degrees
        for j = 2:length(angles)
            if angles(j) - angles(j-1) > 180
                angles(j:end) = angles(j:end) - 360;
            elseif angles(j-1) - angles(j) > 180
                angles(j:end) = angles(j:end) + 360;
            end
        end

        % Store the normalized angles
        normalized_angles(:, i) = angles;
    end
end