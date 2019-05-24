function cfg_add_module(arg)
% Calls the specified module in matalabbatch

% $Id: cfg_add_module.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

mod_cfg_id = cfg_util('tag2mod_cfg_id',arg);
cjob = cfg_util('initjob');
mod_job_id = cfg_util('addtojob', cjob, mod_cfg_id);
cfg_util('harvest', cjob, mod_job_id);
cfg_ui('local_showjob', cfg_ui, cjob);