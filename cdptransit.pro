pro cdpTransit
  restore,'saves/loopdatacope1hzB.sav'
  cgcleanup
  
  
  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  
  
  
  liq=1
  liqonly=where(cdpconc gt 1 and cdpconc lt 300. and trf gt -3. and lwc lt 1.3)
  
  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpTrans=cdpTrans[liqonly]
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
    cdpacc=cdpacc[liqonly]
    colELiqUP=colELiqUP[liqonly]
    colELiqU=colELiqU[liqonly]
    cdpDofRej=cdpDofRej[liqonly]
    vlwccol=vlwccol[liqonly]
    vtwccol=vtwccol[liqonly]
  endif
  
  cdpLwcDiff=(cdplwc/lwc-1.)*100.
  
  s1=scatterplot(vmd,vtwccol/vlwccol-1.)
  
  xVar=cdpacc
  xVar2=0
  yVar=cdpDofRej
  yVar2=cdpTrans
  
  
  
  ;fu=ladfit(xvar,yVar)
  subsetVar=cdpLwcDiff
  inds=[0,25]
  
  ;xrange=[0,800]
  yrange=[0,6]
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  
    

    p1=scatterplot(xVar,yVar,dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=62,sym_size=.5)
    ;p1=scatterplot(xVar,yVar2,dimensions=[1600,1200],margin=50,/device,/sym_filled,sym_transparency=70,sym_size=.5,/overplot,sym_color='blue')
    ;p1.xrange=xrange
    ;p1.yrange=yrange
    
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