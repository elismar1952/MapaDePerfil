function plot_all_results(IMAGEPATH,IMG_BIN,XREF,YREF,X,Y)
    IMG = imread(IMAGEPATH);

    %image(IMG)
    %hold on
    %    plot(X,Y,'-s');
    %hold off
    %hold on
    %    plot(XREF,YREF,'-o');
    %hold off

    %print(gcf,'grafico-real.png','-dpng')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    figure;
    imagesc(IMG_BIN)
    hold on
        plot(X,Y,'-s');
    hold off
    hold on
        plot(XREF,YREF,'-o');
    hold off
    %colormap(gray)
    print(gcf,'grafico-binario.png','-dpng')


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    MINY=round(min(Y));
    MAXY=round(max(Y));

    NMAXY=round(MAXY+abs(MAXY-MINY)*0.333);
    NMINY=round(MINY-abs(MAXY-MINY)*0.333);
    if NMAXY<=size(IMG_BIN,1);
        MAXY=NMAXY;    
    end
    if NMINY>=1;
        MINY=NMINY;    
    end

    imagesc(IMG_BIN(MINY:MAXY,:))
    hold on
        plot(X,Y-MINY+1,'-s');
    hold off
    hold on
        plot(XREF,YREF-MINY+1,'-o');
    hold off
    %colormap(gray)
    print(gcf,'grafico-binario-zoom.png','-dpng')

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    plot(XREF,(YREF-Y),'-o')
    grid minor
    print(gcf,'grafico-objetos.png','-dpng')

endfunction
