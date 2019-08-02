function [sts, data]=pspm_get_emg(import)
% SCR_GET_EMG is a common function for importing EMG data
%
% FORMAT:
%   [sts, data]=pspm_get_emg(import)
%   with import.data: column vector of waveform data
%        import.sr: sample rate
%  
%__________________________________________________________________________
% PsPM 3.0
% (C) 2009-2014 Tobias Moser (University of Zurich)

% $Id: pspm_get_emg.m 377 2016-10-31 15:57:10Z tmoser $
% $Rev: 377 $


global settings;
if isempty(settings), pspm_init; end;

% initialise status
% -------------------------------------------------------------------------
sts = -1;

% assign data
% -------------------------------------------------------------------------
data.data = import.data(:);

% add header
% -------------------------------------------------------------------------
data.header.chantype = 'emg';
data.header.units = import.units;
data.header.sr = import.sr;

% check status
sts = 1;

return;