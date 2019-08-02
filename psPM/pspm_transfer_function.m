function scr=pspm_transfer_function(data, c, Rs, offset, recsys)
% SCR_TRANSFER_FUNCTION converts input data into SCR in microsiemens
% assuming a linear transfer from total conductance to measured data
%
% FORMAT
% scr=pspm_transfer_function(data, c, [Rs, offset, recsys])
% 
% c is the transfer constant. Depending on the recording setting
%   data = c * (measured total conductance in mcS)
% or
%   data = c * (measured total resistance in MOhm) = c / (total conductance in mcS)
%
% Rs, offset, recsys are optional argumens:
%
% Series resistors (Rs) are often used as current limiters in MRI and 
% will render the function non-linear. They can be taken into account 
% (in Ohm, default: Rs=0). 
% 
% Some systems have an offset (e.g. when using fiber optics in MRI, a minimum
% pulsrate), which can also be taken into account (default: offset=0).
% Offset must be stated in data units.
%
% There are two different recording settings which have an influence on the
% transfer function. Recsys defines in which setting the data (given in
% voltage) has been generated. Either the system is a 'conductance' based
% system (which is the default) or it is a 'resistance' based system. 
%__________________________________________________________________________
% PsPM 3.0
% (C) 2008-2015 Dominik R Bach (Wellcome Trust Centre for Neuroimaging)

% $Id: pspm_transfer_function.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

% initialise
% -------------------------------------------------------------------------
global settings;
if isempty(settings), pspm_init; end;
% -------------------------------------------------------------------------

% check input arguments
if nargin<1
    errmsg='No data given.'; warning(errmsg);
elseif nargin<2
    errmsg='No transfer constant given'; warning(errmsg);
elseif nargin<3
    Rs=0; offset=0;
elseif nargin<4
    offset=0;
elseif nargin < 5
    recsys = 'conductance';
end;

if ~any(strcmpi(recsys, {'conductance','resistance'}))
    warning('ID:invalid_input', ['Invalid recording system given. Use either ', ...
        '''conductance'' or ''resistance''.']); return;
end;

switch recsys 
    case 'conductance'
        power = 1;
    case 'resistance'
        power = -1;
end;

% catch zeros
z = (data == 0);
scr(z) = 0;

% catch integer types (linear algebra is not supported for integers)
data = double(data);

% convert
scr(~z) = 1./((c./(data(~z)-offset)).^power-Rs*1e-6);

