pro dofRefIdea

  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  restore,'saves/loopdatacope.sav'
  liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and trf gt -3d and lwc lt 1.4 and lwc gt .01 and cdplwc gt 0) ;Cope

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
  endif








trans=60

;s1=scatterplot(cdpacc,cdpdofrej,dimensions=[900,800])
s1=scatterplot(cdpacc,cdpdofrej,dimensions=[900,800],/nodata)
a=where((cdplwc-lwc)/lwc lt -.1)


b=where((cdplwc-lwc)/lwc lt -.05 and (cdplwc-lwc)/lwc gt -.15)


c=where((cdplwc-lwc)/lwc lt .05 and (cdplwc-lwc)/lwc gt -.05)


d=where((cdplwc-lwc)/lwc lt .15 and (cdplwc-lwc)/lwc gt .05)


e=where((cdplwc-lwc)/lwc lt .25 and (cdplwc-lwc)/lwc gt .15)



s3=scatterplot(cdpacc[e],cdpdofrej[e],sym_color='black',/overplot,sym_size=.5,sym_filled=1,sym_transparency=trans)
s2=scatterplot(cdpacc[a],cdpdofrej[a],sym_color='green',/overplot,xrange=[0,3.6e4],sym_size=.5,sym_filled=1,sym_transparency=trans)
s3=scatterplot(cdpacc[b],cdpdofrej[b],sym_color='red',/overplot,sym_size=.5,sym_filled=1,sym_transparency=trans)
s3=scatterplot(cdpacc[d],cdpdofrej[d],sym_color='orange',/overplot,sym_size=.5,sym_filled=1,sym_transparency=40)
s3=scatterplot(cdpacc[c],cdpdofrej[c],sym_color='blue',/overplot,sym_size=.5,sym_filled=1,sym_transparency=80)



end