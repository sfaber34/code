pro colescatterrealModCorrected




  plots=2

  ;STARTING LEFT VALUE
  binint=2.

  ;WIDTH OF BINS
  binsize=.3

  ;LIQUID ONLY POINTS OR ALL
  liq=1






  bincount=60/binsize
  ticks=string(dindgen(bincount,start=binint,increment=binsize))
  ticks=strsplit(ticks,'.',/extract)

  ticks2=make_array(n_elements(ticks),/string)
  for u=0,n_elements(ticks)-1 do begin
    ticks2[u]=ticks[u,0]
  endfor

  ticks=[strcompress(ticks2),' ',' ']


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

  liqOnly=where(trf gt -3. and lwcfixede lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwcfixede gt 0 and twcfixede gt 0 and cdpMassMean lt 40.)
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
  restore,'colesavefileB.sav'
  coleB=colevartwc
  coleC=colecontrollwcB

  type='twc'

  if type eq 'twc' then begin
    var1=colevarlwc
    var2=colevartwc
    ;var3=colevarbothlwc
  endif else if type eq 'twc2' then begin
    var1=colevarlwc
    var2=colevarLwc2
    ;var3=colevarbothtwc
  endif else if type eq 'lwc' then begin
    var1=colevarcontroltwc
    var2=colevartwc
    ;var3=colevarbothtwc
  endif





  h1=histogram(cdpmassmean,min=minbin,binsize=.2)

  x=where(h1 lt 10.)

  coleBx=dindgen(n_elements(coleB),start=binintstart,increment=.25)
  coleCx=dindgen(n_elements(coleC),start=minbin,increment=.5)
  hErr=dindgen(n_elements(coleB),start=2.,increment=0)
  yErr=dindgen(n_elements(coleB),start=0,increment=0)


  p5=scatterplot(vmdGeoMean,coleB,sym_thick=2,sym_color='blue',name=type+' Eq. Coll. E',dimensions=[1500,1200])
  ;p6=scatterplot(coleCx,ColeC,sym_thick=2,sym_color='red',/overplot,name=type+' Eq. Coll. E')

  p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2, thick=2)
  p5.xtitle='VMD um'
  p5.ytitle='LWC/TWC'

  p5.xrange=[0,42]
  p5.yrange=[.2,1.2]


  liqonly2=where(trf gt -3. and lwc lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt 5)




  ;for LWC
  ;if type eq 'lwc' then p2=plot(massmeansorted,coleliqsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)

  ;for TWC
  if type eq 'twc' then p3=plot(massmeansorted,coletotsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)

  ;for TWC2
  if type eq 'twc2' then p4=plot(massmeansorted,coleliqsorted/coletotsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)



  p5.font_size=22
  
  fif=dindgen(1000,start=150.,increment=0)
  nin=dindgen(1000,start=.99,increment=0)
  
  
  f1=poly_fit(vmdGeoMean,coleB,2,yfit=yfit)
  f2=comfit([vmdGeoMean,fif],[coleB,nin],[.5,.2,.04],/geometric,yfit=yfit2)
  
  
  ;p10=plot(vmdGeoMeanB,.5*vmdGeoMeanB^.2+.04,/overplot)
  p10=plot([vmdGeoMean,fif],[yfit,nin],/overplot)
  
  
  
  
  




end