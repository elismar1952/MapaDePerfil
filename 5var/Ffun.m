% x=[h0;D;Q]=[477.223662 96.912588 1.249643];
% c0
% d0
function Fv=Ffun(x,c0,d0)
%  Fv(1,1)=datafunction(x,c0(1),d0(1));
%  Fv(2,1)=datafunction(x,c0(2),d0(2));
%  Fv(3,1)=datafunction(x,c0(3),d0(3));

  L=length(c0);

  Fv=zeros(L,1);

  
  for II=1:L
  Fv(II)=datafunction(x,c0(II),d0(II));
  end
  
endfunction