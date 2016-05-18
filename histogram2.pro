pro histogram2


  liq=1

  binsize=1.
  
  restore,'loopdata.sav'

  ;liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and vmd lt 40.)
  liqOnly=where(lwc gt 0.05 and twc gt 0.05 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt 100.)




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
  endif



  ;----------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------
  var=vmd
  xinc=1.
  xstart=2.
  ;----------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------




  h1=histogram(var,min=xstart,binsize=xinc)
  
  p1=barplot(dindgen(n_elements(h1),start=xstart,increment=xinc),h1,histogram=1,dimensions=[1600,1200],margin=[110,70,30,20],/device)
  
  p1.xtitle='VMD um'
  p1.ytitle='Frequency'
  
  p1.font_size=22

end