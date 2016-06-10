pro histogram2

  restore,'loopdata.sav'
  
  
  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  

  ;liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and vmd lt 40.)
  liqOnly=where(lwc gt 0.02)




  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
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
  endif



  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  var=cdptrans
  xinc=.25
  xstart=0.
  liq=1
  ;binsize=50.
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------


  h1=histogram(var,min=xstart,binsize=xinc)
  
  p1=barplot(dindgen(n_elements(h1),start=xstart,increment=xinc),h1,histogram=1,dimensions=[1600,1200],margin=[110,70,30,20],/device)
  
  p1.xtitle='CDP Concentration liter-1'
  p1.ytitle='Frequency'
  ;p1.xtickinterval=100
  p1.xminor=0
  ;p1.xrange=[0,1200]
  ;p1.ytickinterval=50  
  
  p1.font_size=22
  p1.save,'concFreq.jpg'
end