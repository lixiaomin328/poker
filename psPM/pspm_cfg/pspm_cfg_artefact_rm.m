function artefact_rm = pspm_cfg_artefact_rm

% $Id: pspm_cfg_artefact_rm.m 471 2017-08-28 13:28:09Z tmoser $
% $Rev: 471 $

%% Global items
chan_nr         = cfg_entry;
chan_nr.name    = 'Channel Number';
chan_nr.tag     = 'chan_nr';
chan_nr.strtype = 'i';
chan_nr.num     = [1 Inf];
chan_nr.help    = {''};

%% Medianfilter
nr_time_pt         = cfg_entry;
nr_time_pt.name    = 'Number of Time Points';
nr_time_pt.tag     = 'nr_time_pt';
nr_time_pt.strtype = 'i';
nr_time_pt.num     = [1 1];
nr_time_pt.help    = {'Number of time points over which the median is taken.'};

median         = cfg_branch;
median.name    = 'Median Filter';
median.tag     = 'median';
median.val     = {nr_time_pt};
median.help    = {''};

%% 1st order butterworth LP filter
freq         = cfg_entry;
freq.name    = 'Cutoff Frequency';
freq.tag     = 'freq';
freq.strtype = 'r';
freq.num     = [1 1];
freq.check   = @pspm_cfg_check_artefact_rm_freq;
freq.help    = {'Cutoff requency hast to be at least 20Hz.'};

butter         = cfg_branch;
butter.name    = 'Butterworth Lowpass Filter';
butter.tag     = 'butter';
butter.val  = {freq};
butter.help    = {'1st Order Butterworth Low Pass Filter'};

%% simple SCR quality correction
qa_min          = cfg_entry;
qa_min.name     = 'Minimum value';
qa_min.tag      = 'min';
qa_min.strtype  = 'r';
qa_min.num      = [1 1];
qa_min.val      = {0.05};
qa_min.help     = {'Minimum SCR value in microsiemens.'};

qa_max          = cfg_entry;
qa_max.name     = 'Maximum value';
qa_max.tag      = 'max';
qa_max.strtype  = 'r';
qa_max.num      = [1 1];
qa_max.val      = {60};
qa_max.help     = {'Maximum SCR value in microsiemens.'};

qa_slope          = cfg_entry;
qa_slope.name     = 'Maximum slope';
qa_slope.tag      = 'slope';
qa_slope.strtype  = 'r';
qa_slope.num      = [1 1];
qa_slope.val      = {10};
qa_slope.help     = {'Maximum SCR slope in microsiemens per second.'};

qa              = cfg_branch;
qa.name         = 'Simple SCR quality correction';
qa.tag          = 'simple_qa';
qa.val          = {qa_min, qa_max, qa_slope};
qa.help         = {'Simple SCR'};

%% Data file
datafile         = cfg_files;
datafile.name    = 'Data File';
datafile.tag     = 'datafile';
datafile.num     = [1 1];
%datafile.filter  = '\.mat$';
datafile.help    = {''};

filtertype         = cfg_choice;
filtertype.name    = 'Filter Type';
filtertype.tag     = 'filtertype';
filtertype.values  = {median,butter,qa};
filtertype.help    = {['Currently, median and butterworth filters are implemented. A median filter is ' ...
    'recommended for short spikes, generated for example in MRI scanners by gradient switching. A butterworth ' ...
    'filter is applied in most models; check there to see whether an additional filtering is meaningful.']};

%% Overwrite file
overwrite         = cfg_menu;
overwrite.name    = 'Overwrite Existing File';
overwrite.tag     = 'overwrite';
overwrite.val     = {false};
overwrite.labels  = {'No', 'Yes'};
overwrite.values  = {false, true};
overwrite.help    = {'Overwrite existing file?'};

%% Executable branch
artefact_rm      = cfg_exbranch;
artefact_rm.name = 'Artefact Removal';
artefact_rm.tag  = 'artefact_rm';
artefact_rm.val  = {datafile,chan_nr,filtertype,overwrite};
artefact_rm.prog = @pspm_cfg_run_artefact_rm;
artefact_rm.vout = @pspm_cfg_vout_artefact;
artefact_rm.help = {['This module offers a few basic artefact removal functions. Currently, ' ...
    'a median filter and a butterworth low pass filter are implemented. The median filter is ' ...
    'useful to remove short "spikes" in the data, for example from gradient switching in MRI. ' ...
    'The Butterworth filter can be used to get rid of high frequency noise that is not sufficiently ' ...
    'filtered away by the filters implemented on-the-fly during first level modelling.']};

function [sts, val] =  pspm_cfg_check_artefact_rm_freq(val)
sts = [];
if val < 20
    sts = 'Cutoff Frequency hast to be at least 20Hz';
end
if ~isempty(sts) uiwait(msgbox(sts)); end

function vout = pspm_cfg_vout_artefact(job)
vout = cfg_dep;
vout.sname      = 'Output File';
% this can be entered into any file selector
vout.tgt_spec   = cfg_findspec({{'class','cfg_files'}});
vout.src_output = substruct('()',{':'});
