function [XO FvO]=newtonsys(C,xo,tol,c0,d0,alfa)
 
  x=xo;
  MINE=100;
  R=diag([1;1;3;1;1]);%% a importacia de cada variavel h0 D Q
  
  P=eye(length(C)); %% a importancia de cada dado
  
  XO=x;
  FvO=0*C;
  last_E=-1;
  while MINE>tol

      Jv=Jfun(x,c0,d0);
      while sum(sum(~isfinite(Jv)))>0
        x=abs(x+0.1*rand(size(x)).*x);
        Jv=Jfun(x,c0,d0);
      end
      Fv=Ffun(x,c0,d0);
    
      E=sqrt(mean((Fv-C)'*(Fv-C)));
      
      %if (E>last_E)
      %  fprintf(stdout,'\nE:%f\r',E);
      %else
        fprintf(stdout,'   E:%f\th0:%f\tD:%f\tQ:%f\tf:%f\tg:%f\tc0:%f\td0:%f\tC:%f\r',E,x(1),x(2),x(3), x(4),x(5), mean(c0),mean(d0),mean(Fv));
      %end
      
      if(E<MINE)
        FvO=Fv;
        MINE=E;
        XO=x;
        fprintf(stdout,'\n\nMINE:%f\th0:%f\tD:%f\tQ:%f\tf:%f\tg:%f\tc0:%f\td0:%f\tC:%f\n',E,x(1),x(2),x(3),x(4),x(5), mean(c0),mean(d0),mean(Fv));
        for jj=1:length(c0)
           fprintf(stdout,'c0:%f\td0:%f\tC:%f\n',c0(jj),d0(jj),Fv(jj));
        endfor
        
        
        save('minvalue.txt','MINE','XO','-ascii');
      endif    
    
      x=x+((Jv')*P*Jv+alfa*R)^(-1)*Jv'*P*(C-Fv);

     % if sum(Fv<0)>0
     %  x=abs(x+0.1*rand(size(x)).*x);
     % end
      
      h0=x(1);
      D=x(2);
      Q=x(3);
      f=x(4);
      g=x(5);
      
      %% h0 esta em pixel
      if h0<0
         h0=-h0;
      endif
      if h0>1200
         h0=rand(1)*1200;%% Se ultrapassar 100 identificar um ponto aleatorio entre 0 e 100
      endif
      
      %D nao pode ser menor que 15 
      if D<15% se ele for menor que 15
        D=15+rand(1)*(30-15);%escolha um valor entre 15 e 30
      end
      %D nao pode ultrapassar 30
      if D>30 %se ele ultrapassar 30
        D=15+rand(1)*(30-15);%escolha um valor entre 15 e 30
      end
         
           
      if Q<0.8
        Q=0.8+rand(1)*(1.5-0.8) ;
      endif
      if Q>1.5
         Q=0.8+rand(1)*(1.5-0.8) ;
      endif
      
      if f<5
        f=5+rand(1)*(15-5) ;
      endif
      if f>15
         f=5+rand(1)*(15-5) ;
      endif
      
      
      if g<80
        g=90+rand(1)*(130-90) ;
      endif
      if g>130
         g=90+rand(1)*(130-90) ;
      endif
      
      
      
      
      
      x(1)=h0;
      x(2)=D;
      x(3)=Q;
      x(4)=f;
      x(5)=g;
      last_E=E;
      
  endwhile
  
endfunction