function newpupil = deblink(path,filename)
addpath('~/Documents/GitHub/fieldtrip');
addpath('pupilprocess');

ft_defaults;
asc = read_eyelink_ascNK_AU([path,filename]);

% create events and data structure, parse asc
[data, event, blinksmp, saccsmp] = asc2dat(asc);
%%
newpupil = blink_interpolate(data, blinksmp);