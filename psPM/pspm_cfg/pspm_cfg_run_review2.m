function pspm_cfg_run_review2(job)
% Runs review model - second level

% $Id: pspm_cfg_run_review2.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

if isempty(job.con)
    pspm_rev2(job.modelfile{1});
else
    pspm_rev2(job.modelfile{1}, job.con);
end