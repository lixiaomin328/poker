function review = pspm_cfg_review2
% Review model (first level)

% $Id: pspm_cfg_review2.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

%% Data File Selector
modelfile         = cfg_files;
modelfile.name    = 'Model File';
modelfile.tag     = 'modelfile';
modelfile.num     = [1 1];
modelfile.filter  = '.*\.(mat|MAT)$';
modelfile.help    = {'Specify 2nd level model file.'};

%% Contrast Vector
con         = cfg_entry;
con.name    = 'Contrast Vector';
con.tag     = 'con';
con.strtype = 'r';
con.val     = {[]};
con.num     = [0 Inf];
con.help    = {'Index of contrasts to be reported (optional).'};


%% Executable Branch
review      = cfg_exbranch;
review.name = 'Report Second-Level Results';
review.tag  = 'report';
review.val  = {modelfile, con};
review.prog = @pspm_cfg_run_review2;
review.help = {'Result reporting for second level model.'};