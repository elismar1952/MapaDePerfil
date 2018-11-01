function C=datafunction (X,c0,d0)
  h0=X(1);
  D=X(2);
  Q=X(3);
  f=X(4);
  g=X(5);
  
C=(D*tan(Q)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)))/(((-D*tan(Q)*cot(atan(d0/h0)-Q)-f)*cot(atan(h0/(d0+c0))+Q))/g+1);

  endfunction