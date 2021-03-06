pro cdpBinStats
  restore,'saves/loopdataCope.sav'


  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;Plots CDP count bin stats
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------




  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------

  liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and trf gt -3d and lwc gt .01 and cdpconc gt .3) ;Cope

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

  color=[color,color,color,color,color]


  s1=scatterplot(cdplwc/lwc-1d,cdpbinbimod,dimensions=[1400,1000],margin=50,/device,sym_filled=1,sym_size=.4,sym_transparency=50,sym_color='black')
  s1.xrange=[-.5,.5]
  s1.yrange=[-2.,3.]


  var=cdpbinbimod
  startbin=-10
  bininc=1
  maxbin=10
  binBounds=dindgen(ceil((maxbin-startbin)/bininc),start=startbin,increment=bininc)
  binBounds=[temporary(binBounds),maxbin]


  for i=1,n1(binbounds) do begin
    sel=where(var ge binbounds[i-1] and var le binbounds[i])
    s1=scatterplot(cdplwc[sel]/lwc[sel]-1d,cdpbinskew[sel],sym_filled=1,sym_size=.4,sym_transparency=10,sym_color=color[i],/overplot)
  endfor

  stop
end