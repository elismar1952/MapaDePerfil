function Jv=Jfun(x,c0,d0)
%  Jv(1,1)=dfx1(x,c0(1),d0(1));  Jv(1,2)=dfx2(x,c0(1),d0(1));  Jv(1,3)=dfx3(x,c0(1),d0(1));
%  Jv(2,1)=dfx1(x,c0(2),d0(2));  Jv(2,2)=dfx2(x,c0(2),d0(2));  Jv(2,3)=dfx3(x,c0(2),d0(2));
%  Jv(3,1)=dfx1(x,c0(3),d0(3));  Jv(3,2)=dfx2(x,c0(3),d0(3));  Jv(3,3)=dfx3(x,c0(3),d0(3));

  L=length(c0);
  
  Jv=zeros(L,4);

  
  for II=1:L
    Jv(II,1)=dfx1(x,c0(II),d0(II));  Jv(II,2)=dfx2(x,c0(II),d0(II));  Jv(II,3)=dfx3(x,c0(II),d0(II)); Jv(II,4)=dfx4(x,c0(II),d0(II));bJv(II,5)=dfx5(x,c0(II),d0(II)); Jv(II,6)=dfx6(x,c0(II),d0(II));
  end
endfunction