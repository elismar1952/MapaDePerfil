function d2=dfx2(X,c0,d0)
  h0=X(1);
  D=X(2);
  Q=X(3);
  a=X(4);
%%d2=tan(Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q));
%derivada de D
d2=(tan(Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)))/(cot(a)*cot(atan(h0/(d0+c0))+Q)+1);

endfunction