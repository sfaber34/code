pro baselineConfidence
  restore,'saves/loopdatacope.sav'
  
  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------

  ;liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and cdpconc lt 10 and trf gt -3d) ;Cope
  liqOnly=where(cdpconc lt 10 and trf gt -3d) ;Laramie
  liqOnly=where(trf gt -3d and lwc gt .01 and lwc lt 1.3 and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1))

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
    cdpdofrej=cdpdofrej[liqonly]
    cdpadcover=cdpadcover[liqonly]
  endif
  
  s1=scatterplot(vmd,(twc/lwc),dimensions=[1400,1000],margin=50,/device,sym_filled=1,sym_size=.7,sym_transparency=30)
  
  lwcSort=lwc[sort(lwc)]
  lwc95=lwcSort[n1(lwcsort)*.95]
  
stop
end