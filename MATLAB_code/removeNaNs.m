function [varargout] = removeNaNs(varargin)
    % Removes entries from multiple vectors if there's a NaN in any of them.
    %
    % Input:
    % varargin - A variable number of input vectors
    %
    % Output:
    % varargout - The same number of output vectors with NaN entries removed

    % Ensure there is at least one input vector
    if nargin < 1
        error('At least one input vector is required.');
    end

    % Check that all inputs are vectors and of the same length
    n = length(varargin{1});
    for i = 1:nargin
        if ~isvector(varargin{i})
            error('All inputs must be vectors.');
        end
        if length(varargin{i}) ~= n
            error('All input vectors must have the same length.');
        end
    end

    % Find indices where any of the vectors have NaNs
    nan_indices = false(n, 1);
    for i = 1:nargin
        nan_indices = nan_indices | isnan(varargin{i});
    end

    % Remove NaN entries from each vector
    varargout = cell(1, nargin);
    for i = 1:nargin
        varargout{i} = varargin{i}(~nan_indices);
    end
end