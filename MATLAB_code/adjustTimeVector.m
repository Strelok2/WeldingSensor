function adjusted_vector = adjustTimeVector(time_vector)
    % Adjusts the time vector by linearly extrapolating the first value if the
    % difference between the first two elements is larger than 1.
    %
    % Input:
    % time_vector - A row or column vector of time values
    %
    % Output:
    % adjusted_vector - The adjusted time vector with the first value
    %                   linearly extrapolated if needed

    % Ensure the input is a vector
    if ~isvector(time_vector)
        error('Input must be a vector.');
    end

    % Ensure the vector has at least two elements
    if length(time_vector) < 2
        error('Input vector must have at least two elements.');
    end

    % Copy the original vector
    adjusted_vector = time_vector;

    % Check if the difference between the first two elements is larger than 1
    if abs(time_vector(2) - time_vector(1)) > 100
        % Use the next few values to linearly extrapolate the first value
        % We will use the next two values for simplicity
        x = [2, 3];
        y = time_vector(2:3);
        
        % Perform linear extrapolation
        p = polyfit(x, y, 1); % Linear fit
        adjusted_vector(1) = polyval(p, 1);
    end
end