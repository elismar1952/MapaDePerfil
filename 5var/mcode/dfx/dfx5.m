function d5=dfx5(X,c0,d0)
  h0=X(1);
  D=X(2);
  Q=X(3);
  f=X(4);
  g=X(5);
%%d4=D*tan(Q)*(cot(atan(d0/h0)-Q)*csc(atan(h0/(d0+c0))+Q)^2-csc(atan(d0/h0)-Q)^2*cot(atan(h0/(d0+c0))+Q))+D*sec(Q)^2*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q));
%derivada de a
%d5=(D*tan(Q)*csc(a)^2*cot(atan(h0/(d0+c0))+Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)))/(cot(a)*cot(atan(h0/(d0+c0))+Q)+1)^2;

d5=(D*tan(Q)*(-D*tan(Q)*cot(atan(d0/h0)-Q)-f)*cot(atan(h0/(d0+c0))+Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)))/(g^2*(((-D*tan(Q)*cot(atan(d0/h0)-Q)-f)*cot(atan(h0/(d0+c0))+Q))/g+1)^2);
endfunction