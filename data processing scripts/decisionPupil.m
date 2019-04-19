%plot pupil size during all decidings

whereP1DecideEnds = [];
whereP1DecideStart = [];

for i = 2:(height(data_et)-1)
    if (data_et.eventType(i) == 1 && data_et.eventType(i+1) ~= 1)
        whereP1DecideEnds = [whereP1DecideEnds, i];
    end
    if (data_et.eventType(i) == 1 && data_et.eventType(i-1) ~= 1)
        whereP1DecideStart = [whereP1DecideStart, i];
    end
end
