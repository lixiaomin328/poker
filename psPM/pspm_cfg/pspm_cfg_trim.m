function trim = pspm_cfg_trim

% $Id: pspm_cfg_trim.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $


%% Select file
datafile         = cfg_files;
datafile.name    = 'Data File(s)';
datafile.tag     = 'datafile';
datafile.num     = [1 Inf];
datafile.help    = {'Select datafile.'};

%% Marker channel number
chan_def         = cfg_const;
chan_def.name    = 'Default';
chan_def.tag     = 'chan_def';
chan_def.val     = {0};
chan_def.help    = {''};

chan_nr         = cfg_entry;
chan_nr.name    = 'Number';
chan_nr.tag     = 'chan_nr';
chan_nr.strtype = 'i';
chan_nr.num     = [1 1];
chan_nr.help    = {''};

mrk_chan         = cfg_choice;
mrk_chan.name    = 'Marker Channel';
mrk_chan.tag     = 'mrk_chan';
mrk_chan.val  = {chan_def};
mrk_chan.values  = {chan_def,chan_nr};
mrk_chan.help    = {['If you have more than one marker channel, choose the reference ' ...
    'marker channel (default: use the first marker channel in the file).']};

%% Items for reference: File
file_from         = cfg_entry;
file_from.name    = 'From (seconds after file start)';
file_from.tag     = 'from';
file_from.strtype = 'r';
file_from.num     = [1 1];
file_from.help    = {'Choose a positive value.'};

file_to         = cfg_entry;
file_to.name    = 'To (seconds after file start)';
file_to.tag     = 'to';
file_to.strtype = 'r';
file_to.num     = [1 1];
file_to.help    = {'Choose a positive value larger than the ''from'' value.'};

%% Items for reference: First/Last Marker
fl_mrk_from         = cfg_entry;
fl_mrk_from.name    = 'From (seconds after first marker)';
fl_mrk_from.tag     = 'from';
fl_mrk_from.strtype = 'r';
fl_mrk_from.num     = [1 1];
fl_mrk_from.help    = {'Choose a positive (after first marker) or negative (before first marker) value.'};

fl_mrk_to         = cfg_entry;
fl_mrk_to.name    = 'To (seconds after last marker)';
fl_mrk_to.tag     = 'to';
fl_mrk_to.strtype = 'r';
fl_mrk_to.num     = [1 1];
fl_mrk_to.help    = {'Choose a positive (after last marker) or negative (before last marker) value.'};

%% Items for reference: Any Marker
any_mrk_from_nr         = cfg_entry;
any_mrk_from_nr.name    = 'Marker Number x';
any_mrk_from_nr.tag     = 'mrkno';
any_mrk_from_nr.strtype = 'i';
any_mrk_from_nr.num     = [1 1];
any_mrk_from_nr.help    = {'Choose an integer value.'};

any_mrk_to_nr         = cfg_entry;
any_mrk_to_nr.name    = 'Marker Number y';
any_mrk_to_nr.tag     = 'mrkno';
any_mrk_to_nr.strtype = 'i';
any_mrk_to_nr.num     = [1 1];
any_mrk_to_nr.help    = {'Choose an integer value.'};

any_mrk_from         = cfg_entry;
any_mrk_from.name    = 'Seconds after Marker x';
any_mrk_from.tag     = 'mrksec';
any_mrk_from.strtype = 'r';
any_mrk_from.num     = [1 1];
any_mrk_from.help    = {'Choose a positive (after this marker) or negative (before this marker) value.'};

any_mrk_to         = cfg_entry;
any_mrk_to.name    = 'Seconds after Marker y';
any_mrk_to.tag     = 'mrksec';
any_mrk_to.strtype = 'r';
any_mrk_to.num     = [1 1];
any_mrk_to.help    = {'Choose a positive (after this marker) or negative (before this marker) value.'};

ref_any_mrk_from         = cfg_branch;
ref_any_mrk_from.name    = 'From';
ref_any_mrk_from.tag     = 'from';
ref_any_mrk_from.val     = {any_mrk_from_nr,any_mrk_from};
ref_any_mrk_from.help    = {'Choose marker number and trimming point in seconds after this marker.'};

ref_any_mrk_to         = cfg_branch;
ref_any_mrk_to.name    = 'To';
ref_any_mrk_to.tag     = 'to';
ref_any_mrk_to.val     = {any_mrk_to_nr,any_mrk_to};
ref_any_mrk_to.help    = {'Choose marker number and trimming point in seconds after this marker.'};

%% Reference
ref_file         = cfg_branch;
ref_file.name    = 'File';
ref_file.tag     = 'ref_file';
ref_file.val     = {file_from,file_to};
ref_file.help    = {'Trim from xx seconds after file start to xx seconds after file start.'};

ref_fl_mrk         = cfg_branch;
ref_fl_mrk.name    = 'First/Last Marker';
ref_fl_mrk.tag     = 'ref_mrk';
ref_fl_mrk.val     = {fl_mrk_from,fl_mrk_to,mrk_chan};
ref_fl_mrk.help    = {'Trim from xx seconds after first marker to xx seconds after last marker.'};

ref_any_mrk         = cfg_branch;
ref_any_mrk.name    = 'Any Marker';
ref_any_mrk.tag     = 'ref_any_mrk';
ref_any_mrk.val     = {ref_any_mrk_from,ref_any_mrk_to,mrk_chan};
ref_any_mrk.help    = {['Trim from xx seconds after any marker of your choice to xx ' ...
    'seconds after any marker of your choice.']};

%% Reference Choice
ref         = cfg_choice;
ref.name    = 'Reference';
ref.tag     = 'ref';
ref.values  = {ref_file,ref_fl_mrk,ref_any_mrk};
ref.help    = {['Choose your reference for trimming: file start, first/last marker, ' ...
    'or a user-defined marker. All trimming is defined in seconds after this reference ' ...
    '- choose negative values if you want to trim before the reference.']};

%% Overwrite file
overwrite         = cfg_menu;
overwrite.name    = 'Overwrite Existing File';
overwrite.tag     = 'overwrite';
overwrite.val     = {false};
overwrite.labels  = {'No', 'Yes'};
overwrite.values  = {false, true};
overwrite.help    = {'Overwrite existing file?'};

%% Executable branch
trim      = cfg_exbranch;
trim.name = 'Trim';
trim.tag  = 'trim';
trim.val  = {datafile,ref,overwrite};
trim.prog = @pspm_cfg_run_trim;
trim.vout = @pspm_cfg_vout_trim;
trim.help = {['Trim away unnessecary data, for example before an experiment started, ' ...
    'or after it ended. Trim points can be defined in seconds with respect to start of ' ...
    'the data file, in seconds with respect to first and last marker (if markers exist), ' ...
    'or in seconds with respect to a user-defined marker. The resulting data will be written ' ...
    'to a new file, prepended with ''t''.']};

function vout = pspm_cfg_vout_trim(job)
vout = cfg_dep;
vout.sname      = 'Output File';
% this can be entered into any file selector
vout.tgt_spec   = cfg_findspec({{'class','cfg_files'}});
vout.src_output = substruct('()',{':'});

