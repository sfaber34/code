pro cdpTransit
  restore,'loopdata.sav'
  cgcleanup
  
  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  xVar=lwc
  yVar=cdpDofRej
  yVar2=0.
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  
    
    indsI=where(cdpconc gt 1. and cdpconc lt 1000. and cdptrans lt 200. and lwc gt 0.02 and lwc lt 1.4)
    indsI2=where(lwc gt 0.02 and lwc lt .2)
    indsI3=where(lwc gt 0.2 and lwc lt .4)
    indsI4=where(lwc gt 0.4 and lwc lt .6)
    indsI5=where(lwc gt 0.6 and lwc lt .8)
    indsI6=where(lwc gt 0.8 and lwc lt 1.)
    indsI7=where(lwc gt 1. and lwc lt 1.2)
    indsI8=where(lwc gt 1.2 and lwc lt 1.4)
    
    inds2=cgsetinter(indsI,indsI2)
    inds3=cgsetinter(indsI,indsI3)
    inds4=cgsetinter(indsI,indsI4)
    inds5=cgsetinter(indsI,indsI5)
    inds6=cgsetinter(indsI,indsI6)
    inds7=cgsetinter(indsI,indsI7)
    inds8=cgsetinter(indsI,indsI8)
    

    p1=scatterplot(xVar,yVar,dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=80,sym_size=.5)
;    p1.xrange=[0,300]
    ;p1.yrange=[0,200]
    
    p3=scatterplot(xVar[inds2],yVar[inds2]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[1],/overplot)
    p4=scatterplot(xVar[inds3],yVar[inds3]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[2],/overplot)
    p5=scatterplot(xVar[inds4],yVar[inds4]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[3],/overplot)
    p6=scatterplot(xVar[inds5],yVar[inds5]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[4],/overplot)
    p7=scatterplot(xVar[inds6],yVar[inds6]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[5],/overplot)
    p8=scatterplot(xVar[inds7],yVar[inds7]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[7],/overplot)
    
  stop
end