function [cfg] = pspm_cfg_pp_emg
% function [cfg] = pspm_cfg_pp_emg
%
% Matlabbatch menu for data preprocessing
%__________________________________________________________________________
% PsPM 3.1
% (C) 2016 Tobias Moser (University of Zurich)

% $Id: pspm_cfg_pp_emg.m 406 2017-01-30 09:28:52Z tmoser $
% $Rev: 406 $

%% Data preprocessing
cfg        = cfg_repeat;
cfg.name   = 'Startle EMG';
cfg.tag    = 'pp_emg';
cfg.values = {pspm_cfg_find_sounds, pspm_cfg_pp_emg_data};
cfg.forcestruct = true;
cfg.help   = {'Help: EMG preprocessing'};