function [B C]=image1linefun(PARAMS,IMG_BIN,IMG_BIN_REF,CUMULUSON,varargin)
    
    if(size(IMG_BIN,1)~=size(IMG_BIN_REF,1))
        error('Differents number of lines in the images');
    end
    
    if(size(IMG_BIN,2)~=size(IMG_BIN_REF,2))
        error('Differents number of columns in the images');
    end


    H=size(IMG_BIN_REF,1);
    W=size(IMG_BIN_REF,2);

    R = LineDetector(IMG_BIN);
    R.set_reconstruction_cumulus_on(CUMULUSON);
    R.set_reconstruction_level(0);
    R.set_reconstruction_parts(24);
    [XLIN YLIN]=R.calculates_curve();

    if(nargin>4)
        OUTPUT=varargin{1};
        plot_data(OUTPUT,'line',IMG_BIN,XLIN,YLIN);
    end


    R = LineDetector(IMG_BIN_REF);
    R.set_reconstruction_cumulus_on(CUMULUSON);
    R.set_reconstruction_level(1);
    R.set_reconstruction_parts(10);
    [XREF YREF]=R.calculates_curve();

    if(nargin>4)
        OUTPUT=varargin{1};
        plot_data(OUTPUT,'ref',IMG_BIN_REF,XREF,YREF);
    end

    d0=H/2-YREF;
    c0=YREF-YLIN;
    b0=XREF-0.5*W;


    [B C]=Tfun(PARAMS,b0,c0,d0);

endfunction

function plot_data(OUTPUT,POSTNAME,IMG_BIN,XLIN,YLIN)
    figure;
    imagesc(IMG_BIN);
    hold on
        plot(XLIN,YLIN);
    hold off
    %colormap(gray)
    mkdir(OUTPUT);
    print(gcf,fullfile(OUTPUT,filesep,['grafico-binario-' POSTNAME '.png']),'-dpng')
endfunction
