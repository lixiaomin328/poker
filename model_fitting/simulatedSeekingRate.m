
%% simulate seeking rate with different parameters.
%% load the fixed opt parameters first
xh = x(1,[1 3:4]);
xs = x(1,[1:2 4]);
N =100; %simulation time
advantages = zeros(N,1);
advantageh = zeros(N,1);
advantagepred = zeros(N,N);

for i = 1:N
    for j = 1:N
[predictedh,~,~,~] = levelmodel([xh(1),i-1,xh(3)], saliencyResampled);
[~,predicteds,~,~] = levelmodel([xs(1),j-1,xs(3)], saliencyResampled);
advantages(i) = sum(predicteds.*hidehis);%seeking rate for fixed hider
advantageh(i) = sum(predictedh.*hists');%seeking rate for fixed seeker but higher level hider
advantagepred(i,j)=sum(predicteds.*predictedh);%seeking rate as both levels go up
i
    end
end

