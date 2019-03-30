function data = stublinks(data,graphics,lrtask,manualblinks,lowthresh)
% usage: data = stublinks(data,graphics,lrtask,manualblinks,lowthresh)
%   eg., p=stublinks(p,1,0,[1000:2000 3000:3200]);
% This code deblinks pupil data by identifying and linearly interpolating
%   through blinks
% It is a mash-up of Stuart Steinhauer's historical blink 
%  algorithm that correctly misses light reflex onsets and Eric Granholm's
%  code for features of pupillary waveforms that likely suggest blinks,
%  informed by Greg Siegle's manual inspections, with many other people's 
%  input.
% Inputs:
%   data is a vector of pupillary data in millimeters
%     (no default - necessary input)
%   graphics is whether or not to plot output
%     (defaults to 0)
%   lrtask is whether or not the task is a light-reflex task.
%     if lrtask=0 it expects a task with relatively
%         slow responses (i.e., no light reflex) and is thus
%         more conservative.
%     if lrtask =1, it expects a task with relatively
%         quick light-reflex responses
%     (defaults to 0)
%   manualblinks is a vector of samples that are known to be blinks
%    (defaults to empty)
%   lowthresh is a milimeter threshold below which data is assumed to be blinks
%    (defaults to .1)
% creates:
%   data.RescaleData (original input)
%   data.NoBlinks - smoothed data with interpolated blinks
%   data.NoBlinksUnsmoothed - unsmoothed data with interpolated blinks
%   data.BlinkTimes - 0=not a blink, 1=blink
% 
% Matlab code by Greg Siegle
%  note: Requires the Matlab statistics and signal processing toolboxes
%
% Please cite the following publication for its initial use:
% Siegle, G J, Steinhauer, S R, Stenger, VA, Konecky, R, & Carter, C S. (2003). Use of concurrent pupil dilation assessment to inform interpretation and analysis of fMRI data. Neuroimage, 20(1), 114-124. 


if nargin<2, graphics=0; end
if nargin<3, lrtask=0; end
if nargin<4, manualblinks=[]; end
if nargin<5, lowthresh=.1; end % values below this are blinks

if ~isstruct(data)
  tmp=data; clear data;
  data.RescaleData=tmp; 
end

% start with RescaleData which is the raw data from the pupilometer expressed in millimeters.

