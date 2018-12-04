function d2=dfx2(X,c0,d0)
  h0=X(1);
  D=X(2);
  Q=X(3);
  f=X(4);
  g=X(5);
%%d2=tan(Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q));
%derivada de D
%d2=(tan(Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)))/(cot(a)*cot(atan(h0/(d0+c0))+Q)+1);

d2=(tan(Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)))/(((-D*tan(Q)*cot(atan(d0/h0)-Q)-f)*cot(atan(h0/(d0+c0))+Q))/g+1)+(D*tan(Q)^2*cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)))/(g*(((-D*tan(Q)*cot(atan(d0/h0)-Q)-f)*cot(atan(h0/(d0+c0))+Q))/g+1)^2);
endfunction