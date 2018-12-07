% Dado Una imagen binaria calcula un conjunto de polinomios con menor error LMS, 
% por tramos usando polinomios de grado L dividiento la curva en partes NPARTS. retorna 
% dos vectores optimos XOPT e YOPT.
        function [XOPT YOPT] = curve_lms_poly_spline(IMG_BIN,L,NPARTS,varargin)

            XOPT=0; 
            YOPT=0;
            NCOL=size(IMG_BIN,2);

            CUMULUSON=false;
            if(nargin>3)
                CUMULUSON=varargin{1};
            end

            LEVEL=1;
            if(nargin>4)
                LEVEL=varargin{2};
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% obtenndo unos (XS,YS)
            disp('Obtendo unos (XS,YS) ...');
            [YS,XS] = find(IMG_BIN);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% obtend pesos de uns WS
            WS=zeros(size(XS));
            N=length(WS);
            if(CUMULUSON==true)
                disp('Obtendo cumulos (WS) ...');
                C = Cumulus(IMG_BIN);
                [MAP ID WID]= C.calculate_cumulus();
                MAXWID=max(WID(2:end));
                for II=1:N
                    WS(II)=WID(MAP(YS(II),XS(II))+1)/MAXWID;
                endfor
            else
                for II=1:N
                    WS(II)=1.0;
                endfor
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% obtenndo polinomios para os intervalos (XS)
            disp('Obtendo Splines 3r ordem (P,XINT) ...');
            [P XINT]=lms_splines3(XS/NCOL,YS,NPARTS,WS,LEVEL);
    
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Avaliando polinomios no intervalos
            disp('Avaliando Splines 3r ordem (P,XINT) ...');
            XOPT=[1:NCOL];
            YOPT = eval_splines(P,XINT,XOPT/NCOL);
        
        end