numpts=length(data.RescaleData); 
%avgdata=dbfilter(data.RescaleData,3); % smooth 
%avgdata=dbfilter(avgdata,3)'; % smooth 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Smoothing
% make a smoothed version of the data by making each point the average
% of it and the points around it 2x
avgdata=conv([1 1 1]./3,data.RescaleData);
avgdata=avgdata(2:numpts+1);
avgdata=conv([1 1 1]./3,avgdata); % was data.RescaleData until 8/17/15
avgdata=avgdata(2:numpts+1);
% kill the first few points which get artificially set to low values
% in convolution
avgdata(1:10)=data.RescaleData(1:10);
% similarly fix the last point which had some zeros averaged in
avgdata((end-10):end)=data.RescaleData(end-10:end);
avgdata(end:length(data.RescaleData))=avgdata(end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Identify blinks

% set up an array for all the times at which blinks could have occurred
data.BlinkTimes=zeros(size(data.RescaleData'));

% do different things for light reflex and regular tasks.
% for light reflex tasks we need to be more conservative about what we call blinks because
% otherwise the light reflex itself is marked as a blink
if lrtask
  data.BlinkTimes=data.BlinkTimes | (abs([(data.RescaleData(2:end)) (data.RescaleData(end))] - data.RescaleData) > .4)';
  data.BlinkTimes=(data.BlinkTimes | (data.RescaleData'<.2));  

  % mark changes in the derivative greater than expected
  diffs=[0 data.RescaleData(2:end)-data.RescaleData(1:end-1)]';
  diffthresh=[(prctile(diffs,75)+3.*iqr(diffs))];
  if diffthresh>0
    data.BlinkTimes=(data.BlinkTimes | (diffs>diffthresh));
  end
  data.BlinkTimes=(data.BlinkTimes | (abs(diffs)>.2));

  % fill in the gaps between close blinks
  for ct=1:length(data.RescaleData)-10
    if (data.BlinkTimes(ct)==1) & (data.BlinkTimes(ct+10)==1) data.BlinkTimes(ct:ct+10)=1; end
    if (data.BlinkTimes(ct)==1) & (data.BlinkTimes(ct+4)==1) data.BlinkTimes(ct:ct+4)=1;   end
  end
  
else
  % mark any change greater than .5 mm in 1 sample
  data.BlinkTimes=data.BlinkTimes | (abs([(data.RescaleData(2:end)) (data.RescaleData(end))] - data.RescaleData) > .5)';
  
  % mark any change where the data is very different from the smoothed version of the data
  % and where the smoothing does not average in a blink
  % first smooth the blinks to expand the areas considered to be blinks
  smoothblinks=conv(double(ones(1,30)./30),double(data.BlinkTimes'));
  smoothblinks=smoothblinks((length(smoothblinks)-length(data.BlinkTimes)+1):end);
  smoothblinks(1:100)=data.BlinkTimes(1:100);
  smoothblinks(end-100:end)=data.BlinkTimes(end-100:end);
  % now smooth the data with a 30 point kernal
  smoothdata=conv(ones(1,30)./30,data.RescaleData);
  smoothdata=smoothdata((length(smoothdata)-length(data.RescaleData)+1):end);
  smoothdata(1:100)=data.RescaleData(1:100);
  smoothdata(end-100:end)=data.RescaleData(end-100:end);
  % compare the actual data to the very-smoothed data. If they differ by more than 1 mm it's a blink
  % also if the smoothed data is at 0 mm it's not real - call it a blink
  data.BlinkTimes=data.BlinkTimes | ((abs(smoothdata-data.RescaleData)>1)' & (smoothblinks'==0));

  % any time where the pupil is below some arbitrary threshold we'll call that a blink too
  % by default, lowthresh is 0.1mm
  data.BlinkTimes=(data.BlinkTimes | (data.RescaleData'<lowthresh));
  % anything within 0.1 mm of the lowest value in the dataset is also called a blink
  % This is because values that are 0 coming from the pupilometer get made higher than
  % 0 when we apply the conversion to mm (constant + scalar*RescaleData) if the constant
  % is not 0.
  if (max(data.BlinkTimes)>0)
    data.BlinkTimes=(data.BlinkTimes | (data.RescaleData'<(min(data.RescaleData)+.1)));
  end
  
  % mark changes in the derivative greater than expected
  %diffs=[0 data.RescaleData(2:end)-data.RescaleData(1:end-1)]';
  %data.BlinkTimes=(data.BlinkTimes | (diffs>[(prctile(diffs,75)+3.*iqr(diffs))]));

  % anything 4mm from the median of the dataset is a blink because physiologically 
  % people probably don't have a 4mm range in their pupil
  data.BlinkTimes=(data.BlinkTimes | (abs(data.RescaleData'-median(data.RescaleData))>4));
  % mark changes outside the IQR from the Tukey hinges - standard outlier removal
  % note - went above 1.5 on the high end because we were finding some large task-related phasic changes
  data.BlinkTimes=(data.BlinkTimes | (data.RescaleData'<(prctile(data.RescaleData,25)-1.5.*iqr(data.RescaleData)))); % was 2
  data.BlinkTimes=(data.BlinkTimes | (data.RescaleData'>(prctile(data.RescaleData,75)+2.0.*iqr(data.RescaleData)))); % was 2
  
  % kill >3mm change in 500 samples (8.3 seconds) smoothing kernal (was 200)
  kernallen=min(500,length(data.RescaleData)-1);
  smoothdata=conv(ones(1,kernallen)./kernallen,data.RescaleData);
  smoothdata=smoothdata((length(smoothdata)-length(data.RescaleData)+1):end);
  smoothdata(1:kernallen)=data.RescaleData(1:kernallen);
  smoothdata(end-kernallen:end)=data.RescaleData(end-kernallen:end);
  smoothblinks=conv(double(ones(1,kernallen)./kernallen),double(data.BlinkTimes));
  smoothblinks=smoothblinks((length(smoothblinks)-length(data.BlinkTimes)+1):end);
  smoothblinks(1:kernallen)=data.BlinkTimes(1:kernallen);
  smoothblinks(end-kernallen:end)=data.BlinkTimes(end-kernallen:end);
  % was >3
  data.BlinkTimes=data.BlinkTimes | ((abs(smoothdata-data.RescaleData)>1.5)' & (smoothblinks==0));
  
%  for ct=500:length(data.RescaleData)
%    if abs(data.RescaleData(ct)-md(data.RescaleData(ct-499:ct)',data.BlinkTimes(ct-499:ct)))>3, data.BlinkTimes(ct)=1; end
%  end
  
  % mark .3 changes in 4 points - made .4 12/22/04
%  smoothdata=conv(ones(1,4)./4,data.RescaleData);
%  smoothdata=smoothdata((length(smoothdata)-length(data.RescaleData)+1):end);
%  smoothdata(1:4)=data.RescaleData(1:4);
%  smoothdata(end-4:end)=data.RescaleData(end-4:end);
%  smoothblinks=conv(ones(1,4)./4,data.BlinkTimes);
%  smoothblinks=smoothblinks((length(smoothblinks)-length(data.BlinkTimes)+1):end);
%  smoothblinks(1:4)=data.BlinkTimes(1:4);
%  smoothblinks(end-4:end)=data.BlinkTimes(end-4:end);
%  data.BlinkTimes=data.BlinkTimes | ((abs(smoothdata-data.RescaleData)>.4)' & (smoothblinks==0));

  % if point t is not a blink and point t+4 is not a blink, but there's a .4mm change from t to t+4 
  % call all 4 points a blink
  newblinks=data.BlinkTimes;
  for ct=1:(length(data.RescaleData)-5)
    if ((~data.BlinkTimes(ct)) & ~data.BlinkTimes(ct+4) & (abs(data.RescaleData(ct+4)-data.RescaleData(ct))>.4)), newblinks(ct:ct+4) = 1; end
  end
  data.BlinkTimes=newblinks;
  
  % fill in the gaps between close blinks
  for ct=1:length(data.RescaleData)-10
    if (data.BlinkTimes(ct)==1) & (data.BlinkTimes(ct+10)==1) data.BlinkTimes(ct:ct+10)=1; end
    if (data.BlinkTimes(ct)==1) & (data.BlinkTimes(ct+4)==1) data.BlinkTimes(ct:ct+4)=1;   end
  end
  
  
end


if nargin>3, data.BlinkTimes(manualblinks)=1; end
data.NoBlinks=avgdata;
data.NoBlinksUnsmoothed=data.RescaleData;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% now linearly interpolate pupil from the points before the blink to the points after the blink

% creates noblinks
blinkends=find((data.BlinkTimes(1:end-1)==1) & (data.BlinkTimes(2:end)==0));
blinkstarts  =find((data.BlinkTimes(2:end)==1) & (data.BlinkTimes(1:end-1)==0));
if data.BlinkTimes(1)==1
  blinkstarts=[1; blinkstarts];
end

if length(blinkends)>length(blinkstarts)
 blinkends=blinkends(2:end);
end

if length(blinkends)<length(blinkstarts)
  %blinkends(length(blinkends):length(blinkstarts))=blinkstarts(length(blinkends):length(blinkstarts))+1;
  blinkends(length(blinkends)+1)=length(data.BlinkTimes);
end

% if there are blinks with big slopes within 20 samples of each other then
% make them one long period.
  % if we have close blinks and the slope for one blink is oppositely signed of the slope
  % of the next blink then they should cancel
for roundnum=1:3
  for ct=1:(length(blinkstarts)-1)
    if ((blinkstarts(ct+1)-blinkends(ct))<30) & abs(((data.RescaleData(blinkends(ct))- data.RescaleData(blinkstarts(ct)))>.4)) &  abs(((data.RescaleData(blinkends(ct+1))- data.RescaleData(blinkstarts(ct+1)))<.2))
      blinkends(ct)=blinkstarts(ct);
      blinkstarts(ct+1)=blinkends(ct);
      data.BlinkTimes(blinkstarts(ct):blinkends(ct+1))=1;
    end
  end
end

% do the actual interpolation
% creates NoBlinks and NoBLinksUnsmoothed
for ct=1:length(blinkstarts)
  firstindex=max(1,blinkstarts(ct)-4);
  lastindex=min(numpts,blinkends(ct)+9);
  interpdata=linspace(avgdata(firstindex),avgdata(lastindex),max(1,lastindex-firstindex+1));
  data.NoBlinks(firstindex:lastindex)=interpdata;
  data.NoBlinksUnsmoothed(firstindex:lastindex)=interpdata;
end

% fix blinks at beginning
if max(data.BlinkTimes(1:10))
  goodct=[1:length(data.NoBlinks)]'+10000000.*data.BlinkTimes;
  mingood=min(min(goodct),length(data.NoBlinks));
  data.NoBlinks(1:mingood-1)=data.NoBlinks(mingood);
  data.NoBlinksUnsmoothed(1:mingood-1)=data.NoBlinks(mingood);
end
% fix blinks at end
if max(data.BlinkTimes(end-10:end))
  data.BlinkTimes((end-10):end)=1;
  goodct=[1:length(data.NoBlinks)]'+-9999999.*data.BlinkTimes;
  maxgood=max(goodct);
  data.NoBlinks((maxgood+1):end)=data.NoBlinks(maxgood);
  data.NoBlinksUnsmoothed((maxgood+1):end)=data.NoBlinks(maxgood);
end


data.NoBlinks=data.NoBlinks';

if graphics
 figure
 plot([data.RescaleData' data.NoBlinks data.BlinkTimes]);
end
