function [vector] = outcomeloop(whatAction, whatClass, dataTable, vector)

mod = cat(1, whatAction, height(dataTable));
mod = mod(2:end);

for i = 1:length(whatAction)
    whereNextMsg = find(contains(dataTable.message((whatAction(i)):mod(i)),'P1 prechoose'));
    whereNextMsg = whereNextMsg + whatAction(i);
    
    if isempty(whereNextMsg) %if the last trial is of this type
        whereNextMsg = height(dataTable); %next message is end of exp
        vector(1, whatAction(i):end) = whatClass;
    else
        whereNextMsg = whereNextMsg(1, 1);
        vector((whatAction(i)):(whereNextMsg - 1)) = whatClass;
    end
end
