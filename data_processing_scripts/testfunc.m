function [trialIndex] = testfunc(structField)
%struct.both = eventStarts;durations
trialIndex = [];
for i = 1:(length(structField)) %for i = 1:103
    trialIndex(1, ((structField(1,i)): ...
        ((structField(1,i))+(structField(2,i)))))...
        = i;
end