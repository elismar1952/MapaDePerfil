function [B C]=image1linefun(PARAMS,IMG_BIN,IMG_BIN_REF)
    
    if(size(IMG_BIN,1)~=size(IMG_BIN_REF,1))
        error('Differents number of lines in the images');
    end
    
    if(size(IMG_BIN,2)~=size(IMG_BIN_REF,2))
        error('Differents number of columns in the images');
    end

    H=size(IMG_BIN_REF,1);
    W=size(IMG_BIN_REF,2);

    R = LineDetector(IMG_BIN);
    R.set_reconstruction_parts(20);
    [XLIN YLIN]=R.calculates_curve();
  

    R = LineDetector(IMG_BIN_REF);
    R.set_reconstruction_parts(20);
    [XREF YREF]=R.calculates_curve();

    d0=H/2-YREF;
    c0=YREF-YLIN;
    b0=XREF-0.5*W;

    figure;
    imagesc(IMG_BIN_REF)
    hold on
        plot(XLIN,YLIN,'-s');
    hold off
    hold on
        plot(XREF,YREF,'-o');
    hold off
    %colormap(gray)
    print(gcf,'grafico-binario.png','-dpng')

    [B C]=Tfun(PARAMS,b0,c0,d0);

endfunction
