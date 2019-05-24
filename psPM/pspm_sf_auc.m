function auc = pspm_sf_auc(scr, sr, options)
% SCR_SF_AUC returns the integral/area under the curve of an SCR time series

% FORMAT:
% auc = pspm_sf_auc(scr)
%
% REFERENCE: 
% Bach DR, Friston KJ, Dolan RJ (2010). Analytic measures for the
% quantification of arousal from spontanaeous skin conductance
% fluctuations. International Journal of Psychophysiology, 76, 52-55.
%__________________________________________________________________________
% PsPM 3.0
% (C) 2008-2015 Dominik R Bach (Wellcome Trust Centre for Neuroimaging)
%
% $Id: pspm_sf_auc.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $
%
% v02 30.7.2009 drb changed sum to mean
% v01 17.6.2009 drb
%
% initialise
% -------------------------------------------------------------------------
global settings;
if isempty(settings), pspm_init; end;
% -------------------------------------------------------------------------


% check input arguments
if nargin < 1
    warning('No data specified'); return;
end;

scr = scr - min(scr);
auc = mean(scr);

