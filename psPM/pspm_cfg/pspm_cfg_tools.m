function cfg = pspm_cfg_tools

% $Id: pspm_cfg_tools.m 481 2017-09-29 15:21:55Z tmoser $
% $Rev: 481 $


%% Preparation
cfg        = cfg_repeat;
cfg.name   = 'Tools';
cfg.tag    = 'tools';
cfg.values = {pspm_cfg_display, pspm_cfg_rename, pspm_cfg_split_sessions, ...
    pspm_cfg_merge, pspm_cfg_artefact_rm, pspm_cfg_downsample, pspm_cfg_interpolate, ... 
    pspm_cfg_extract_segments, pspm_cfg_segment_mean, pspm_cfg_get_markerinfo, ...
    pspm_cfg_data_editor, pspm_cfg_data_convert};
cfg.forcestruct = true;
cfg.help   = {'Help: Tools...'};
