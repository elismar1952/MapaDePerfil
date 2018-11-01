clc
MINIMO_ERROR = 0.1;

format long
page_screen_output(0);
page_output_immediately(1);

alfa=1.9;

d0=[  -300, -159,  -159, -300, -159, -300, 275];
c0=[ 9    ,  8  ,    24,  22,   43,  17, 31];
C =[2     ;   2 ;   6.5;  6.5; 12.3; 5.75; 6.5];
a1=87; a2=90; a3= 0.03; a4=; a5=; a6=;
X0=[a1;a2;a3;a4;a5;a6];

[X F]=newtonsys (C,X0,MINIMO_ERROR,c0,d0,alfa)
 

      a1=X(1);
      a2=X(2);
      a3=X(3);
      a4=X(4);
      a5=X(5);
      a6=X(6);

C=Ffun([a1;a2;a3;a4;a5;a6],c0,d0)