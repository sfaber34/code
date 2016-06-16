pro cdpTransit
  restore,'loopdata.sav'
  cgcleanup
  
  
  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  
  
  
  liq=1
  liqonly=where(lwc gt .02 and cdpconc gt 1 and cdpTransScaled lt 50)
  
  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpTransScaled=cdpTransScaled[liqonly]
    dEff=dEff[liqonly]
    vvd=vvd[liqonly]
    vmd=vmd[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwcVarE=lwcVarE[liqonly]
    twcVarE=twcVarE[liqonly]
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    coleliq=coleliq[liqonly]
    coletot=coletot[liqonly]
    lwcErrColE=lwcErrColE[liqonly]
    cdptrans=cdptrans[liqonly]
    cdpacc=cdpacc[liqonly]
    colELiqUP=colELiqUP[liqonly]
    colELiqU=colELiqU[liqonly]
  endif
  
  cdpLwcDiff=(cdplwc-lwc)/lwc
  
  xVar=cdpconc
  xVar2=0
  yVar=cdpTransScaled
  yVar2=cdpTransScaled
  
  
  
  ;fu=ladfit(xvar,yVar)
  subsetVar=cdpLwcDiff
  inds=[-10000.,0.,10000.]
  
  xrange=[0,500]
  yrange=[1,7]
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  
    

    p1=scatterplot(xVar,yVar,dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=62,sym_size=.5)
    ;p1=scatterplot(xVar,yVar2,dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=70,sym_size=.5,/overplot,sym_color='blue')
    p1.xrange=xrange
    p1.yrange=yrange
    
    xs=dindgen(2000,start=0,increment=1)
    
    for i=0,n_elements(inds)-2 do begin
      inds2=where(subsetVar gt inds[i] and subsetVar lt inds[i+1])
      ;if inds[i] lt 0. then inds2=where(subsetVar lt inds[i] and subsetVar gt inds[i+1])
      
      ;inds2=cgsetinter(filtMain,inds2B)
      p3=scatterplot(xVar[inds2],yVar[inds2],dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=40,sym_size=.5,sym_color=color[i+1],/overplot)
      
      if min(inds2) gt 0 then begin
        lin1=ladfit(xVar[inds2],yVar[inds2])
        p4=plot(xs,xs*lin1[1]+lin1[0],/overplot,color=color[i+1])
      endif
      
    endfor
    

end