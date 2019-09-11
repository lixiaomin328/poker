function [cfg] = pspm_cfg_pp_pupil
% function [cfg] = pspm_cfg_pp_pupil
%
% Matlabbatch menu for data preprocessing
%__________________________________________________________________________
% PsPM 3.1
% (C) 2016 Tobias Moser (University of Zurich)

% $Id: pspm_cfg_pp_pupil.m 481 2017-09-29 15:21:55Z tmoser $
% $Rev: 481 $

%% Data preprocessing
cfg        = cfg_repeat;
cfg.name   = 'Pupil & Eye tracking';
cfg.tag    = 'pp_pupil';
cfg.values = {pspm_cfg_process_illuminance, pspm_cfg_find_valid_fixations};
cfg.forcestruct = true;
cfg.help   = {'Help: Pupil & Eye tracking preprocessing'};
