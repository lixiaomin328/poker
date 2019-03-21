%% plot prettier
%run this after each plot

%% change line width
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

%% add x, y label
xlabel('Saliency level');
ylabel('Probability Density');
set(gca,'FontSize',36);

%% add legend
legend('Level 0','Level 1', 'Level 2','Level 3','Level 4');