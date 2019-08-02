function [sts, data]=pspm_get_pupil_l(import)
% SCR_GET_PUPIL_L is a common function for importing eyelink data
% (pupil_l data)
%
% FORMAT:
%   [sts, data]=pspm_get_pupil_l(import)
%   with import.data: column vector of waveform data
%        import.sr: sample rate
%  
%__________________________________________________________________________
% PsPM 3.1
% (C) 2015 Tobias Moser (University of Zurich)

% $Id: pspm_get_pupil_l.m 479 2017-09-22 09:39:43Z tmoser $
% $Rev: 479 $

global settings;
if isempty(settings), pspm_init; end

% initialise status
sts = -1;

% assign pupil data
data.data = import.data(:);

% add header
data.header.chantype = 'pupil_l';
data.header.units = import.units;
data.header.sr = import.sr;

% check status
sts = 1;
