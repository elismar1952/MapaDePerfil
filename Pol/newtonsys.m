function [XO FvO]=newtonsys(C,xo,tol,c0,d0,alfa)
 
  x=xo;
  MINE=100;
  R=diag([1;1;3;1;3;1]);%% a importacia de cada variavel h0 D Q
  
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
        fprintf(stdout,'   E:%f\th0:%f\tD:%f\tQ:%f\ta:%f\tc0:%f\td0:%f\tC:%f\r',E,x(1),x(2),x(3), x(4), mean(c0),mean(d0),mean(Fv));
      %end
      
      if(E<MINE)
        FvO=Fv;
        MINE=E;
        XO=x;
        %\t por tabe e %f ponto flutuante
        fprintf(stdout,'\n\nMINE:%f\ta1:%f\ta2:%f\ta3:%f\ta:%f\ta4:%f\ta5:%f\ta6:%f\tc0:%f\td0:%f\tC:%f\tD:%f\\n',E,x(1),x(2),x(3),x(4), mean(c0),mean(d0),mean(Fv));
        for jj=1:length(c0)
           fprintf(stdout,'c0:%f\td0:%f\tC:%f\n',c0(jj),d0(jj),Fv(jj));
        endfor
        
        
        save('minvalue.txt','MINE','XO','-ascii');
      endif    
    
      x=x+((Jv')*P*Jv+alfa*R)^(-1)*Jv'*P*(C-Fv);

     % if sum(Fv<0)>0
     %  x=abs(x+0.1*rand(size(x)).*x);
     % end
      
      a1=X(1);
      a2=X(2);
      a3=X(3);
      a4=X(4);
      a5=X(5);
      a6=X(6);
      
   %% h0 esta em pixel
   % if h0<0
   %     h0=-h0;
   %  endif
   %  if h0>800
   %     h0=rand(1)*800;%% Se ultrapassar 100 identificar um ponto aleatorio entre 0 e 100
   %  endif
      
   %   if D<0
   %     D=-D;
   %  endif
   %   if D>100
   %      D=rand(1)*100;%% Se ultrapassar 100 identificar um ponto aleatorio entre 0 e 100
   %  endif
      
   %  if Q>pi/2 
   %      Q=rand(1)*pi/2 ;
   %   endif
   %   if Q<0
   %       Q=-Q;
   %   endif
      
   %    if a<0
   %     a=rand(1)*pi/2;
   %   endif
   %   if a>pi/2
   %     a=rand(1)*pi/2;
   %   endif
      
      x(1)=h0;
      x(2)=D;
      x(3)=Q;
      x(4)=a;
      last_E=E;
      
  endwhile
  
endfunction