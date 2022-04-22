pupilDataLocation = '/Users/xiaominli/Documents/pupilAll/pupil4/mat/outliers';
pupilFiles = dir([pupilDataLocation,'/*.mat']);
c1=[];
c0=[];
for i = 1:length(pupilFiles)
    load([pupilDataLocation,'/',pupilFiles(i).name])
    c1 = [c1,ploted_data.c_1.pupil(1:500)];
    c0 = [c0,ploted_data.c_0.pupil(1:500)];
end
%%
c0 = mean(c0,2);
c1 = mean(c1,2);
