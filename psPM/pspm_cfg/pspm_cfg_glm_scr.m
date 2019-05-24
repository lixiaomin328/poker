function glm_scr = pspm_cfg_glm_scr
% GLM

% $Id: pspm_cfg_glm_scr.m 450 2017-07-03 15:17:02Z tmoser $
% $Rev: 450 $

% Initialise
global settings
if isempty(settings), pspm_init; end;

% set variables

vars = struct();
vars.modality = 'SCR';
vars.modspec = 'SCR';
vars.glmref = { ...
        'Bach, Flandin, et al. (2009) Journal of Neuroscience Methods (Development of the SCR model)', ...
        'Bach, Flandin, et al. (2010) International Journal of Psychophysiology (Canonical SCR function)', ...
        'Bach, Friston & Dolan (2013) Psychophysiology (Improved algorithm)', ...
        'Bach (2014) Biological Psychology (Comparison with Ledalab)' ...
    };
vars.glmhelp = '';

% load default settings
glm_scr = pspm_cfg_glm(vars);

% set callback function
glm_scr.prog = @pspm_cfg_run_glm_scr;

% set correct name
glm_scr.name = 'GLM for SCR';
glm_scr.tag = 'glm_scr';


