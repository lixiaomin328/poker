function cfg = pspm_cfg_first_level_hp

% $Id: pspm_cfg_first_level_hp.m 377 2016-10-31 15:57:10Z tmoser $
% $Rev: 377 $


%% First Level
cfg        = cfg_repeat;
cfg.name   = 'Heart period';
cfg.tag    = 'hp';
cfg.values = {pspm_cfg_glm_hp_e, pspm_cfg_glm_hp_fc}; % Values in a cfg_repeat can be any cfg_item objects
cfg.forcestruct = true;
cfg.help   = {''};