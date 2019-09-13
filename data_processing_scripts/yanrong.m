
load('participant_3.mat')
result = zeros(168,2);
%Make the first column probability to bet and the second column Mean Rt
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+7,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+7,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

%repeat the script for part4 to part 15
load('participant_4.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+14,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+14,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+21,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+21,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_5.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+28,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+28,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+35,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+35,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_6.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+42,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+42,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+49,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+49,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_7.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+56,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+56,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+63,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+63,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_9.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+70,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+70,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+77,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+77,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_10.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+84,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+84,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+91,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+91,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_11.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+98,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+98,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+105,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+105,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_12.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+112,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+112,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+119,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+119,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_13.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+126,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+126,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+133,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+133,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_14.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+140,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+140,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+147,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+147,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

load('participant_15.mat')
for n = 1:7
num1 = dataStructure.trials_thisN(dataStructure.P1card == n+1) + 1;
result(n+154,1)= sum(dataStructure.player1ActionCheck_keys(num1) == 1) /length(num1);
num2 = dataStructure.trials_thisN(dataStructure.P1card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+154,2) = sum(dataStructure.p1normalizedRt(num2))/length(num2);
num3 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player1ActionCheck_keys == 1) + 1;
result(n+161,1)= sum(dataStructure.player2ActionCheck_keys(num3) == 1) /length(num3);
num4 = dataStructure.trials_thisN(dataStructure.P2card == n+1 & dataStructure.player2ActionCheck_keys == 1) + 1;
result(n+161,2) = sum(dataStructure.p2normalizedRt(num4))/length(num4);
end

%Scatter the result
scatter(result(:,1),result(:,2))
xlabel('probability to bet') 
ylabel('Mean Rt')
