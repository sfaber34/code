pro nevVmd
  restore,'saves/loopdatacope.sav'

  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------

  ;liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and cdpconc lt 10 and trf gt -3d) ;Cope
  ;liqOnly=where(trf gt -3d and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and cdpacc eq 0)
  liqOnly=where(trf gt -3d and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and lwc gt 0. and cdpconc gt 2 and cdpconc lt 400. and lwc lt 1.5)

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
    lwc100=lwc100[liqonly]
  endif
  
;  sorti=sort(vmd)
;  vmd=vmd[sorti]
;  lwc=lwc[sorti]
;  twc=twc[sorti]

  xvar=vmd
  yvar=twc/lwc-1.
;  vmd=vmd[sort(xvar)]
;  xvar=xvar[sort(xvar)]  
;  xvar=xvar[21:n(xvar)]
;  vmd=vmd[21:n(vmd)]


  s1=scatterplot(yvar,xvar,dimensions=[1400,1000],margin=50,/device,sym_filled=1,sym_size=.7,sym_transparency=30)
;  s1.xrange=[-3,3]
  vdmPred=((twc/lwc-1.)-(-0.559523)) / 0.0167876
  s2=scatterplot(yvar,vdmPred,sym_color='red',/overplot)


  s1=scatterplot(xvar,yvar,dimensions=[1400,1000],margin=50,/device,sym_filled=1,sym_size=.7,sym_transparency=30)
  
  f1=ladfit(xvar,yvar)
  
  
  y=f1[0]+xVar*f1[1]
  p1=scatterplot(xVar,y,sym_color='red',/overplot)

  s1.yrange=[-3,3]
  lwcSort=lwc[sort(lwc)]
  lwc95=lwcSort[n1(lwcsort)*.95]

  stop
end


pro testNevVmd
  restore,'saves/loopdatacope.sav'

  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------

  ;liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and cdpconc lt 10 and trf gt -3d) ;Cope
  ;liqOnly=where(trf gt -3d and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and cdpacc eq 0)
  liqOnly=where(trf gt -3d and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and lwc gt 0. and cdpconc gt 2 and lwc lt 1.3)

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
    lwc100=lwc100[liqonly]
  endif
  
  
  vdmPred=((twc/lwc-1.)-(-0.559523)) / 0.0167876
  xVar=cdpConc
  yVar=vmd-vdmPred
  
  s1=scatterplot(xvar,yvar,dimensions=[1400,1000],margin=50,/device,sym_filled=1,sym_size=.7,sym_transparency=30)
  
  
  
end