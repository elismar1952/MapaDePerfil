clc
MINIMO_ERROR = 0.1;

format long
page_screen_output(0);
page_output_immediately(1);

alfa=1.9;

d0=[  -300, -159,  -159, -300, -159, -300, 275];
c0=[ 9    ,  8  ,    24,  22,   43,  17, 31];
C =[2     ;   2 ;   6.5;  6.5; 12.3; 5.75; 6.5];
h0=246.1523; D=99; Q= 0.45; a=pi/4;
X0=[h0;D;Q;a];

[X F]=newtonsys (C,X0,MINIMO_ERROR,c0,d0,alfa)
 
h0=X(1)
D=X(2)
Q=X(3) 
a=X(4)


C=Ffun([h0;D;Q;a],c0,d0)