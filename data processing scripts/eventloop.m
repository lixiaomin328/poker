function vector = eventloop(see, decide, whatClass, vector)

for i = 1:length(see)
    vector(1, see(i):(decide(i)-1)) = whatClass;
end
