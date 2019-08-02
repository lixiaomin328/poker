function [sts, data]=pspm_get_sound(import)
% SCR_GET_SOUND is a common function for importing sound data
%
% FORMAT:
%   [sts, data]=pspm_get_sound(import)
%   with import.data: column vector of waveform data
%        import.sr: sample rate
%  
%__________________________________________________________________________
% PsPM 3.0
% (C) 2015 Tobias Moser (University of Zurich)

% $Id: pspm_get_sound.m 465 2017-08-11 06:29:25Z tmoser $
% $Rev: 465 $

global settings;
if isempty(settings), pspm_init; end

% initialise status
sts = -1;

% assign respiratory data
data.data = import.data(:);

% add header
data.header.chantype = 'snd';
data.header.units = import.units;
data.header.sr = import.sr;

% check status
sts = 1;
