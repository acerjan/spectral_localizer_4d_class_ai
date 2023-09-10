function [] = calc4d_DOS(Hbase,figIdx)

    evalWid = 0.05; % for DOS.


    evals = eig(full(Hbase));
    minE = min(evals)-0.5;
    maxE = max(evals)+0.5;

    %% DOS:
    eAx = linspace(minE,maxE,4001);
    dos = 0*eAx;
    for ee=1:length(evals)
        dos = dos + exp(-(eAx - evals(ee)).^2 / (2*evalWid^2));
    end
    figure(figIdx);
    plot(eAx,dos,'LineWidth',2);
    %assert(false);
    ax = gca; % get current axes for figure.
    ax.FontSize = 16;
    ax.TickLabelInterpreter = 'latex';
    ax.LineWidth = 1.5;
    xlabel('Energy, $E$','Interpreter','latex','FontSize',18);
    ylabel('Density of states','Interpreter','latex','FontSize',18);

end