function [sts, out] = pspm_simple_qa(data, sr, options)
% This function applies simple SCR quality assessment rulesets
% Rule 1:       Microsiemens values must be within range (0.05 to 60)
% Rule 2:       Absolute slope of value change must be less than 10
%               microsiemens per second
%
% FORMAT: 
%   [sts, out] = pspm_simple_qa(data, sr, options)
%
% ARGUMENTS:
%       data:                   A numeric vector. Data should be in
%                               microsiemens.
%       sr:                     Samplerate of the data. This is needed to
%                               determine the slopes unit.
%       options:                A struct with algorithm specific settings.
%           min:                Minimum value in microsiemens (default: 0.05).
%           max:                Maximum value in microsiemens (default: 60).
%           slope:              Maximum slope in microsiemens per sec (default: 10).
%__________________________________________________________________________
% PsPM 3.2
% (C) 2009-2017 Tobias Moser (University of Zurich)

% $Id: pspm_pp.m 450 2017-07-03 15:17:02Z tmoser $   
% $Rev: 450 $

% initialise
% -------------------------------------------------------------------------
global settings;
if isempty(settings), pspm_init; end
out = [];
sts = -1;


% set default values
if ~exist('options', 'var')
    options = struct();
end

if ~isfield(options, 'min')
    options.min = 0.05;
end

if ~isfield(options, 'max')
    options.max = 60;
end

if ~isfield(options, 'slope')
    options.slope = 10;
end

% sanity checks
if ~isnumeric(data)
    warning('ID:invalid_input', 'Argument ''data'' must be numeric.'); return;
elseif ~isnumeric(sr)
    warning('ID:invalid_input', 'Argument ''sr'' must be numeric.'); return;
elseif ~any(size(data) > 1)
    warning('ID:invalid_input', 'Argument ''data'' should contain > 1 data points.'); return;
elseif ~isnumeric(options.min)
    warning('ID:invalid_input', 'Argument ''options.min'' must be numeric.'); return;
elseif ~isnumeric(options.max)
    warning('ID:invalid_input', 'Argument ''options.max'' must be numeric.'); return;
elseif ~isnumeric(options.slope)
    warning('ID:invalid_input', 'Argument ''options.slope'' must be numeric.'); return;
end

% create filters
d = NaN(size(data));
range_filter = data < options.max & data > options.min;
slope_filter = [1; (abs(diff(data)*sr) < options.slope)];

% combine filters
filt = range_filter & slope_filter;
d(filt) = data(filt);

out = d;
sts = 1;

end