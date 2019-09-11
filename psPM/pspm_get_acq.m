function [sts, import, sourceinfo] = pspm_get_acq(datafile, import)
% pspm_get_acq is the main function for import of biopac/acknowledge files
% FORMAT: [sts, import, sourceinfo] = pspm_get_acq(datafile, import);
%
% this function uses the conversion routine acqread.m version 2.0 (2007-08-21)
% by Sebastien Authier and Vincent Finnerty at the University of Montreal
% which supports all files created with Windows/PC versions of
% AcqKnowledge (3.9.0 or below), BSL (3.7.0 or below), and BSL PRO
% (3.7.0 or below).
%__________________________________________________________________________
% PsPM 3.0
% (C) 2011-2014 Dominik R Bach (Wellcome Trust Centre for Neuroimaging)

% $Id: pspm_get_acq.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

% initialise
% -------------------------------------------------------------------------
global settings;
if isempty(settings), pspm_init; end;
sourceinfo = []; sts = -1;
addpath([settings.path, 'Import', filesep, 'acq']); 


% load data but suppress output
% -------------------------------------------------------------------------
[T, header, inputdata] = evalc('acqread(datafile)');


% extract individual channels
% -------------------------------------------------------------------------
for k = 1:numel(import)
    % define channel number ---
    if import{k}.channel > 0
        chan = import{k}.channel;
    else
        chan = pspm_find_channel(header.szCommentText, import{k}.type);
        if chan < 1, return; end;
    end;
    
    if chan > numel(header.szCommentText), warning('ID:channel_not_contained_in_file', 'Channel %02.0f not contained in file %s.\n', chan, datafile); return; end;

    sourceinfo.chan{k, 1} = sprintf('Channel %02.0f: %s', chan, header.szCommentText{chan});
    
    % retrieve sample rate ---    
    % we might need to change this if different sample rates are used for
    % each channel
    if numel(header.dSampleTime) > 1
        warning('Unknown sample rate format Please contact the developers.'); return;
    elseif isfield(header, 'nVarSampleDivider') && ~isempty(header.nVarSampleDivider) && numel(header.nVarSampleDivider) >= chan
        % allows for channel-specific sample rates from version 3.7 upwards
        import{k}.sr = double(1000 * (1./header.dSampleTime) ./ header.nVarSampleDivider(chan)); % acqread returns the sample rate in milliseconds
    else
        import{k}.sr = double(1000 * 1./header.dSampleTime); % acqread returns the sampling time in milliseconds
    end;
    
    % get data ---
    % this returns the same y scaling as in the original matlab export
    % provided in acqKnowledge - note there is a corresponding field
    % dVoltOffset/dVoltScale but it is not entirely clear from the documentation
    % what this field contains (the description is Volts/division, so
    % probably this is for display purpose only)
    import{k}.data = (double(inputdata{chan}) - header.dAmplOffset(chan)) * header.dAmplScale(chan);
    
    if strcmpi(settings.chantypes(import{k}.typeno).data, 'events')
        import{k}.marker = 'continuous';
    end;
end;

% clear path and return
% -------------------------------------------------------------------------
rmpath([settings.path, 'Import', filesep, 'acq']); 
sts = 1;
return;



