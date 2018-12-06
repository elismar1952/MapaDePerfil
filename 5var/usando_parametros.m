%%
clc
addpath(genpath('mcode'))
page_screen_output(0);
page_output_immediately(1);

IMAGEPATH='/home/fernando/MapaDePerfil/povray/line-laser/output/8bit/main1.bmp';
IMG = imread(IMAGEPATH);
IMG_BIN=IMG>0.5;


IMAGEPATH='/home/fernando/MapaDePerfil/povray/line-laser/output/8bit/main0.bmp';
IMG = imread(IMAGEPATH);
IMG_BIN_REF=IMG>0.5;

h0=400; 
D=1.0; 
Q= 60*pi/180; 
f=1.8; 
g=1.8;

PARAMS=[h0;D;Q;f;g];

[B C]=image1linefun(PARAMS,IMG_BIN,IMG_BIN_REF);

figure
plot(B,C,'-o');
print(gcf,'grafico-real.png','-dpng')