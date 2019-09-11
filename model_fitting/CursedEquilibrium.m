%cursed equilibria
alpha = 0.5;
cursedMove = 0.5;
payoffparams = [3,1,1];
equilibriumP1 = [1;0;0;0;0;1;1];
equilibriumP2 = [0;0;0;0;1;1;1];
prior = 1/(length(equilibriumP2)-1);
cursedP1 = alpha*cursedMove*ones(size(equilibriumP1))+(1-alpha)*equilibriumP1;
cursedP2 = alpha*cursedMove*ones(size(equilibriumP2))+(1-alpha)*equilibriumP2;
[u1,u2]= utilityTexas(cursedP1,cursedP1,payoffparams);
bResponse2 = sign(u2 + payoffparams(2))/2+1/2;
bResponse1 = sign(u1 - (payoffparams(3)*([0:(length(equilibriumP1)-1)]'*2*prior-1)))/2+1/2;
plot([1:length(equilibriumP2)],bResponse1)
hold on
plot([1:length(equilibriumP2)],bResponse2)
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
lines(i).LineWidth = 3.0;
end
xlabel('Hands');
ylabel('action');
set(gca,'FontSize',36);