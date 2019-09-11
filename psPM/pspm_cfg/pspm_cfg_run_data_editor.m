function pspm_cfg_run_data_editor(job)

% $Id: pspm_cfg_run_data_editor.m 451 2017-07-04 06:32:41Z tmoser $
% $Rev: 451 $

fn = job.datafile{1};

options = struct();
if isfield(job.outputfile, 'enabled')
    options.output_file = [job.outputfile.enabled.file_path{1} filesep ...
        job.outputfile.enabled.file_name];
end;
    

pspm_data_editor(fn, options);