function [] = localizer_4D_evalFlow(E0,lxVec,y0,z0,w0,HH,XX,YY,ZZ,WW,kappa,figIdx)

    %% init:
    if (~exist('figIdx'))
        figIdx = 1;
    end
    
    nKeep = 20;

    %% setup:
    Gamma1 = [0, 0, +1, 0;...
              0, 0, 0, -1;...
              +1, 0, 0, 0;...
              0, -1, 0, 0];
    
    Gamma2 = [0, 0, -1i, 0;...
              0, 0, 0, -1i;...
              +1i, 0, 0, 0;...
              0, +1i, 0, 0];

    Gamma3 = [0, 0, 0, +1;...
              0, 0, +1, 0;...
              0, +1, 0, 0;...
              +1, 0, 0, 0];

    Gamma4 = [0, 0, 0, -1i;...
              0, 0, +1i, 0;...
              0, -1i, 0, 0;...
              +1i, 0, 0, 0];

    Gamma5 = [+1, 0, 0, 0;...
              0, +1, 0, 0;...
              0, 0, -1, 0;...
              0, 0, 0, -1];

    Gamma1 = sparse(Gamma1);
    Gamma2 = sparse(Gamma2);
    Gamma3 = sparse(Gamma3);
    Gamma4 = sparse(Gamma4);
    Gamma5 = sparse(Gamma5);

    nPts = size(HH,2);
    Iden = speye(nPts);      

    gapVec = zeros(length(lxVec),1);
    indVec = zeros(length(lxVec),1);
    evalMat = zeros(nKeep,length(lxVec));

    %% run it:
    addpath('../general_functions');

    opts.tol = 10^-8;
    opts.maxit = 700;
    
    for xx=1:length(lxVec)
        disp(xx/length(lxVec));

        LL = kron(Gamma1,kappa*(XX-lxVec(xx)*Iden)) +...
             kron(Gamma2,kappa*(YY-y0*Iden)) +...
             kron(Gamma3,kappa*(ZZ-z0*Iden)) +...
             kron(Gamma4,kappa*(WW-w0*Iden)) +...
             kron(Gamma5,(HH-E0*Iden));

        if nKeep == nPts
            evalMat(:,xx) = eig(full(LL));
        else
            evalMat(:,xx) = eigs(LL,nKeep,'sm',opts);
        end
        [~,idxSort] = sort(evalMat(:,xx),'ascend');
        evalMat(:,xx) = evalMat(idxSort,xx);
        gapVec(xx) = min(abs(evalMat(:,xx)));

        indVec(xx) = signatureComplex(LL)/2;
    end

    %% plot it:
    figure(figIdx);
    plot(lxVec,gapVec,'LineWidth',2);
    hold on;
    %plot(lambdaVec,gapVec_aiii,'LineWidth',2,'LineStyle','--');
    hold off;
    grid on;
    ax = gca; % get current axes for figure.
    ax.FontSize = 16;
    ax.TickLabelInterpreter = 'latex';
    ax.LineWidth = 1.5;
    xlabel('Position, $x$','Interpreter','latex','FontSize',18);
    ylabel('Localizer gap','Interpreter','latex','FontSize',18);

    figure(figIdx+1);
    plot(lxVec,indVec,'LineWidth',2);
    hold on;
    %plot(lambdaVec,indVec_aiii,'LineWidth',2,'LineStyle','--');
    hold off;
    grid on;
    ax = gca; % get current axes for figure.
    ax.FontSize = 16;
    ax.TickLabelInterpreter = 'latex';
    ax.LineWidth = 1.5;
    xlabel('Position, $x$','Interpreter','latex','FontSize',18);
    ylabel('Localizer index','Interpreter','latex','FontSize',18);
    %ylim([-1.1, 1.1]);


    figure(figIdx+2);
    for ii=1:nKeep
        plot(lxVec,evalMat(ii,:),'Marker','x','Color',[0.4,0.4,0.4],'LineStyle','none','MarkerSize',10,'LineWidth',2);
        hold on;
    end
    hold off;
    grid on;
    ax = gca;
    ax.TickLabelInterpreter = 'latex';
    ax.FontSize = 18;
    ax.LineWidth = 2;
    %axis([-2,5,-1,1]);
    ax = gca; % get current axes for figure.
    ax.FontSize = 16;
    ax.TickLabelInterpreter = 'latex';
    ax.LineWidth = 1.5;
    xlabel('Position, $x$','Interpreter','latex','FontSize',18);
    ylabel('Localizer eigenvalues','Interpreter','latex','FontSize',18);
    %axis([min(lambdaVec) max(lambdaVec) -1.0 1.0])

end