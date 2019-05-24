function newdatafile = pspm_pp(varargin)
% pspm_pp contains various preprocessing utilities for reducing noise in the
% data. 
%
% INPUT:
%   pspm_pp('median', datafile, n, channelnumber, options)
%   pspm_pp('butter', datafile, freq, channelnumber, options)
%   pspm_pp('simple_qa', datafile, qa, channelnumber, options)
%
% Currently implemented: 
%   'median':           medianfilter for SCR
%       n:              number of timepoints for median filter
%   'butter':           1st order butterworth low pass filter for SCR
%       freq:           cut off frequency (min 20 Hz)
%   'simple_qa':        Simple quality assessment for SCR
%       qa:             A struct with quality assessment settings
%           min:        Minimum value in microsiemens
%           max:        Maximum value in microsiemens
%           slope:      Maximum slope in microsiemens per second
%
%__________________________________________________________________________
% PsPM 3.0
% (C) 2009-2015 Dominik R Bach (Wellcome Trust Centre for Neuroimaging)

% $Id: pspm_pp.m 471 2017-08-28 13:28:09Z tmoser $   
% $Rev: 471 $

% initialise
% -------------------------------------------------------------------------
global settings;
if isempty(settings), pspm_init; end
newdatafile = [];

% check input arguments
% -------------------------------------------------------------------------
if nargin < 1
    warning('ID:invalid_input', 'No input arguments. Don''t know what to do.');
elseif nargin < 2
    warning('ID:invalid_input', 'No datafile.'); return;
elseif nargin < 3
        warning('ID:invalid_input', 'Missing filter specs.'); return;
else
    fn = varargin{2};
end

if nargin >=5 && isstruct(varargin{5}) && isfield(varargin{5}, 'overwrite')
    options = varargin{5};
else
    options.overwrite = 0;
end

% load data
% -------------------------------------------------------------------------
[sts, infos, data] = pspm_load_data(fn, 0);
if sts ~= 1, return, end

% determine channel number
% -------------------------------------------------------------------------
if nargin >= 4 && ~isempty(varargin{4}) && ...
        (~isequal(size(varargin{4}), [1,1]) || varargin{4} ~= 0)
    channum = varargin{4};
else
    for k = 1:numel(data)
        if strcmp(data{k}.header.chantype, 'scr')
            channum(k) = 1;
        end
    end
    channum = find(channum == 1);
end

% do the job
% -------------------------------------------------------------------------
switch varargin{1}
    case 'median'
        n = varargin{3};
        % user output
        fprintf('Preprocess: median filtering datafile %s ...', fn);
        for k = 1:numel(channum)
            data{k}.data = medfilt1(data{k}.data, n);
        end
        infos.pp = sprintf('median filter over %1.0f timepoints', n);
    case 'butter'
        freq = varargin{3};
        if freq < 20, warning('ID:invalid_freq', 'Cut off frequency must be at least 20 Hz'); return; end;
        % user output
        fprintf('Preprocess: butterworth filtering datafile %s ...', fn);
        for k = 1:numel(channum)
            filt.sr = data{channum(k)}.header.sr;
            filt.lpfreq = freq;
            filt.lporder = 1;
            filt.hpfreq = 'none';
            filt.hporder = 0;
            filt.down = 'none';
            filt.direction = 'bi';
            [sts, data{channum(k)}.data, data{channum(k)}.header.sr] = pspm_prepdata(data{channum(k)}.data, filt);
            if sts == -1, return; end
        end
        infos.pp = sprintf('butterworth 1st order low pass filter at cutoff frequency %2.2f Hz', freq);
    case 'simple_qa'
        qa = varargin{3};
        for k = 1:numel(channum)
            [sts, data{k}.data] = pspm_simple_qa(data{k}.data, data{k}.header.sr, qa);
        end
        infos.pp = sprintf('simple scr quality assessment');
    otherwise
        warning('ID:invalid_input', 'Unknown filter option ...');
        return;
end

[pth, fn, ext] = fileparts(fn);
newdatafile = fullfile(pth, ['m', fn, ext]);
infos.ppdate = date;
infos.ppfile = newdatafile;
clear savedata
savedata.data = data; savedata.infos = infos; 
savedata.options = options;
sts = pspm_load_data(newdatafile, savedata);
fprintf(' done\n');

return;

