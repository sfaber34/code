pro newScattersB


  liq=1




  restore,'loopdata.sav'

  liqOnly=where(trf gt -3. and lwc lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05)



  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpDEff=cdpDEff[liqonly]
    cdpVolMean=cdpVolMean[liqonly]
    cdpMassMean=cdpMassMean[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwcExE=lwcExE[liqonly]
    twcExE=twcExE[liqonly]
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    coleliq=coleliq[liqonly]
    coletot=coletot[liqonly]
  endif



  ;------PLOT VARS------

  varA=lwc/twc
  varB=''
  varX=lwc
  type='ratio'

  lwcInc=[0,5,10,15,20,25,30,40,50]




  hErr=dindgen(n_elements(varA),start=2.,increment=0)
  yErr=dindgen(n_elements(varA),start=0,increment=0)


  p5=scatterplot(varX,varA,sym_thick=1,sym_color='black',symbol='.',dimensions=[1500,1200])
;  p5.xrange=[0,42]
;  p5.yrange=[0,2.]
  for f=0,n_elements(lwcInc)-2 do begin
    filter=where(cdpmassmean gt lwcInc[f] and cdpmassmean lt lwcInc[f+1])

    p6=scatterplot(varX[filter],varA[filter],sym_thick=1,symbol='.',sym_color=color[f+1],/overplot,sym_size=2,sym_filled=1)

    t1=strcompress(string(lwcInc[f])+'-'+string(lwcInc[f+1]))
    text1=text(200*(f+1),945,t1,/device,color=color[f+1],font_size=19)
  endfor

  if varB ne '' then p6=scatterplot(vmdGeoMean,varB,sym_thick=2,symbol='.',sym_color='blue',/overplot,sym_size=2)

  ;p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2, thick=2)
  p5.xtitle='VMD um'
  p5.ytitle='LWC/TWC'



  p5.font_size=22






  massmeansort=sort(cdpmassmean)
  massmeansorted=cdpmassmean[massmeansort]
  coleliqsorted=coleliq[massmeansort]
  coletotsorted=coletot[massmeansort]
  coletotsorted2=coletot2[massmeansort]
  twcoldesorted=twcolde[massmeansort]
  coletotsorted3=coletot3[massmeansort]
  colelwcsorted3=colELiq3[massmeansort]
  colelwcsorted=colELiq[massmeansort]


  stop

end