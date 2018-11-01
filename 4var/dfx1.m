function d1=dfx1(X,c0,d0)
  h0=X(1);
  D=X(2);
  Q=X(3);
  a=X(4);
%d1=((cot(atan(d0/h0)-Q)*csc(atan(h0/(d0+c0))+Q)^2)/((d0+c0)*(h0^2/(d0+c0)^2+1))-(d0*csc(atan(d0/h0)-Q)^2*cot(atan(h0/(d0+c0))+Q))/((d0^2/h0^2+1)*h0^2));
%%Derivada de h0
d1=(D*tan(Q)*((cot(atan(d0/h0)-Q)*csc(atan(h0/(d0+c0))+Q)^2)/((d0+c0)*(h0^2/(d0+c0)^2+1))-(d0*csc(atan(d0/h0)-Q)^2*cot(atan(h0/(d0+c0))+Q))/((d0^2/h0^2+1)*h0^2)))/(cot(a)*cot(atan(h0/(d0+c0))+Q)+1)+(D*tan(Q)*cot(a)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q))*csc(atan(h0/(d0+c0))+Q)^2)/((d0+c0)*(h0^2/(d0+c0)^2+1)*(cot(a)*cot(atan(h0/(d0+c0))+Q)+1)^2);
endfunction