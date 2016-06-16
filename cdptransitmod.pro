pro cdpTransitMod
  restore,'loopdata.sav'
  cgcleanup

  cdpLwcDiff=(cdplwc-lwc)/lwc
  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------

  xVar=tas
  xVar2=0
  yVar=cdptrans
  yVar2=0


  filtMain=where(lwc gt .02 and lwc lt 1.3 and cdpconc gt 1.5)
  fu=ladfit(cdpconc,cdptrans)
  subsetVar=fu[0]
  inds=[0,.05,.1,.15,.2,.1,.12,.14,.16]

  xrange=[0,300]
  yrange=[1,5]
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------



  p1=scatterplot(xVar[filtMain],yVar[filtMain],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=82,sym_size=.5)
  p1.xrange=xrange
  p1.yrange=yrange

  for i=0,n_elements(inds)-2 do begin
    inds2B=where(subsetVar gt inds[i] and subsetVar lt inds[i+1])
    inds2=cgsetinter(filtMain,inds2B)
    p3=scatterplot(xVar[inds2],yVar[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=40,sym_size=.5,sym_color=color[i+1],/overplot)

    lin1=ladfit(xVar[inds2],yVar[inds2])
    p4=plot([xrange[0],xrange[1]],[lin1[0],xrange[1]*lin1[1]+lin1[0]],/overplot,color=color[i+1])
  endfor




end