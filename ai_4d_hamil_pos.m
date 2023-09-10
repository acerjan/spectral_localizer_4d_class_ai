%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ai_4d_hamil_pos.m
% Alex Cerjan
% 4.4.23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [HH,XX,YY,ZZ,WW] = ai_4d_hamil_pos(nUCx,nUCy,nUCz,nUCw,t,t1,t2,m,a)

    nVals = 4*nUCx*nUCy*nUCz*nUCw;

    xHvec = zeros(11*nVals,1);
    yHvec = zeros(11*nVals,1);
    vHvec = zeros(11*nVals,1);
    iiH = 1;

    xPvec = zeros(nVals,1);
    vXvec = zeros(nVals,1);
    vYvec = zeros(nVals,1);
    vZvec = zeros(nVals,1);
    vWvec = zeros(nVals,1);
    iiP = 1;

    for ww=1:nUCw
        for zz=1:nUCz
            for yy=1:nUCy
                for xx=1:nUCx

                    %% define indices:
                    idxCurA = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 1;
                    idxCurB = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 2;
                    idxCurC = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 3;
                    idxCurD = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 4;

                    if xx>1
                        idxAprevX = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-2) + 1;
                        idxBprevX = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-2) + 2;
                        idxCprevX = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-2) + 3;
                        idxDprevX = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-2) + 4;
                    else
                        idxAprevX = 0;
                        idxBprevX = 0;
                        idxCprevX = 0;
                        idxDprevX = 0;
                    end

                    if xx<nUCx
                        idxAnextX = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-0) + 1;
                        idxBnextX = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-0) + 2;
                        idxCnextX = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-0) + 3;
                        idxDnextX = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-0) + 4;
                    else
                        idxAnextX = 0;
                        idxBnextX = 0;
                        idxCnextX = 0;
                        idxDnextX = 0;
                    end

                    if yy>1
                        idxAprevY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-2) + 4*(xx-1) + 1;
                        idxBprevY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-2) + 4*(xx-1) + 2;
                        idxCprevY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-2) + 4*(xx-1) + 3;
                        idxDprevY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-2) + 4*(xx-1) + 4;
                    else
                        idxAprevY = 0;
                        idxBprevY = 0;
                        idxCprevY = 0;
                        idxDprevY = 0;
                    end

                    if yy<nUCy
                        idxAnextY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-0) + 4*(xx-1) + 1;
                        idxBnextY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-0) + 4*(xx-1) + 2;
                        idxCnextY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-0) + 4*(xx-1) + 3;
                        idxDnextY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-0) + 4*(xx-1) + 4;
                    else
                        idxAnextY = 0;
                        idxBnextY = 0;
                        idxCnextY = 0;
                        idxDnextY = 0;
                    end

                    if zz>1
                        idxAprevZ = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-1) + 4*(xx-1) + 1;
                        idxBprevZ = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-1) + 4*(xx-1) + 2;
                        idxCprevZ = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-1) + 4*(xx-1) + 3;
                        idxDprevZ = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-1) + 4*(xx-1) + 4;
                    else
                        idxAprevZ = 0;
                        idxBprevZ = 0;
                        idxCprevZ = 0;
                        idxDprevZ = 0;
                    end

                    if zz<nUCz
                        idxAnextZ = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-1) + 4*(xx-1) + 1;
                        idxBnextZ = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-1) + 4*(xx-1) + 2;
                        idxCnextZ = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-1) + 4*(xx-1) + 3;
                        idxDnextZ = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-1) + 4*(xx-1) + 4;
                    else
                        idxAnextZ = 0;
                        idxBnextZ = 0;
                        idxCnextZ = 0;
                        idxDnextZ = 0;
                    end

                    if ww>1
                        idxAprevW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 1;
                        idxBprevW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 2;
                        idxCprevW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 3;
                        idxDprevW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 4;
                    else
                        idxAprevW = 0;
                        idxBprevW = 0;
                        idxCprevW = 0;
                        idxDprevW = 0;
                    end

                    if ww<nUCw
                        idxAnextW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 1;
                        idxBnextW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 2;
                        idxCnextW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 3;
                        idxDnextW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-1) + 4*(xx-1) + 4;
                    else
                        idxAnextW = 0;
                        idxBnextW = 0;
                        idxCnextW = 0;
                        idxDnextW = 0;
                    end

                    if (xx>1) && (yy>1)
                        idxAprevXY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-2) + 4*(xx-2) + 1;
                        idxBprevXY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-2) + 4*(xx-2) + 2;
                        idxCprevXY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-2) + 4*(xx-2) + 3;
                        idxDprevXY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-2) + 4*(xx-2) + 4;
                    else
                        idxAprevXY = 0;
                        idxBprevXY = 0;
                        idxCprevXY = 0;
                        idxDprevXY = 0;
                    end

                    if (xx<nUCx) && (yy<nUCy)
                        idxAnextXY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-0) + 4*(xx-0) + 1;
                        idxBnextXY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-0) + 4*(xx-0) + 2;
                        idxCnextXY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-0) + 4*(xx-0) + 3;
                        idxDnextXY = 4*nUCz*nUCy*nUCx*(ww-1) + 4*nUCy*nUCx*(zz-1) + 4*nUCx*(yy-0) + 4*(xx-0) + 4;
                    else
                        idxAnextXY = 0;
                        idxBnextXY = 0;
                        idxCnextXY = 0;
                        idxDnextXY = 0;
                    end

                    if (zz>1) && (ww>1)
                        idxAprevZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-1) + 4*(xx-1) + 1;
                        idxBprevZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-1) + 4*(xx-1) + 2;
                        idxCprevZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-1) + 4*(xx-1) + 3;
                        idxDprevZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-1) + 4*(xx-1) + 4;
                    else
                        idxAprevZW = 0;
                        idxBprevZW = 0;
                        idxCprevZW = 0;
                        idxDprevZW = 0;
                    end

                    if (zz<nUCz) && (ww<nUCw)
                        idxAnextZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-1) + 4*(xx-1) + 1;
                        idxBnextZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-1) + 4*(xx-1) + 2;
                        idxCnextZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-1) + 4*(xx-1) + 3;
                        idxDnextZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-1) + 4*(xx-1) + 4;
                    else
                        idxAnextZW = 0;
                        idxBnextZW = 0;
                        idxCnextZW = 0;
                        idxDnextZW = 0;
                    end

                    if (xx>1) && (yy>1) && (zz>1) && (ww>1)
                        idxAprevXYZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-2) + 4*(xx-2) + 1;
                        idxBprevXYZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-2) + 4*(xx-2) + 2;
                        idxCprevXYZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-2) + 4*(xx-2) + 3;
                        idxDprevXYZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-2) + 4*(xx-2) + 4;
                    else
                        idxAprevXYZW = 0;
                        idxBprevXYZW = 0;
                        idxCprevXYZW = 0;
                        idxDprevXYZW = 0;
                    end

                    if (xx<nUCx) && (yy<nUCy) && (zz<nUCz) && (ww<nUCw)
                        idxAnextXYZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-0) + 4*(xx-0) + 1;
                        idxBnextXYZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-0) + 4*(xx-0) + 2;
                        idxCnextXYZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-0) + 4*(xx-0) + 3;
                        idxDnextXYZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-0) + 4*(xx-0) + 4;
                    else
                        idxAnextXYZW = 0;
                        idxBnextXYZW = 0;
                        idxCnextXYZW = 0;
                        idxDnextXYZW = 0;
                    end

                    if (xx>1) && (yy>1) && (zz<nUCz) && (ww<nUCw)
                        idxAprevXYnextZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-2) + 4*(xx-2) + 1;
                        idxBprevXYnextZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-2) + 4*(xx-2) + 2;
                        idxCprevXYnextZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-2) + 4*(xx-2) + 3;
                        idxDprevXYnextZW = 4*nUCz*nUCy*nUCx*(ww-0) + 4*nUCy*nUCx*(zz-0) + 4*nUCx*(yy-2) + 4*(xx-2) + 4;
                    else
                        idxAprevXYnextZW = 0;
                        idxBprevXYnextZW = 0;
                        idxCprevXYnextZW = 0;
                        idxDprevXYnextZW = 0;
                    end

                    if (xx<nUCx) && (yy<nUCy) && (zz>1) && (ww>1)
                        idxAnextXYprevZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-0) + 4*(xx-0) + 1;
                        idxBnextXYprevZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-0) + 4*(xx-0) + 2;
                        idxCnextXYprevZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-0) + 4*(xx-0) + 3;
                        idxDnextXYprevZW = 4*nUCz*nUCy*nUCx*(ww-2) + 4*nUCy*nUCx*(zz-2) + 4*nUCx*(yy-0) + 4*(xx-0) + 4;
                    else
                        idxAnextXYprevZW = 0;
                        idxBnextXYprevZW = 0;
                        idxCnextXYprevZW = 0;
                        idxDnextXYprevZW = 0;
                    end


                    %% Which layer?
                    %whichY = mod(yy,2);
                    %whichW = mod(ww,2);

                    %% Define on-site energies:
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxCurA; vHvec(iiH)=+m; iiH=iiH+1;
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxCurB; vHvec(iiH)=+m; iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxCurC; vHvec(iiH)=-m; iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxCurD; vHvec(iiH)=-m; iiH=iiH+1;

                    %% Define within UC couplings:
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxCurD; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxCurA; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxCurC; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxCurA; vHvec(iiH)=-t; iiH=iiH+1;                    
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxCurD; vHvec(iiH)=+t; iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxCurB; vHvec(iiH)=+t; iiH=iiH+1;
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxCurC; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxCurB; vHvec(iiH)=-t; iiH=iiH+1;

                    %% Define between UC couplings:
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxDprevZ; vHvec(iiH)=-t; iiH=iiH+1; %
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxAnextZ; vHvec(iiH)=-t; iiH=iiH+1; %
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxBprevZ; vHvec(iiH)=-t; iiH=iiH+1; %
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxCnextZ; vHvec(iiH)=-t; iiH=iiH+1; %

                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxDnextX; vHvec(iiH)=+t; iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxBprevX; vHvec(iiH)=+t; iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxAnextX; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxCprevX; vHvec(iiH)=-t; iiH=iiH+1;

                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxAnextXY; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxCprevXY; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxDnextXY; vHvec(iiH)=+t; iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxBprevXY; vHvec(iiH)=+t; iiH=iiH+1;

                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxAnextZW; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxDprevZW; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxCnextZW; vHvec(iiH)=-t; iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxBprevZW; vHvec(iiH)=-t; iiH=iiH+1;

                    %% Define topology-setting couplings:
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxAnextXYZW; vHvec(iiH)=-t1; iiH=iiH+1;
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxAprevXYZW; vHvec(iiH)=-conj(t1); iiH=iiH+1;
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxBnextXYZW; vHvec(iiH)=-t1; iiH=iiH+1;
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxBprevXYZW; vHvec(iiH)=-conj(t1); iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxCnextXYZW; vHvec(iiH)=+t1; iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxCprevXYZW; vHvec(iiH)=+conj(t1); iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxDnextXYZW; vHvec(iiH)=+t1; iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxDprevXYZW; vHvec(iiH)=+conj(t1); iiH=iiH+1;

                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxAnextXYprevZW; vHvec(iiH)=-t2; iiH=iiH+1;
                    xHvec(iiH)=idxCurA; yHvec(iiH)=idxAprevXYnextZW; vHvec(iiH)=-conj(t2); iiH=iiH+1;
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxBnextXYprevZW; vHvec(iiH)=-t2; iiH=iiH+1;
                    xHvec(iiH)=idxCurB; yHvec(iiH)=idxBprevXYnextZW; vHvec(iiH)=-conj(t2); iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxCnextXYprevZW; vHvec(iiH)=+t2; iiH=iiH+1;
                    xHvec(iiH)=idxCurC; yHvec(iiH)=idxCprevXYnextZW; vHvec(iiH)=+conj(t2); iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxDnextXYprevZW; vHvec(iiH)=+t2; iiH=iiH+1;
                    xHvec(iiH)=idxCurD; yHvec(iiH)=idxDprevXYnextZW; vHvec(iiH)=+conj(t2); iiH=iiH+1;

                    %% Define position operators:
                    xPvec(iiP) = idxCurA;
                    vXvec(iiP) = (xx-1/2)*a - nUCx*a/2;
                    vYvec(iiP) = (yy-1/2)*a - nUCy*a/2;
                    vZvec(iiP) = (zz-1/2)*a - nUCz*a/2;
                    vWvec(iiP) = (ww-1/2)*a - nUCw*a/2;
                    iiP = iiP+1;

                    xPvec(iiP) = idxCurB;
                    vXvec(iiP) = (xx-1/2)*a - nUCx*a/2;
                    vYvec(iiP) = (yy-1/2)*a - nUCy*a/2;
                    vZvec(iiP) = (zz-1/2)*a - nUCz*a/2;
                    vWvec(iiP) = (ww-1/2)*a - nUCw*a/2;
                    iiP = iiP+1;

                    xPvec(iiP) = idxCurC;
                    vXvec(iiP) = (xx-1/2)*a - nUCx*a/2;
                    vYvec(iiP) = (yy-1/2)*a - nUCy*a/2;
                    vZvec(iiP) = (zz-1/2)*a - nUCz*a/2;
                    vWvec(iiP) = (ww-1/2)*a - nUCw*a/2;
                    iiP = iiP+1;

                    xPvec(iiP) = idxCurD;
                    vXvec(iiP) = (xx-1/2)*a - nUCx*a/2;
                    vYvec(iiP) = (yy-1/2)*a - nUCy*a/2;
                    vZvec(iiP) = (zz-1/2)*a - nUCz*a/2;
                    vWvec(iiP) = (ww-1/2)*a - nUCw*a/2;
                    iiP = iiP+1;
                end
            end
        end
    end

    %% wrapping up:
    xHvec(yHvec==0) = [];
    vHvec(yHvec==0) = [];
    yHvec(yHvec==0) = [];
    HH = sparse(xHvec,yHvec,vHvec,nVals,nVals);
    assert(ishermitian(HH));

    XX = sparse(xPvec,xPvec,vXvec,nVals,nVals);
    YY = sparse(xPvec,xPvec,vYvec,nVals,nVals);
    ZZ = sparse(xPvec,xPvec,vZvec,nVals,nVals);
    WW = sparse(xPvec,xPvec,vWvec,nVals,nVals);
    assert(ishermitian(XX));
    assert(ishermitian(YY));
    assert(ishermitian(ZZ));
    assert(ishermitian(WW));
end