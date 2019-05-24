function [sts, data]=pspm_get_pupil(import)
% SCR_GET_PUPIL is a common function for importing pupil data
%
% FORMAT:
%   [sts, data]=pspm_get_pupil(import)
%   with import.data: column vector of waveform data
%        import.sr: sample rate
%  
%__________________________________________________________________________
% PsPM 3.0
% (C) 2008-2015 Dominik R Bach (Wellcome Trust Centre for Neuroimaging)

% $Id: pspm_get_pupil.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

global settings;
if isempty(settings), pspm_init; end;

% initialise status
sts = -1;

% assign respiratory data
data.data = import.data(:);

% add header
data.header.chantype = 'pupil';
data.header.units = import.units;
data.header.sr = import.sr;

% check status
sts = 1;

return;