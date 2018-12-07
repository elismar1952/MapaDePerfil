function [P XINT]=lms_splines3(X,Y,NPARTS,varargin)


    % Lee y ordena parametros de entrada
    % W es el peso de (X,Y)
    % LEVEL es si se usara continuidade de 0, 1 o 2 derivada
    [X Y W LEVEL]=check_parameters(X,Y,NPARTS,varargin{:});

    % Agrupa en intervalos XINT
    % Retorna Xs datos X por grupos, son NPARTS grupos    
    % Retorna Ys datos Y por grupos, son NPARTS grupos
    % Retorna XINT intervalos de X, son NPARTS grupos
    [Xs Ys XINT Ws]=generate_Xs_Ys_XINT(X,Y,NPARTS,W);

    
    %% Equacion de todos os pontos
    %Yz=Az*p
    [Yz Az Cz]=generate_values_z(Xs,Ys,Ws);

    %% Equacion de continuidad de polinomios (LEVEL 0)
    % 0=A0*p
    [Y0 A0 C0]=generate_values_0(Xs,Ys,Ws,XINT);

    %% Equacion de continuidad de polinomios en la primera derivada (LEVEL 1)
    % 0=A1*p
    [Y1 A1 C1]=generate_values_1(Xs,Ys,Ws,XINT);

    %% Equacion de continuidad de polinomios en la segunda derivada (LEVEL 2)
    % 0=A2*p
    [Y2 A2 C2]=generate_values_2(Xs,Ys,Ws,XINT);

    %%%%%%%%%%%%%%%%%
    At=[Az;A0;A1;A2];
    Yt=[Yz;Y0;Y1;Y2];
    if     (LEVEL==2)
        C=diag([Cz;C0;C1;C2]);
    elseif (LEVEL==1)
        C=diag([Cz;C0;C1;0*C2]);
    elseif (LEVEL==0)
        C=diag([Cz;C0;0*C1;0*C2]);
    else
        C=diag([Cz;C0;C1;C2]);
    end

    p=inv(At'*C*At)*At'*C*Yt;
    EE=sqrt(meansq(Yt-At*p));
    pmin=p;
    EEmin=EE;

    E=100;
    ITER=0;
    disp('SOLVING LMS CUBIC SPLINES: Please wait ...');
    while (E>=0.01)&&(ITER<3000)
        plast=p;
        p=p+inv(At'*C*At+0.00001*eye(length(p)))*At'*C*(Yt-At*p);

        E=100*max(abs(p-plast))/min(abs(p(abs(p) > 0)));% mean(abs(p));

        EEtmp=sqrt(meansq(Yt-At*p));     
        EE=[EE EEtmp];
        if(EEtmp<EEmin)
            EEmin=EEtmp;
            pmin=p;
        end

        ITER=ITER+1;
    end

    %figure;
    %plot(EE,'-o');
    %xlabel('Iterations');
    %ylabel('Error');

    disp(['SOLVED LMS CUBIC SPLINES, ITERATIONS: '  num2str(ITER)]);


    % Finalmente convertimos p em P
    P=zeros(NPARTS,4);
    for II=1:NPARTS
        P(II,:)=pmin( (4*(II-1)+1):(4*(II-1)+4) );
    endfor

endfunction

function [Yz Az Cz]=generate_values_z(Xs,Ys,Ws)

    NPARTS=size(Xs,1);
    N=0;
    for II=1:NPARTS
        N=N+length(Xs{II});
    endfor

    Yz=zeros(N,1);
    Az=zeros(N,NPARTS*4);
    Cz=zeros(N,1);
    
    KK=1;
    for II=1:NPARTS
        NN=length(Xs{II});
 
        for JJ=1:NN
            Yz(KK)=Ys{II}(JJ);
            Cz(KK)=Ws{II}(JJ);

            Az(KK,4*(II-1)+1)=Xs{II}(JJ)^3;
            Az(KK,4*(II-1)+2)=Xs{II}(JJ)^2;
            Az(KK,4*(II-1)+3)=Xs{II}(JJ);
            Az(KK,4*(II-1)+4)=1;

            KK=KK+1;
        endfor
    endfor

endfunction

function [Y0 A0 C0]=generate_values_0(Xs,Ys,Ws,XINT)

    NPARTS=size(Xs,1);

    Y0=zeros(NPARTS-1,1);
    A0=zeros(NPARTS-1,NPARTS*4);
    C0=zeros(NPARTS-1,1);

    for II=1:(NPARTS-1)

        Y0(II)=0;
        C0(II)=(sum(Ws{II})+sum(Ws{II+1}))/2;

        A0(II,4*(II-1)+1)=XINT(II,2)^3;
        A0(II,4*(II-1)+2)=XINT(II,2)^2;
        A0(II,4*(II-1)+3)=XINT(II,2);
        A0(II,4*(II-1)+4)=1;

        A0(II,4*(II-1)+5)=-XINT(II,2)^3;
        A0(II,4*(II-1)+6)=-XINT(II,2)^2;
        A0(II,4*(II-1)+7)=-XINT(II,2);
        A0(II,4*(II-1)+8)=-1;

    endfor

endfunction

function [Y1 A1 C1]=generate_values_1(Xs,Ys,Ws,XINT)

    NPARTS=size(Xs,1);

    Y1=zeros(NPARTS-1,1);
    A1=zeros(NPARTS-1,NPARTS*4);
    C1=zeros(NPARTS-1,1);

    for II=1:(NPARTS-1)

        Y1(II)=0;
        C1(II)=(sum(Ws{II})+sum(Ws{II+1}))/2;

        A1(II,4*(II-1)+1)=3*XINT(II,2)^2;
        A1(II,4*(II-1)+2)=2*XINT(II,2);
        A1(II,4*(II-1)+3)=1;
        A1(II,4*(II-1)+4)=0;

        A1(II,4*(II-1)+5)=-3*XINT(II,2)^2;
        A1(II,4*(II-1)+6)=-2*XINT(II,2);
        A1(II,4*(II-1)+7)=-1;
        A1(II,4*(II-1)+8)=0;

    endfor

endfunction


function [Y2 A2 C2]=generate_values_2(Xs,Ys,Ws,XINT)

    NPARTS=size(Xs,1);

    Y2=zeros(NPARTS-1,1);
    A2=zeros(NPARTS-1,NPARTS*4);
    C2=zeros(NPARTS-1,1);

    for II=1:(NPARTS-1)

        Y2(II)=0;
        C2(II)=(sum(Ws{II})+sum(Ws{II+1}))/2;

        A2(II,4*(II-1)+1)=6*XINT(II,2);
        A2(II,4*(II-1)+2)=2;
        A2(II,4*(II-1)+3)=0;
        A2(II,4*(II-1)+4)=0;

        A2(II,4*(II-1)+5)=-6*XINT(II,2);
        A2(II,4*(II-1)+6)=-2;
        A2(II,4*(II-1)+7)=0;
        A2(II,4*(II-1)+8)=0;

    endfor

endfunction

function [Xs Ys XINT Ws]=generate_Xs_Ys_XINT(X,Y,NPARTS,W)


    XINT=zeros(NPARTS,2);
    MINX=min(X);
    MAXX=max(X);

    Xpart=linspace(MINX,MAXX,NPARTS+1);

    Xs  =cell(NPARTS,1);
    Ys  =cell(NPARTS,1);
    Ws  =cell(NPARTS,1);
    
    N=length(X);

    for II=1:NPARTS
        XINT(II,1)=Xpart(II);
        XINT(II,2)=Xpart(II+1);

        for JJ=1:N
            if( (X(JJ)>=XINT(II,1)) && (X(JJ)<=XINT(II,2)) )
                Xs{II}=[Xs{II} X(JJ)];
                Ys{II}=[Ys{II} Y(JJ)];
                Ws{II}=[Ws{II} W(JJ)];
            end
        end

    endfor
endfunction

function [X Y W LEVEL]=check_parameters(X,Y,NPARTS,varargin)

    if(~isvector(X))
        error('X should be a vector');
    end
    if(~isvector(Y))
        error('Y should be a vector');
    end

    if(length(X)~=length(Y))
        error('The length of X and Y should be equals');
    end

    if(length(X)<(NPARTS+3))
        error(['You need almost ' num2str(NPARTS+3) ' samples of X and Y']);
    end

    if( (size(X,1)==1)&&(size(X,2)~=1) )
        X=X';
    endif

    if( (size(Y,1)==1)&&(size(Y,2)~=1) )
        Y=Y';
    endif

    E=0;

    if(nargin>3)
        W=abs(varargin{1});
    else
        W=ones(size(X));
    end

    if(nargin>4)
        if((1<=varargin{2})&&(varargin{2}<=2))
            LEVEL=round(varargin{2});
        else
            LEVEL=2;
        end
    else
        LEVEL=2;
    end

    [X id]=sort(X);
    Y=Y(id);
    W=W(id);

endfunction
