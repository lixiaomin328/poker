%% plot prettier
%run this after each plot

%% change line width
for i = 1:2
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 1.5;
end

%% add x, y label
%xlabel('Time');
%ylabel('Pupil Size');
set(gca,'FontSize',20);
end
%% add legend
