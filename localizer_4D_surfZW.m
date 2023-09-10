function [] = localizer_4D_surfZW(E0,lxVec,lyVec,x0,y0,HH,XX,YY,ZZ,WW,kappa,genData,figIdx)

    %% init:
    if (~exist('figIdx'))
        figIdx = 1;
    end

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

    gapMat = zeros(length(lyVec),length(lxVec));
    indMat = zeros(length(lyVec),length(lxVec));

    %% run it:
    saveStr = 'classAI_surfZW';
    if genData
        addpath('../general_functions');

        opts.tol = 10^-8;
        opts.maxit = 700;
        
        for yy=1:length(lyVec)
            for xx=1:length(lxVec)
                disp(['W: ',num2str(yy/length(lyVec)),' Z: ',num2str(xx/length(lxVec))]);

                LL = kron(Gamma1,kappa*(XX-x0*Iden)) +...
                    kron(Gamma2,kappa*(YY-y0*Iden)) +...
                    kron(Gamma3,kappa*(ZZ-lxVec(xx)*Iden)) +...
                    kron(Gamma4,kappa*(WW-lyVec(yy)*Iden)) +...
                    kron(Gamma5,(HH-E0*Iden));

                gapMat(yy,xx) = abs(eigs(LL,1,'sm',opts));

                indMat(yy,xx) = signatureComplex(LL)/2;
            end
        end

        save([saveStr,'.mat'],'gapMat','indMat','E0','lxVec','lyVec','x0','y0','HH','XX','YY','ZZ','WW','kappa');
    else
        load([saveStr,'.mat'],'gapMat','indMat','E0','lxVec','lyVec','x0','y0','HH','XX','YY','ZZ','WW','kappa');
    end

    %% plot it:
    xMin = min(lxVec);
    xMax = max(lxVec);
    yMin = min(lyVec);
    yMax = max(lyVec);
    buf = 0;

    [lambdaMatX,lambdaMatY] = meshgrid(lxVec,lyVec);

    figure(figIdx);
    pp = pcolor(lambdaMatX,lambdaMatY,gapMat);
    pp.EdgeColor = 'none';
    %xticks(-2:2:10);
    %yticks(-2:2:10);
    ax = gca; % get current axes for figure.
    ax.FontSize = 16;
    ax.TickLabelInterpreter = 'latex';
    ax.LineWidth = 1.5;
    xlabel('$z$','Interpreter','latex','FontSize',18);
    ylabel('$w$','Interpreter','latex','FontSize',18);
    colorbar('LineWidth',1.5,'TickLabelInterpreter','latex','FontSize',16);
    caxis([0, 0.05]);
    colormap(bone);
    axis([xMin-buf, xMax+buf, yMin-buf, yMax+buf]);


    indMat(indMat == 0) = NaN;
    ncol = length(lambdaMatX(1,:));
    nrow = length(lambdaMatX(:,1));
    db = 20;
    %indMat(1:(1+db),1:(1+db)) = 4;
    %indMat(1:(1+db),(ncol-db):ncol) = 4;
    %indMat((nrow-db):nrow,1:(1+db)) = 4;
    %indMat((nrow-db):nrow,(ncol-db):ncol) = 4;
    figure(figIdx+1);
    pp = pcolor(lambdaMatX,lambdaMatY,indMat);
    pp.EdgeColor = 'none';
    shading flat;

    ax = gca; % get current axes for figure.
    ax.FontSize = 16;
    ax.TickLabelInterpreter = 'latex';
    ax.LineWidth = 1.5;
    xlabel('$z$','Interpreter','latex','FontSize',18);
    ylabel('$w$','Interpreter','latex','FontSize',18);
    colorbar('LineWidth',1.5,'TickLabelInterpreter','latex','FontSize',16);
    %caxis([0, 1]);
    colormap(winter);
    hold on;
    ms = 1;
    cc = [0,0,0];
    plot([xMin-buf],[yMin-buf],'Marker','.','Color',cc,'MarkerSize',ms);
    plot([xMax+buf],[yMin-buf],'Marker','.','Color',cc,'MarkerSize',ms);
    plot([xMin-buf],[yMax+buf],'Marker','.','Color',cc,'MarkerSize',ms);
    plot([xMax+buf],[yMax+buf],'Marker','.','Color',cc,'MarkerSize',ms);
    hold off;

    axis([xMin-buf, xMax+buf, yMin-buf, yMax+buf]);

end