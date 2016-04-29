pro newScatters


  liq=1

  

  color=['black','deep sky blue','green','firebrick','purple','dark orange',$
    'midnight blue','dark olive green','dark khaki','black',$
    'green','firebrick','purple','dark orange','sienna','midnight blue',$
    'dark olive green','firebrick','dark slate grey','dark khaki','black','deep sky blue',$
    'green','firebrick','purple','dark orange']



  restore,'loopdata.sav'

  liqOnly=where(trf gt -3. and lwcfixede lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwcfixede gt 0.001 and twcfixede gt 0.001 and cdpconc gt 10.)



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



  ;------PLOT VARS------

  varA=lwcfixede/twcfixede
  varB=''
  varX=cdpmassmean
  type='ratio'

  lwcInc=[0.,.01,.02,.05,.075,.1,.15,.2,.5,.75,1.,1.25]




  hErr=dindgen(n_elements(varA),start=2.,increment=0)
  yErr=dindgen(n_elements(varA),start=0,increment=0)


  p5=scatterplot(varX,varA,sym_thick=1,sym_color='black',symbol='.',dimensions=[1500,1200],sym_transparency=100)
  
  for f=0,n_elements(lwcInc)-2 do begin
    filter=where(lwc gt lwcInc[f] and lwc lt lwcInc[f+1])
    
    p6=scatterplot(varX[filter],varA[filter],sym_thick=1,symbol='.',sym_color=color[f+1],/overplot,sym_size=2)
    
    t1=strcompress(string(lwcInc[f])+'-'+string(lwcInc[f+1]))
    text1=text(200*(f+1),945,t1,/device,color=color[f+1])
  endfor
  
  if varB ne '' then p6=scatterplot(vmdGeoMean,varB,sym_thick=2,symbol='.',sym_color='blue',/overplot,sym_size=2)

  p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2, thick=2)
  p5.xtitle='VMD um'
  p5.ytitle='LWC/TWC'
  
  
  

  p5.xrange=[0,42]
  p5.yrange=[0,2.]
  
  
  
  
  
  massmeansort=sort(cdpmassmean)
  massmeansorted=cdpmassmean[massmeansort]
  coleliqsorted=coleliq[massmeansort]
  coletotsorted=coletot[massmeansort]
  coletotsorted2=coletot2[massmeansort]
  twcoldesorted=twcolde[massmeansort]
  coletotsorted3=coletot3[massmeansort]
  colelwcsorted3=colELiq3[massmeansort]
  colelwcsorted=colELiq[massmeansort]
  
  
  
  ;for LWC
  if type eq 'lwc' then p2=plot(massmeansorted,coleliqsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)

  ;for TWC
  if type eq 'twc' then p3=plot(massmeansorted,coletotsorted,color='red',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)


  if type eq 'ratio' then p3=plot(massmeansorted,coleliqsorted/coletotsorted,color='red',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)



end