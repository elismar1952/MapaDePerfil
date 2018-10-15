function d3=dfx3(X,c0,d0)
  h0=X(1);
  D=X(2);
  Q=X(3);
  a=X(4);
%%d3=D*tan(Q)*(cot(atan(d0/h0)-Q)*csc(atan(h0/(d0+c0))+Q)^2-csc(atan(d0/h0)-Q)^2*cot(atan(h0/(d0+c0))+Q))+D*sec(Q)^2*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q));
%derivada de Q
d3=(D*tan(Q)*(cot(atan(d0/h0)-Q)*csc(atan(h0/(d0+c0))+Q)^2-csc(atan(d0/h0)-Q)^2*cot(atan(h0/(d0+c0))+Q)))/(cot(a)*cot(atan(h0/(d0+c0))+Q)+1)+(D*tan(Q)*cot(a)*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q))*csc(atan(h0/(d0+c0))+Q)^2)/(cot(a)*cot(atan(h0/(d0+c0))+Q)+1)^2+(D*sec(Q)^2*(1-cot(atan(d0/h0)-Q)*cot(atan(h0/(d0+c0))+Q)))/(cot(a)*cot(atan(h0/(d0+c0))+Q)+1);

endfunction