function [] = make_ai_4d_pseudospectrum()

    %% init:
    nUC = 5;
    t = 1;
    t1 = 0.8; %*exp(1i*pi*0.1);
    t2 = 0.0;
    m = 0.5;
    a = 1;

    E0 = 0;
    x0 = 0;
    y0 = 0;
    z0 = 0;
    w0 = 0;
    ptsPerA = 14;
    lxVec = linspace(0,(nUC/2+1/2)*a,round((nUC/2+1/2)*ptsPerA+1));

    kappa = 0.1;

    [HH,XX,YY,ZZ,WW] = ai_4d_hamil_pos(nUC,nUC,nUC,nUC,t,t1,t2,m,a);

    disp(normest(HH));
    disp(normest(XX));
    disp(normest(YY));
    disp(normest(ZZ));
    disp(normest(WW));
    disp(normest(HH*XX - XX*HH));
    disp(kappa*normest(HH*YY - YY*HH));
    disp(kappa*normest(HH*ZZ - ZZ*HH));
    disp(kappa*normest(HH*WW - WW*HH));

    disp(normest(HH*XX - XX*HH)/(normest(HH)*normest(XX)));

    %calc4d_DOS(HH,1);

    %localizer_4D_evalFlow(E0,lxVec,y0,z0,w0,HH,XX,YY,ZZ,WW,kappa,2);
    
    %genData = 0;
    %localizer_4D_surfXY(E0,lxVec,lxVec,z0,w0,HH,XX,YY,ZZ,WW,kappa,genData,1);
    %localizer_4D_surfXZ(E0,lxVec,lxVec,y0,w0,HH,XX,YY,ZZ,WW,kappa,genData,3);
    %localizer_4D_surfXW(E0,lxVec,lxVec,y0,z0,HH,XX,YY,ZZ,WW,kappa,genData,5);
    %localizer_4D_surfYZ(E0,lxVec,lxVec,x0,w0,HH,XX,YY,ZZ,WW,kappa,genData,7);
    %localizer_4D_surfYW(E0,lxVec,lxVec,x0,z0,HH,XX,YY,ZZ,WW,kappa,genData,9);
    %localizer_4D_surfZW(E0,lxVec,lxVec,x0,y0,HH,XX,YY,ZZ,WW,kappa,genData,11);

end