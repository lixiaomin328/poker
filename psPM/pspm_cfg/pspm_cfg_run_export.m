function pspm_cfg_run_export(job)
% Executes pspm_exp

% $Id: pspm_cfg_run_export.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

% datafile
modelfile = job.modelfile;

% target
if isfield(job.target, 'screen')
    target = 'screen';
else
    target = job.target.filename;
end

% datatype
datatype = job.datatype;

% delimiter
delimfield = fieldnames(job.delim);
delim = job.delim.(delimfield{1});


pspm_exp(modelfile, target, datatype, delim);