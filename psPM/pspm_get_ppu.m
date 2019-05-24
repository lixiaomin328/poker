function [sts, data]=pspm_get_ppu(import)
% SCR_GET_PPU is a common function for importing PPU data
%
% FORMAT:
%   [sts, data]=pspm_get_ppu(import)
%   with import.data: column vector of waveform data
%        import.sr: sample rate
%  
%__________________________________________________________________________
% PsPM 3.0
% (C) 2015 Tobias Moser (University of Zurich)

% $Id: pspm_get_ppu.m 466 2017-08-11 06:46:36Z tmoser $
% $Rev: 466 $

global settings;
if isempty(settings), pspm_init; end

% initialise status
sts = -1;

% assign respiratory data
data.data = import.data(:);

% add header
data.header.chantype = 'ppu';
data.header.units = import.units;
data.header.sr = import.sr;

% check status
sts = 1;
