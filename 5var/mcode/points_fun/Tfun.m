function [B Y C]=Tfun(X,b0,c0,d0)

    if(length(b0)~=length(c0))
        error('length of b0 and c0 are differents!!!!!')
    endif

    if(length(c0)~=length(d0))
        error('length of c0 and d0 are differents!!!!!')
    endif

    B=zeros(size(c0));
    Y=zeros(size(c0));
    C=zeros(size(c0));

    L=length(c0);

    h0=X(1);
    D=X(2);
    Q=X(3);
    f=X(4);
    g=X(5);

    Fv=Ffun(X,c0,d0);

    for II=1:L
        C(II)=Fv(II);
        ftmp=tan(Q)*cot(Q-atan(d0(II)/h0));
        Y(II)=D*(ftmp-1)-C(II)*(D*ftmp-f)/g;
        B(II)=(D*tan(Q)-C(II))*b0(II)/h0;
    end
  
endfunction


