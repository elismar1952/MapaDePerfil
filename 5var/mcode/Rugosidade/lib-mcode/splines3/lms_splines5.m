function [P XINT]=lms_spline5(X,Y,NPARTS,varargin)


    % Retorna la pendiente al inicio e final
    [X Y W]=check_parameters(X,Y,NPARTS,varargin{:});


    % Retorna Xs datos X por grupos, son NPARTS grupos    
    % Retorna Ys datos Y por grupos, son NPARTS grupos
    % Retorna XINT intervalos de X, son NPARTS grupos
    [Xs Ys XINT Ws]=generate_Xs_Ys_XINT(X,Y,NPARTS,W);

    
    %Yz=Az*p
    [Yz Az Cz]=generate_values_z(Xs,Ys,Ws);


    % 0=A0*p
    [Y0 A0 C0]=generate_values_0(Xs,Ys,Ws,XINT);


    % 0=A1*p
    [Y1 A1 C1]=generate_values_1(Xs,Ys,Ws,XINT);


    % 0=A2*p
    [Y2 A2 C2]=generate_values_2(Xs,Ys,Ws,XINT);

    % 0=A3*p
    [Y3 A3 C3]=generate_values_3(Xs,Ys,Ws,XINT);

    % 0=A4*p
    [Y4 A4 C4]=generate_values_4(Xs,Ys,Ws,XINT);

    %%%%%%%%%%%%%%%%%
    At=[Az;A0;A1;A2;A3;A4];
    Yt=[Yz;Y0;Y1;Y2;Y3;Y4];
    C=diag([Cz*100;C0*100;C1;C2;C3;C4]);


    p=inv(At'*C*At+0.000001*eye(NPARTS*6))*At'*C*Yt;


    % Finalmente convertimos p em P
    P=zeros(NPARTS,6);
    for II=1:NPARTS
        P(II,:)=p( (6*(II-1)+1):(6*(II-1)+6) );
    endfor

endfunction

function [Yz Az Cz]=generate_values_z(Xs,Ys,Ws)

    NPARTS=size(Xs,1);
    N=0;
    for II=1:NPARTS
        N=N+length(Xs{II});
    endfor

    Yz=zeros(N,1);
    Az=zeros(N,NPARTS*6);
    Cz=zeros(N,1);
    
    KK=1;
    for II=1:NPARTS
        NN=length(Xs{II});
 
        for JJ=1:NN
            Yz(KK)=Ys{II}(JJ);
            Cz(KK)=Ws{II}(JJ);

            Az(KK,6*(II-1)+1)=Xs{II}(JJ)^5;
            Az(KK,6*(II-1)+2)=Xs{II}(JJ)^4;
            Az(KK,6*(II-1)+3)=Xs{II}(JJ)^3;
            Az(KK,6*(II-1)+4)=Xs{II}(JJ)^2;
            Az(KK,6*(II-1)+5)=Xs{II}(JJ);
            Az(KK,6*(II-1)+6)=1;

            KK=KK+1;
        endfor
    endfor

endfunction

function [Y0 A0 C0]=generate_values_0(Xs,Ys,Ws,XINT)

    NPARTS=size(Xs,1);

    Y0=zeros(NPARTS-1,1);
    A0=zeros(NPARTS-1,NPARTS*6);
    C0=zeros(NPARTS-1,1);

    for II=1:(NPARTS-1)

        Y0(II)=0;
        C0(II)=sum(Ws{II})+sum(Ws{II+1});

        A0(II,6*(II-1)+ 1)=+XINT(II,2)^5;
        A0(II,6*(II-1)+ 2)=+XINT(II,2)^4;
        A0(II,6*(II-1)+ 3)=+XINT(II,2)^3;
        A0(II,6*(II-1)+ 4)=+XINT(II,2)^2;
        A0(II,6*(II-1)+ 5)=+XINT(II,2);
        A0(II,6*(II-1)+ 6)=+1;

        A0(II,6*(II-1)+ 7)=-XINT(II,2)^5;
        A0(II,6*(II-1)+ 8)=-XINT(II,2)^4;
        A0(II,6*(II-1)+ 9)=-XINT(II,2)^3;
        A0(II,6*(II-1)+10)=-XINT(II,2)^2;
        A0(II,6*(II-1)+11)=-XINT(II,2);
        A0(II,6*(II-1)+12)=-1;

    endfor

endfunction

function [Y1 A1 C1]=generate_values_1(Xs,Ys,Ws,XINT)

    NPARTS=size(Xs,1);

    Y1=zeros(NPARTS-1,1);
    A1=zeros(NPARTS-1,NPARTS*6);
    C1=zeros(NPARTS-1,1);

    for II=1:(NPARTS-1)

        Y1(II)=0;
        C1(II)=sum(Ws{II})+sum(Ws{II+1});

        A1(II,6*(II-1)+ 1)=+5*XINT(II,2)^4;
        A1(II,6*(II-1)+ 2)=+4*XINT(II,2)^3;
        A1(II,6*(II-1)+ 3)=+3*XINT(II,2)^2;
        A1(II,6*(II-1)+ 4)=+2*XINT(II,2);
        A1(II,6*(II-1)+ 5)=+1;
        A1(II,6*(II-1)+ 6)=+0;

        A1(II,6*(II-1)+ 7)=-5*XINT(II,2)^4;
        A1(II,6*(II-1)+ 8)=-4*XINT(II,2)^3;
        A1(II,6*(II-1)+ 9)=-3*XINT(II,2)^2;
        A1(II,6*(II-1)+10)=-2*XINT(II,2);
        A1(II,6*(II-1)+11)=-1;
        A1(II,6*(II-1)+12)=-0;

    endfor

endfunction


function [Y2 A2 C2]=generate_values_2(Xs,Ys,Ws,XINT)

    NPARTS=size(Xs,1);

    Y2=zeros(NPARTS-1,1);
    A2=zeros(NPARTS-1,NPARTS*6);
    C2=zeros(NPARTS-1,1);

    for II=1:(NPARTS-1)

        Y2(II)=0;
        C2(II)=sum(Ws{II})+sum(Ws{II+1});

        A2(II,6*(II-1)+ 1)=+5*4*XINT(II,2)^3;
        A2(II,6*(II-1)+ 2)=+4*3*XINT(II,2)^2;
        A2(II,6*(II-1)+ 3)=+3*2*XINT(II,2);
        A2(II,6*(II-1)+ 4)=+2;
        A2(II,6*(II-1)+ 5)=+0;
        A2(II,6*(II-1)+ 6)=+0;

        A2(II,6*(II-1)+ 7)=-5*4*XINT(II,2)^3;
        A2(II,6*(II-1)+ 8)=-4*3*XINT(II,2)^2;
        A2(II,6*(II-1)+ 9)=-3*2*XINT(II,2);
        A2(II,6*(II-1)+10)=-2;
        A2(II,6*(II-1)+11)=-0;
        A2(II,6*(II-1)+12)=-0;

    endfor

endfunction


function [Y3 A3 C3]=generate_values_3(Xs,Ys,Ws,XINT)

    NPARTS=size(Xs,1);

    Y3=zeros(NPARTS-1,1);
    A3=zeros(NPARTS-1,NPARTS*6);
    C3=zeros(NPARTS-1,1);

    for II=1:(NPARTS-1)

        Y3(II)=0;
        C3(II)=sum(Ws{II})+sum(Ws{II+1});

        A3(II,6*(II-1)+ 1)=+5*4*3*XINT(II,2)^2;
        A3(II,6*(II-1)+ 2)=+4*3*2*XINT(II,2);
        A3(II,6*(II-1)+ 3)=+3*2;
        A3(II,6*(II-1)+ 4)=+0;
        A3(II,6*(II-1)+ 5)=+0;
        A3(II,6*(II-1)+ 6)=+0;

        A3(II,6*(II-1)+ 7)=-5*4*3*XINT(II,2)^2;
        A3(II,6*(II-1)+ 8)=-4*3*2*XINT(II,2);
        A3(II,6*(II-1)+ 9)=-3*2;
        A3(II,6*(II-1)+10)=-0;
        A3(II,6*(II-1)+11)=-0;
        A3(II,6*(II-1)+12)=-0;

    endfor

endfunction

function [Y4 A4 C4]=generate_values_4(Xs,Ys,Ws,XINT)

    NPARTS=size(Xs,1);

    Y4=zeros(NPARTS-1,1);
    A4=zeros(NPARTS-1,NPARTS*6);
    C4=zeros(NPARTS-1,1);

    for II=1:(NPARTS-1)

        Y3(II)=0;
        C3(II)=sum(Ws{II})+sum(Ws{II+1});

        A4(II,6*(II-1)+ 1)=+5*4*3*2*XINT(II,2);
        A4(II,6*(II-1)+ 2)=+4*3*2;
        A4(II,6*(II-1)+ 3)=+0;
        A4(II,6*(II-1)+ 4)=+0;
        A4(II,6*(II-1)+ 5)=+0;
        A4(II,6*(II-1)+ 6)=+0;

        A4(II,6*(II-1)+ 7)=-5*4*3*2*XINT(II,2);
        A4(II,6*(II-1)+ 8)=-4*3*2;
        A4(II,6*(II-1)+ 9)=-0;
        A4(II,6*(II-1)+10)=-0;
        A4(II,6*(II-1)+11)=-0;
        A4(II,6*(II-1)+12)=-0;

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

function [X Y W]=check_parameters(X,Y,NPARTS,varargin)

    if(~isvector(X))
        error('X should be a vector');
    end
    if(~isvector(Y))
        error('Y should be a vector');
    end

    if(length(X)~=length(Y))
        error('The length of X and Y should be equals');
    end

    if(length(X)<(NPARTS+5))
        error(['You need almost ' num2str(NPARTS+5) ' samples of X and Y']);
    end

    if( (size(X,1)==1)&&(size(X,2)~=1) )
        X=X';
    endif

    if( (size(Y,1)==1)&&(size(Y,2)~=1) )
        Y=Y';
    endif

    if(nargin>3)
        W=abs(varargin{1});
    else
        W=ones(size(X));
    end

    [X id]=sort(X);
    Y=Y(id);
    W=W(id);

endfunction
