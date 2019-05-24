function out = pspm_cfg_run_split_sessions(job)
% Split sessions

% $Id: pspm_cfg_run_split_sessions.m 458 2017-08-09 09:32:12Z tmoser $
% $Rev: 458 $

options = struct;
options.overwrite = job.overwrite;

if isfield(job.mrk_chan,'chan_nr')
    markerchannel = job.mrk_chan.chan_nr;
else
    markerchannel = 0;
end

if isfield(job.split_behavior, 'auto')
    options.splitpoints = [];
elseif isfield(job.split_behavior, 'marker')
    options.splitpoints = job.split_behavior.marker;
end

out = pspm_split_sessions(job.datafile, markerchannel, options);

if ~iscell(out)
    out = {out};
end