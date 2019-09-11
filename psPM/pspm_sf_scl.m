function scl = pspm_sf_scl(scr, sr, options)
% SCR_SF_SCL returns the mean skin conductance level for an epoch

% FORMAT:
% auc = pspm_sf_scl(scr, sr)
%
% REFERENCE: 
%
%__________________________________________________________________________
% PsPM 3.0
% (C) 2008-2015 Dominik R Bach (Wellcome Trust Centre for Neuroimaging)

% $Id: pspm_sf_scl.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

% v01 2.10.2009 drb

% initialise
% -------------------------------------------------------------------------
global settings;
if isempty(settings), pspm_init; end;
% -------------------------------------------------------------------------

% check input arguments
if nargin < 1
    warning('No data specified'); return;
end;

scl = mean(scr);

return;

