pro cdpTransit
  restore,'loopdata.sav'
  cgcleanup
  
  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  xVar=cdplwc
  xVar2=lwc
  yVar=cdptrans
  yVar2=0
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  
    
    indsI=where(lwc gt .02 and lwc lt 1.4)
    indsI2=where(cdpconc gt 100. and cdpconc lt 200.)
    indsI3=where(cdpconc gt 200. and cdpconc lt 300.)
    indsI4=where(cdpconc gt 300. and cdpconc lt 400.)
    indsI5=where(cdpconc gt 400. and cdpconc lt 500.)
    indsI6=where(cdpconc gt 500. and cdpconc lt 600.)
    indsI7=where(cdpconc gt 600. and cdpconc lt 700.)
    indsI8=where(cdpconc gt 700. and cdpconc lt 800.)
    
    inds2=cgsetinter(indsI,indsI2)
    inds3=cgsetinter(indsI,indsI3)
    inds4=cgsetinter(indsI,indsI4)
    inds5=cgsetinter(indsI,indsI5)
    inds6=cgsetinter(indsI,indsI6)
    inds7=cgsetinter(indsI,indsI7)
    inds8=cgsetinter(indsI,indsI8)
    

    p1=scatterplot(xVar[indsI]-xvar2[indsI],yVar[indsI]-yVar2[indsI],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=80,sym_size=.5)
;    p1.xrange=[0,300]
    p1.yrange=[0,5]
    
    p3=scatterplot(xVar[inds2]-xvar2[inds2],yVar[inds2]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[1],/overplot)
    p4=scatterplot(xVar[inds3]-xvar2[inds3],yVar[inds3]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[2],/overplot)
    p5=scatterplot(xVar[inds4]-xvar2[inds4],yVar[inds4]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[3],/overplot)
    p6=scatterplot(xVar[inds5]-xvar2[inds5],yVar[inds5]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[4],/overplot)
    p7=scatterplot(xVar[inds6]-xvar2[inds6],yVar[inds6]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[5],/overplot)
    p8=scatterplot(xVar[inds7]-xvar2[inds7],yVar[inds7]-yVar2[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=60,sym_size=.5,sym_color=color[7],/overplot)
    
  stop
end