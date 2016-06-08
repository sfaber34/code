pro cdpTransit
  restore,'loopdata.sav'
    
    inds=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 0.02 and lwc lt 1.4)
    inds2=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 0.02 and lwc lt .2)
    inds3=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 0.2 and lwc lt .4)
    inds4=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 0.4 and lwc lt .6)
    inds5=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 0.6 and lwc lt .8)
    inds6=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 0.8 and lwc lt 1.)
    inds7=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 1. and lwc lt 1.2)
    inds8=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 1.2 and lwc lt 1.4)
    

    p1=scatterplot(cdpconc[inds],cdptrans[inds],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=90,sym_size=.5)
;    p1.xrange=[0,200]
    
    p3=scatterplot(cdpconc[inds2],cdptrans[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=30,sym_size=.5,sym_color=color[1],/overplot)
    p4=scatterplot(cdpconc[inds3],cdptrans[inds3],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=30,sym_size=.5,sym_color=color[2],/overplot)
    p5=scatterplot(cdpconc[inds4],cdptrans[inds4],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=30,sym_size=.5,sym_color=color[3],/overplot)
    p6=scatterplot(cdpconc[inds5],cdptrans[inds5],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=30,sym_size=.5,sym_color=color[4],/overplot)
    p7=scatterplot(cdpconc[inds6],cdptrans[inds6],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=30,sym_size=.5,sym_color=color[5],/overplot)
    p8=scatterplot(cdpconc[inds7],cdptrans[inds7],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=30,sym_size=.5,sym_color=color[6],/overplot)
    
  stop
end