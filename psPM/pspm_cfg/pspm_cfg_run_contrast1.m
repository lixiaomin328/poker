function out = pspm_cfg_run_contrast1(job)
% Executes pspm_con1

% $Id: pspm_cfg_run_contrast1.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

% modelfile
modelfile = job.modelfile;

% contrast names & vectors
nrCon = size(job.con,2);
for iCon=1:nrCon
    connames{1,iCon} = job.con(iCon).conname;
    convec{1,iCon} = job.con(iCon).convec;
end

% delete existing contrast
deletecon = job.deletecon;

% zscore data
options.zscored = job.zscored;

% datatype
datatype = job.datatype;

pspm_con1(modelfile, connames, convec, datatype, deletecon, options);

out = modelfile;