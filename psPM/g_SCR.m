function [gx,dgdx,dgdPhi] = g_aSCR(Xt,Phi,ut,inG)
% Description
%__________________________________________________________________________
% PsPM 3.0
% (C) 2008-2015 Dominik R Bach (Wellcome Trust Centre for Neuroimaging)

% $Id: g_SCR.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

% initialise
% -------------------------------------------------------------------------
global settings;
if isempty(settings), pspm_init; end;

gx = Xt(1) + Xt(4) + Xt(7);

dgdx = zeros(size(Xt,1),1);
dgdx([1;4;7]) = 1;
dgdPhi = [];

if any(isnan(gx)|isinf(gx)), keyboard; end;
if any(isnan(dgdx)|isinf(dgdx)), keyboard; end;


