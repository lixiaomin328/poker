function [sts, out] = pspm_convert_au2mm(varargin)
% SCR_CONVERT_AU2MM converts arbitrary unit values to milimeter values. It
% works on a PsPM file and is able to replace a channel or add the data as
% a new channel.
%
% FORMAT: 
%   [sts, out] = pspm_convert_au2mm(fn, chan, distance, options)
%   [sts, out] = pspm_convert_au2mm(data, distance, record_method, options)
%
% ARGUMENTS: 
%           fn:                 filename which contains the channels to be
%                               converted
%           data:               a one-dimensional vector which contains the
%                               data to be converted
%           chan:               channel id of the channel to be coverted.
%                               Expected to be numeric. The channel should
%                               contain diameter values recoreded with an
%                               Eyelink system in 'ellipse' mode.
%           distance:           distance between camera and eyes in mm
%           record_method:      either 'area' or 'diameter', tells the function
%                               what the format of the recorded data is
%                               only required if data is a numeric vector
%                               unless options.multiplicator is defined.
%           options:            a struct of optional settings
%               multiplicator:  the multiplicator in the linear conversion
%               reference_distance: distance at which the multiplicator value
%                                   was obtained. The values will be 
%                                   proportionally translated to this distance
%                                   before applying the conversion function.
%               
%               => If multiplicator and offset are not set default values
%               are taken for a screen distance of 0.7 meters.
%
%               channel_action: tell the function whether to replace the
%                               converted channel or add the converted
%                               channel.
%               
%__________________________________________________________________________
% PsPM 3.1
% (C) 2016 Tobias Moser (University of Zurich)

% $Id: pspm_convert_au2mm.m 540 2018-04-06 09:11:35Z tmoser $
% $Rev: 540 $

% initialise
% -------------------------------------------------------------------------
global settings;
if isempty(settings), pspm_init; end
sts = -1;
out = struct();


%% load alternating inputs
if nargin < 1 
    warning('ID:invalid_input', 'No arguments given. Don''t know what to do.');
    return;
else
    if ischar(varargin{1})
        fn = varargin{1};
        mode = 'file';
        data  = -1;
        if nargin < 2
            warning('ID:invalid_input', ['Channel to be converted not ', ...
                'given. Don''t know what to do.']);
            return;
        elseif nargin < 3
            warning('ID:invalid_input','''distance'' is required.');
            return;
        else
            distance = varargin{3};
            chan = varargin{2};
            record_method = '';
            opt_idx = 4;
        end
        
    elseif isnumeric(varargin{1})
        mode = 'data';
        data = varargin{1};
        if nargin < 2
            warning('ID:invalid_input','''distance'' is required.');
            return;
        elseif nargin < 3
            warning('ID:invalid_input',['''record_method'' or ', ...
                '''options.m'' is required.']);
            return;
        else
            distance = varargin{2};
            fn = '';
            chan = -1;
            if isstruct(varargin{3})
                opt_idx = 3;
                record_method = '';
            else
                opt_idx = 4;
                record_method = varargin{3};
            end
        end
        
    end
    
    if nargin >= opt_idx
        options = varargin{opt_idx};
    end
    
end


%% set default values
if ~exist('options', 'var')
    options = struct();
elseif ~isstruct(options)
    warning('ID:invalid_input', 'options is not a struct.'); return;
end

% check if everything is needed for conversion
if strcmpi(mode, 'data') && strcmpi(record_method, '') && ...
        (~isstruct(options) || ~isfield(options, 'multiplicator'))
    warning('ID:invalid_input', ['If only a numeric data vector ', ...
        'is provided, either ''record_method'' or ', ...
        'options.multiplicator have to be specified.']); 
    return;
end

if ~isfield(options, 'channel_action')
    options.channel_action = 'add';
end
    
%% check values
if ~ischar(fn)
    warning('ID:invalid_input', 'fn is not a char.'); 
    return;
elseif ~isnumeric(data)
    warning('ID:invalid_input', 'data is not numeric.'); 
    return;
elseif ~isnumeric(distance)
    warning('ID:invalid_input', 'distance is not numeric.'); 
    return;
elseif ~isnumeric(chan) && ~ischar(chan)
    warning('ID:invalid_input', 'chan must be numeric or a string.'); 
    return;
elseif ~isempty(record_method) && ...
        ~any(strcmpi(record_method, {'area', 'diameter'}))
    warning('ID:invalid_input', ['''record_method'' should be ''area'' ', ...
        'or ''diameter''']);
    return;
elseif ~any(strcmpi(options.channel_action, {'add', 'replace'}))
    warning('ID:invalid_input', ['options.channel_action must be either ', ...
        '''add'' or ''replace''.']); 
    return;
end

%% try to load data
switch mode
    case 'file'
        [f_sts, infos, data] = pspm_load_data(fn, chan);

        if f_sts ~= 1
            warning('ID:invalid_input', 'Error while load data.');
            return;
        end
        d = data{1}.data;
        % set multiplicator field according to 
        % data units
        conv_field = regexprep(data{1}.header.units, '(.*) units', '$1');
    case 'data'
        d = data;
        conv_field = record_method;
end

%% set conversion values
% load default conversion values
if ~isfield(options, 'multiplicator') || ...
    ~isfield(options, 'reference_distance')

    % load conversion values
    % from file and as backup use hardcoded values
    if exist('pspm_convert.mat', 'file')
        convert = load('pspm_convert.mat');
    else
        % use default values
        convert = struct('au2mm', ...
            struct(...
            'area', struct('multiplicator', 0.12652, ...
                'reference_distance', 700), ...
            'diameter', struct('multiplicator', 0.00087743, ...
                'reference_distance', 700)) ...
        );
    end

    if any(strcmp(conv_field, fieldnames(convert.au2mm)))
        % get conversion struct
        conv_struct = subsref(convert.au2mm, struct('type', '.', ...
            'subs', conv_field));

        % set values
        m = conv_struct.multiplicator;
        ref_dist = conv_struct.reference_distance;

        if strcmpi(conv_field, 'area')
            d = sqrt(d);
        end
    else
        warning('ID:invalid_input', 'Cannot load default multiplicator value.');
        return;
    end
end

% set to option if is set and numeric
if isfield(options, 'reference_distance')
    if ~isnumeric(options.reference_distance)
        warning('ID:invalid_input', ...
            'options.reference_distance must be numeric.');
        return;
    else
        ref_dist = options.reference_distance;
    end
end

% set to according option if set and numeric
if isfield(options, 'multiplicator')
    if ~isnumeric(options.multiplicator)
        warning('ID:invalid_input', 'options.multiplicator must be numeric.');
        return;
    else
        m = options.multiplicator;
    end
end

%% convert
d = m*(d*distance/ref_dist);

%% create output
switch mode
    case 'file'
        data{1}.data = d;
        data{1}.header.units = 'mm';
        [f_sts, f_info] = pspm_write_channel(fn, data{1},...
            options.channel_action);
        sts = f_sts;
        out.chan = f_info.channel;
        out.fn = fn;
    case 'data'
        out = d;
end

sts = 1;
