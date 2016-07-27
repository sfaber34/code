pro plotPresCorExample
  restore,'saves/loopdata03071hz.sav'
  
  liq=1
  liqOnly=where(trf gt -3d and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and lwc ge .02 and twc ge .02)

  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    iwc=iwc[liqonly]
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
    cdpbinn=cdpbinn[*,liqonly]
  endif
  
  means=dindgen(23,start=3,increment=2)
  
  h1=histogram(vmd,binsize=2)
  h1ByMass=h1*means^3.
  
  b1=barplot(means-1.,h1ByMass/total(h1ByMass),/histogram,dimensions=[900,600])
  b1.xtitle='VMD um'
  
  b1.xtickname=string(indgen(12,start=2,increment=4))
  b1.ytitle='Relative Mass Contribution'
  b1.font_size=22
  b1.xrange=[2,48]
  b1.yrange=[0,.22]
  b1.xminor=0
  b1.xticklen=0

  
  
  
  vmdplot=dindgen(500,start=2,increment=.1)
  colEliq=dindgen(n1(vmdplot),start=1,increment=0)
  for d=0,n(vmdplot) do begin
    if vmdPlot[d] ge 0.884495 and vmdPlot[d] lt 4.78668056 then begin
      colEliq[d]=0.76534878613892943-1.9525313756894320*vmdPlot[d]+2.3079791209893301*vmdPlot[d]^2.-1.1748496234649792*vmdPlot[d]^3.+0.31405602625454776*vmdPlot[d]^4.-0.042947818677930627*vmdPlot[d]^5.+0.0023657753736188170*vmdPlot[d]^6.
    endif
    if vmdPlot[d] ge 4.78668056 and vmdPlot[d] lt 17.0 then begin
      colEliq[d]=0.053872488439083099+0.38012190535664558*vmdPlot[d]-0.073273373767733574*vmdPlot[d]^2.+0.0082262509968131781*vmdPlot[d]^3.-0.00056395785577478819*vmdPlot[d]^4.+2.3254772713698912e-05*vmdPlot[d]^5.-5.2972488973068721e-07*vmdPlot[d]^6.+5.1198482675651746e-09*vmdPlot[d]^7.
    endif
    if vmdPlot[d] ge 17.0 and vmdPlot[d] lt 25. then begin
      colEliq[d]=0.91221589+0.0087850597*vmdPlot[d]-0.00025973702*vmdPlot[d]^2.
    endif
    if vmdPlot[d] ge 25. then begin
      x1=((vmdPlot[d]-20.)/90)^2.
      x2=2.^(1./.26)-1.
      colEliq[d]=.98/(1.+x1*x2)^.26
    endif
  endfor
  
  p1=plot(vmdPlot,colEliq,dimensions=[900,600],font_size=22)
  p1.xrange=[2,48]
  p1.yrange=[0,1]
  p1.ytitle='LWC collection effeciency'
  p1.thick=3
  p1.linestyle=2
  stop
  
  
  s1=scatterplot(pmb[clearairliq],lwcnpc[clearairliq],symbol='.',sym_size=5,sym_transparency=50,sym_filled=1,dimensions=[900,900],margin=80,/device)
  s1.font_size=22
  s2=scatterplot(pmb[clearairliq],lwc[clearairliq],symbol='.',sym_color='blue',sym_size=5,sym_transparency=50,sym_filled=1,/overplot)                             
end