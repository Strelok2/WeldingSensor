function interpolated_vector = interpolateNaNs(vector)
    % Interpolates NaN values in the input vector using linear interpolation.
    %
    % Input:
    % vector - A row or column vector containing numerical values and NaNs
    %
    % Output:
    % interpolated_vector - A vector with NaNs replaced by interpolated values

    % Ensure the input is a vector
    if ~isvector(vector)
        error('Input must be a vector.');
    end

    % Find indices of NaNs
    nan_indices = isnan(vector);

    % Find indices of non-NaN values
    non_nan_indices = find(~nan_indices);

    % Perform linear interpolation
    interpolated_vector = vector; % Copy the original vector
    interpolated_vector(nan_indices) = interp1(non_nan_indices, vector(non_nan_indices), find(nan_indices), 'linear');

    % If there are NaNs at the beginning or end, they remain NaN
    % You might want to extrapolate these values based on your specific requirements
end