function cfg = pspm_cfg_second_level

% $Id: pspm_cfg_second_level.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $


%% First Level
cfg        = cfg_repeat;
cfg.name   = 'Second Level';
cfg.tag    = 'second_level';
cfg.values = {pspm_cfg_contrast2, pspm_cfg_review2};
cfg.forcestruct = true;
cfg.help   = {'Help: Second Level...'};