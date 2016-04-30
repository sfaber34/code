pro lwc100error




  plots=2

  ;STARTING LEFT VALUE
  binint=2.

  ;WIDTH OF BINS
  binsize=.3

  ;LIQUID ONLY POINTS OR ALL
  liq=1



  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------



  color=['black','deep sky blue','green','firebrick','purple','dark orange','sienna',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'deep sky blue','green','firebrick','purple','dark orange','sienna','midnight blue',$
    'dark olive green','firebrick','dark slate grey','dark khaki','black','deep sky blue',$
    'green','firebrick','purple','dark orange',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black']



  restore,'loopdata.sav'

  liqOnly=where(trf gt -3. and lwc lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05)
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
    lwcExE=lwcExE[liqonly]
    twcExE=twcExE[liqonly]
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
  colelwcsorted=colELiq[massmeansort]


  restore,'colesavefile.sav'
  ;restore,'colesavefileB.sav'

  ;-----PLOT OPTIONS------

  varA=lwc100Vlwc
  varB=lwc100Vtwc

  type='twc2'





  h1=histogram(cdpmassmean,min=minbin,binsize=.2)

  x=where(h1 lt 10.)

  varAx=dindgen(n_elements(varA),start=binintstart,increment=.25)
  varBx=dindgen(n_elements(varB),start=minbin,increment=.5)
  hErr=dindgen(n_elements(varA),start=2.,increment=0)
  yErr=dindgen(n_elements(varA),start=0,increment=0)

;  p3=errorplot(vmdGeoMean,varA,[lwcfixedeq1],symbol='none',dimensions=[1500,1200],errorbar_thick=1,linestyle='none')
;  p4=errorplot(vmdGeoMean,varB,[twcfixedeq1],symbol='none',dimensions=[1500,1200],errorbar_color='blue',linestyle='none',/overplot)


  p5=scatterplot(vmdGeoMean,(varA)*100.,sym_thick=2,sym_color='black',dimensions=[1500,1200],/overplot,name='LWC')
  p6=scatterplot(vmdGeoMean,(varB)*100.,sym_thick=2,sym_color='blue',/overplot,name='TWC')

  p50=plot([0,50],[0,0],color='grey',/overplot,linestyle=2, thick=2)
  p50.xtitle='VMD um'
  p50.ytitle='LWC-100 Percent Difference'
  
  l1=legend(position=[100,100],target=[p5,p6],/device,shadow=0,font_size=22)

  p50.xrange=[0,42]



  liqonly2=where(trf gt -3. and lwcExE lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt 5)



  p50.font_size=22
stop

end