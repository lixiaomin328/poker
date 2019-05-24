function out = pspm_cfg_run_downsample(job)
% Executes pspm_down

% $Id: pspm_cfg_run_downsample.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

% channels to downsample
if isfield(job.chan,'all_chan')
    chan = 0;
else
    chan = job.chan.chan_vec;
end

% options
options.overwrite = job.overwrite;

[sts, out] = pspm_down(job.datafile, job.newfreq, chan, options);

if ~iscell(out)
    out ={out};
end