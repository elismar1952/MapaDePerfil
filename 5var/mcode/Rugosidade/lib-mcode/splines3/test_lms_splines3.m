%
close all
clear

N=1500;
X=round(400*rand(N,1));

for II=1:N
Y(II)=(X(II)-100).*(X(II)-200).*(X(II)-300)/40000 +200+40*(rand(1)-0.5);
endfor
[X id]=sort(X);
X=X/400;
Y=Y(id);

Y(600:1000)=Y(600:1000)+40;

figure;
plot(X,Y,'.')


NPARTS=6*3;
[P XINT]=lms_splines3(X,Y,NPARTS);

M=20;
for II=1:NPARTS
    x(:,II)=linspace(XINT(II,1),XINT(II,2),M);
    y(:,II)=polyval(P(II,:),x(:,II));
endfor


figure;
plot(X,Y,'.',x,y,'-s');
xlabel('x')
ylabel('y')
print(gcf,'splines3demo.eps','-depsc');


