%%%
clc
MINIMO_ERROR = 0.1;

addpath(genpath(mcode))

format long
page_screen_output(0);
page_output_immediately(1);

alfa=1.9;

d0=[-159   ,-159 ,  -159,   -159];
c0=[ 16    ,  8  ,    24,     43];
C =[4.5    ;   2 ;   6.5;   12.3];
h0=246.1523; D=23; Q= 1.3123; f=15; g=109;
X0=[h0;D;Q;f;g];

[X F]=newtonsys (C,X0,MINIMO_ERROR,c0,d0,alfa)
 
h0=X(1)
D=X(2)
Q=X(3) 
f=X(4)
g=X(5)


C=Ffun([h0;D;Q;f,g],c0,d0)
