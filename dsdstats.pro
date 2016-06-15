pro dsdStats
  restore,'loopdata.sav'
  
  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------


  ;liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and vmd lt 40.)
  liqOnly=where(lwc gt 0.02 and lwc lt 1.3 and trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt .1)




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
    cdpacc=cdpacc[liqonly]
    cdpbinvar=cdpbinvar[liqonly]
    cdpbinkert=cdpbinkert[liqonly]
    cdpbinskew=cdpbinskew[liqonly]
    cdpbinbimod=cdpbinbimod[liqonly]
    cdpBinMAD=cdpBinMAD[liqonly]
    cdpBinSD=cdpBinSD[liqonly]
  endif
  
  p1=scatterplot(cdpbinbimod,(cdplwc-lwc)/abs(lwc),sym_size=.5,sym_filled=1,sym_transparency=60,dimensions=[1800,1000],margin=50,xlog=0,ylog=0,/device)
stop
end