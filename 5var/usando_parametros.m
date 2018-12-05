%%
clc
addpath(genpath('mcode'))
page_screen_output(0);
page_output_immediately(1);

h0=246.1523; 
D=23; 
Q= 1.3123; 
f=15; 
g=109;

PARAMS=[h0;D;Q;f;g];

[B C]=image1linefun(PARAMS,IMG_BIN,IMG_BIN_REF);

plot(B,C,'-o');
