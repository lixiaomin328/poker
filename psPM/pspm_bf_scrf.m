function [bs, x] = pspm_bf_scrf(varargin)
% SCR_infbs constructs an informed basis set with a biexponentially 
% modified gaussian function and derivatives to time and dispersion
%
% FORMAT: [bs, x] = SCR_BF_SCRF(TD, D) 
%     OR: [bs, x] = SCR_BF_SCRF([TD, D]) 
% with td = time resolution in s and d:number of derivatives (default 0)
%
% REFERENCE
% Bach DR, Flandin G, Friston KJ, Dolan RJ (2010). Modelling event-related 
% skin conductance responses. International Journal of Psychophysiology,
% 75, 349-356.
%________________________________________________________________________
% PsPM 3.0
% (C) 2008-2015 Dominik R Bach (Wellcome Trust Centre for Neuroimaging)

% $Id: pspm_bf_scrf.m 450 2017-07-03 15:17:02Z tmoser $   
% $Rev: 450 $

% initialise
global settings
if isempty(settings), pspm_init; end;

% check input arguments
if nargin==0
    errmsg='No sampling interval stated'; warning('ID:invalid_input', errmsg); return;
end;

td = varargin{1}(1);
if numel(varargin{1}) == 1 && nargin == 1
    d = 0;
elseif numel(varargin{1}) == 2
    d = varargin{1}(2);
else
    d = varargin{2}(1);
end;
    
if td > 90
    warning('ID:invalid_input', 'Time resolution is larger than duration of the function.'); return;
elseif td == 0
        warning('ID:invalid_input', 'Time resolution must be larger than 0.'); return;
end;

if (d<0)||(d>2), d=0; end;

% get parameters and basis function
[bs(:, 1), p, x] = pspm_bf_scrf_f(td);
if d>0
    bs(:, 2) = [0; diff(bs(:,1))]; 
    bs(:, 2) = bs(:,2)/sum(abs(bs(:,2)));
end;
if d>1 
    p(2) = 1.8 * p(2); 
    bs(:, 3) = bs(:, 1) - pspm_bf_scrf_f(td, p); 
    bs(:, 3) = bs(:, 3)/sum(abs(bs(:, 3)));
end;

% orthogonalize
bs=spm_orth(bs);
% normalise
bs = bs./repmat((max(bs) - min(bs)), size(bs, 1), 1);
