function [B C]=image1linefun(x,IMG_BIN,IMG_BIN_REF)
    
    if(size(IMG_BIN,1)==size(IMG_BIN_REF,1))
        error('Differents number of lines in the images');
    end
    
    if(size(IMG_BIN,2)==size(IMG_BIN_REF,2))
        error('Differents number of columns in the images');
    end


    R = LineDetector(IMG_BIN);
    R.set_reconstruction_parts(14);
    [XLIN YLIN]=R.calculates_curve();

    R = LineDetector(IMG_BIN_REF);
    R.set_reconstruction_parts(14);
    [XREF YREF]=R.calculates_curve();

    d0=YREF;
    c0=YLIN-YREF;
    b0=XREF-0.5*(min(XREF)+max(XREF));

    [B C]=Tfun(X,b0,c0,d0);

endfunction
