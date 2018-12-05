% Dado Una imagen binaria calcula un conjunto de polinomios con menor error LMS, 
% por tramos usando polinomios de grado L dividiento la curva en partes NPARTS. retorna 
% dos vectores optimos XOPT e YOPT.
        function [XOPT YOPT] = curve_lms_poly_spline(IMG_BIN,L,NPARTS)

            XOPT=0; 
            YOPT=0;
            NCOL=size(IMG_BIN,2);


            %% obtenndo unos (XS,YS)
            disp('Obtendo unos (XS,YS) ...');
            [YS,XS] = find(IMG_BIN);

            %% obtend pesos de uns WS
            disp('Obtendo cumulos (WS) ...');
            C = Cumulus(IMG_BIN);
            [MAP ID WID]= C.calculate_cumulus();
            MAXWID=max(WID(2:end));
            WS=zeros(size(XS));
            N=length(WS);
            for II=1:N
                WS(II)=WID(MAP(YS(II),XS(II))+1)/MAXWID;
            endfor

            %% obtenndo polinomios para os intervalos (XS)
            disp('Obtendo Splines 3r ordem (P,XINT) ...');
            [P XINT]=lms_splines3(XS/NCOL,YS,NPARTS,WS);
    
            %% Avaliando polinomios no intervalos
            disp('Avaliando Splines 3r ordem (P,XINT) ...');
            XOPT=[1:NCOL];
            YOPT = eval_splines(P,XINT,XOPT/NCOL);

            %YMAX=size(IMG_BIN,1);
            %id=find(YOPT>YMAX);
            %YOPT(id)=0*id+YMAX;


            %id=find(YOPT<1);
            %YOPT(id)=0*id+1;
        
        end



