function [out] = pspm_cfg_run_find_valid_fixations(job)

% $Id: pspm_cfg_run_find_valid_fixations.m 458 2017-08-09 09:32:12Z tmoser $
% $Rev: 458 $

data_file = job.datafile{1};
options = struct();
    
options.box_degree = job.validation_settings.box_degree;
options.distance = job.validation_settings.distance;

options.screen_settings = struct();
options.screen_settings.aspect_actual = ...
    job.validation_settings.screen_settings.aspect_actual;
options.screen_settings.resolution = ...
    job.validation_settings.screen_settings.resolution;
options.screen_settings.display_size = ...
    job.validation_settings.screen_settings.screen_size;

if isfield(job.validation_settings.fixation_point, 'fixpoint')
    options.fixation_point = ...
        job.validation_settings.fixation_point.fixpoint;
elseif isfield(job.validation_settings.fixation_point, 'fixpoint_file')
    options.fixation_point = ...
        job.validation_settings.fixation_point.fixpoint_file{1};
end

if isfield(job.missing, 'enable_missing')
    options.missing = 1;
end

if isfield(job, 'eyes')
    options.eyes = job.eyes;
end

options.channels = regexp(job.channels, '\s+', 'split');
% convert numbers
num_vals = str2double(options.channels);
nums = ~isnan(num_vals);

options.channels(nums) = num2cell(num_vals(nums));

if isfield(job.output_settings.file_output, 'new_file')
    f_path = job.output_settings.file_output.new_file.file_path{1};
    f_name = job.output_settings.file_output.new_file.file_name;
    
    options.newfile = [f_path filesep f_name];
elseif isfield(job.output_settings.file_output, 'overwrite_original')
    options.newfile = '';
    options.overwrite = 1;
end

if isfield(job.output_settings.channel_output, 'add_channel')
    options.channel_action = 'add';
elseif isfield(job.output_settings.channel_output, 'replace_channel')
    options.channel_action = 'replace';
end

[~, out{1}] = pspm_find_valid_fixations(data_file, options);