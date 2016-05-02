pro colescatterErrorBars

  ;LIQUID ONLY POINTS OR ALL
  liq=0



  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------



  



  restore,'loopdata.sav'

  liqOnly=where(trf gt -3. and lwcfixede lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwcfixede gt 0.05 and twcfixede gt 0.05)
  ;liqOnly=where(trf gt -3. and lwc lt 1.1 and lwc gt .05 and twc gt .05)


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
    lwcfixede=lwcfixede[liqonly]
    twcfixede=twcfixede[liqonly]
    twc2=twc2[liqonly]
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    coleliq=coleliq[liqonly]
    coletot=coletot[liqonly]
  endif




  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------COLE SCATTER----------------------------------------------
  ;--------------------------------------------------------------------------------------------------------




  cgcleanup


  xs=dindgen(501,start=0,increment=.1)

  ;p1=scatterplot(korX,korY,sym_color=grey,sym_size=.1,symbol=0,dimensions=[1600,1200])



  massmeansort=sort(cdpmassmean)
  massmeansorted=cdpmassmean[massmeansort]
  coleliqsorted=coleliq[massmeansort]
  coletotsorted=coletot[massmeansort]
  coletotsorted2=coletot2[massmeansort]
  twcoldesorted=twcolde[massmeansort]
  coletotsorted3=coletot3[massmeansort]
  colelwcsorted3=colELiq3[massmeansort]
  colelwcsorted=colELiq[massmeansort]


  restore,'colesavefile.sav'
  ;restore,'colesavefileB.sav'
  
  ;-----PLOT OPTIONS------
  
  varA=coleControlTwc
  varAErrLow=lwcfixedeq1
  varAErrUp=lwcfixedeq3
  varB=""

  type='twc2'







  ;for LWC
  if type eq 'lwc' then p2=plot(massmeansorted,coleliqsorted,color='green',thick=2,linestyle=2,dimensions=[1500,1200],margin=[110,70,30,20],/device,/overplot)

  ;for TWC
  if type eq 'twc' then p2=plot(massmeansorted,coletotsorted,color='red',thick=2,linestyle=2,dimensions=[1500,1200],margin=[110,70,30,20],/device,/overplot)

  ;for TWC2
  if type eq 'twc2' then p2=plot(massmeansorted,coleliqsorted/coletotsorted,color='red',thick=2,linestyle=2,dimensions=[1500,1200],margin=[110,70,30,20],/device,/overplot)

  p2.xrange=[5,42]
  p2.yrange=[.5,1.5]


  varAx=dindgen(n_elements(varA),start=binintstart,increment=.25)
  varBx=dindgen(n_elements(varB),start=minbin,increment=.5)
  hErr=dindgen(n_elements(varA),start=2.,increment=0)
  yErr=dindgen(n_elements(varA),start=0,increment=0)


  p5=plot([0,50],[1,1],color='grey',linestyle=2, thick=2,/device,/overplot)
  

  p5=scatterplot(vmdGeoMean,varA,sym_thick=2,sym_color='black',sym_filled=1,name=type+' Eq. Coll. E',/overplot)
  ;p6=scatterplot(vmdGeoMean,varB,sym_thick=2,sym_color='blue',/overplot)
  
  for i=0,n_elements(varA)-1 do begin
    p90=plot([vmdGeoMean[i],vmdGeoMean[i]],[varA[i],varA[i]-varAErrLow[i]],thick=2,/overplot)
    p91=plot([vmdGeoMean[i]-.25,vmdGeoMean[i]+.25],[varA[i]-varAErrLow[i],varA[i]-varAErrLow[i]],thick=2,/overplot)
    
    p92=plot([vmdGeoMean[i],vmdGeoMean[i]],[varA[i],varA[i]+varAErrUp[i]],thick=2,/overplot)
    p93=plot([vmdGeoMean[i]-.25,vmdGeoMean[i]+.25],[varA[i]+varAErrUp[i],varA[i]+varAErrUp[i]],thick=2,/overplot)
  endfor
  
  

  
  p5.xtitle='VMD um'
  p5.ytitle='LWC/TWC'


  liqonly2=where(trf gt -3. and lwc lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt 5)




  



  p5.font_size=22
stop

end