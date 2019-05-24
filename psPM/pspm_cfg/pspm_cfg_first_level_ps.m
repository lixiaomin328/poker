function cfg = pspm_cfg_first_level_ps

% $Id: pspm_cfg_first_level_ps.m 377 2016-10-31 15:57:10Z tmoser $
% $Rev: 377 $


%% First Level
cfg        = cfg_repeat;
cfg.name   = 'Pupil size';
cfg.tag    = 'ps';
cfg.values = {pspm_cfg_glm_ps_fc}; % Values in a cfg_repeat can be any cfg_item objects
cfg.forcestruct = true;
cfg.help   = {''};