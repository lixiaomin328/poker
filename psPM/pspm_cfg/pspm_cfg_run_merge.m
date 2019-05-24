function [out] = pspm_cfg_run_merge(job)

% $Id: pspm_cfg_run_merge.m 451 2017-07-04 06:32:41Z tmoser $
% $Rev: 451 $

% load input files
infile1 = job.datafiles.first_file;
infile2 = job.datafiles.second_file;

% set reference
ref = job.reference;

% set options
options.overwrite = job.options.overwrite;
options.marker_chan_num = job.options.marker_chan;

% run merge
[out] = pspm_merge(infile1, infile2, ref, options);

% ensure output is always a cell
if ~iscell(out)
    out = {out};
end;