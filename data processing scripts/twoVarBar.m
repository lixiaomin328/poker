function twoVarBar(var1,var2)
barwitherr([0,0;std(var1)/sqrt(length(var1)),std(var2)/sqrt(length(var2));0,0],[0,0;mean(var1),mean(var2);0,0])