%
classdef Cumulus  < handle
    properties
        IMG_BIN
        GMAP
        MAX_GMAP
    end


    methods (Access = public)
        %% PUBLIC
        %% Constructor carrega IMG e cria IMG_BIN desde IMG
        function obj = Cumulus(BINARY_MATRIX)

            obj.IMG_BIN=BINARY_MATRIX;


            obj.GMAP=0*obj.IMG_BIN;
            obj.MAX_GMAP=0;
        end

        function [MAP ID W]= calculate_cumulus(obj)
            NLIN=size(obj.GMAP,1);
            NCOL=size(obj.GMAP,2);  

            %obteng primera linea
            LMAP=obj.get_local_cumulus_map(obj.IMG_BIN(:,1));
            obj.GMAP(:,1)=LMAP;
            obj.MAX_GMAP=max(LMAP);

            % obtengo las demas lineas
            for II=2:NCOL
                obj.get_global_cumulus_map(II,obj.IMG_BIN(:,II));
                fprintf(stdout,'Analizing column %d de %d\r',II,NCOL);
            endfor
            fprintf(stdout,'Analizing column %d de %d\r',NCOL,NCOL);

            % Creo MAP
            MAP=obj.GMAP;

            % Creo ID 
            ID=[0:obj.MAX_GMAP];

            % Creo W
            W=zeros(size(ID));
            for LIN=1:NLIN
            for COL=1:NCOL
                W(obj.GMAP(LIN,COL)+1)=W(obj.GMAP(LIN,COL)+1)+1;
            endfor
            endfor
        endfunction
    end


    methods (Access = private)
        %% retorna los cumulos formados por numeros diferentes de 0 en un vector binaio V
        %% cumulos formados por 0s tienen ID=0.
        %% cumulos formados por 1s tienen ID entero mayor a cero.
        function [LMAP]=get_local_cumulus_map(obj,V)
            N=length(V);
            LMAP=zeros(size(V));

            VEC_ID=1;
            CUM_II=1;
            while VEC_ID<=N
                %% cuento el elemento zero
                while ( (VEC_ID<=N) && (V(VEC_ID)==0) )
                    LMAP(VEC_ID)=0;
                    VEC_ID=VEC_ID+1;
                endwhile
                
                %% Encuentro el VEC_ID do centro
                while ( (VEC_ID<=N) && (V(VEC_ID)!=0) )
                    LMAP(VEC_ID)=CUM_II;
                    VEC_ID=VEC_ID+1;
                endwhile

                CUM_II=CUM_II+1;
            endwhile
        endfunction
        
        function change_values(obj,A,B,COLEND)
            NLIN=size(obj.GMAP,1);

            for COL=1:COLEND
            for LIN=1:NLIN
                if(obj.GMAP(LIN,COL)==B)
                    obj.GMAP(LIN,COL)=A;
                endif                
            endfor
            endfor
        endfunction


        %% Comapara dos vectores de cumulos, 
        %% uno de la columna anterior con ID globales, y
        %% uno de la columna actual con ID locales a la columna.
        %% La funcion transforma los ID locales a globales en la columna y
        %% retorna este nuevo vector.
        %% En algunas ocaciones encontrará un ID local que pertenece a 2
        %% ID globales, en este caso se invoca a una funcion que normaliza
        %% esos 2 ID diferentes a uno solo. Por este motivo al final pueden
        %% existir IDs no consecutivos.
        function get_global_cumulus_map(obj,COL,V)
            N=length(V);

            JJ=1;
            while JJ<=N
                %% cuento el elemento zero
                while ( (JJ<=N) && (V(JJ)==0) )
                    obj.GMAP(JJ,COL)=0;
                    JJ=JJ+1;
                endwhile
                
                %% Encuentro el numero de elementos L
                %% y retorno el mapa de valores del antiguo cumulo CUMULOMAP.
                L=0;
                INIT=JJ;
                while ( (JJ<=N) && (V(JJ)!=0) )
                    L=L+1;
                    JJ=JJ+1;
                endwhile

                if(L>0)
                    %% Obteng ID maps diferentes de cero para el cumulo
                    CUMULOMAP=unique(obj.GMAP(INIT:(INIT+L-1),COL-1),'first');
                    CUMULOMAP = CUMULOMAP(CUMULOMAP~=0);

                    if(length(CUMULOMAP)==0)
                        obj.MAX_GMAP=obj.MAX_GMAP+1;
                        obj.GMAP(INIT:(INIT+L-1),COL)=obj.MAX_GMAP;
                    elseif(length(CUMULOMAP)==1)
                        obj.GMAP(INIT:(INIT+L-1),COL)=CUMULOMAP(1);
                    else
                        for KK=2:length(CUMULOMAP)
                            obj.change_values(CUMULOMAP(1),CUMULOMAP(KK),COL-1);
                        endfor
                        obj.GMAP(INIT:(INIT+L-1),COL)=CUMULOMAP(1);
                    endif
                endif
            endwhile

        endfunction

    endmethods
endclassdef
