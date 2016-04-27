pro colescatterrealLwc100




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

  liqOnly=where(trf gt -3. and lwc lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt 5)
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


  ;  coleControlLwc=[]
  ;  coleControlTwc=[]
  ;  colevarLwc=[]
  ;  colevarTwc=[]
  ;  colevarbothLwc=[]
  ;  colevarbothTwc=[]


  ;cgcleanup


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
  coleB=colecontrollwc/colecontroltwc


  type='twc2'

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


  coleB=lwcDtwcFixedE
  coleC=lwcDtwc

  h1=histogram(cdpmassmean,min=minbin,binsize=.2)

  x=where(h1 lt 10.)

  coleBx=dindgen(n_elements(coleC),start=minbin,increment=.2)
  coleCx=dindgen(n_elements(coleC),start=minbin,increment=.2)
  hErr=dindgen(n_elements(coleB),start=2.,increment=0)
  yErr=dindgen(n_elements(coleB),start=0,increment=0)
  
  

  ;e5=errorplot(cdpmassmean,lwc/twc,hErr,yErr,errorbar_thick=2,linestyle=6,xaxis=0,errorbar_color='light grey',symbol=0,dimensions=[1200,1200])
  ;e6=errorplot(coleBx,var2,hErr,yErr,errorbar_thick=2,linestyle=6,xaxis=0,errorbar_color='light blue',symbol=0,/overplot)
  ;e7=errorplot(coleBx,var3,hErr,yErr,linestyle=6,xaxis=0,errorbar_color='light coral',symbol=0,/overplot)

  p5=scatterplot(coleBx,coleB,sym_thick=2,sym_color='blue',name=type+' Eq. Coll. E',dimensions=[1500,1200],margin=[110,70,30,20],/device)
  ;p6=scatterplot(coleCx[x],coleC[x],sym_thick=2,sym_color='steel blue',/overplot)
  ;p5=scatterplot(coleCx,ColeC,sym_thick=2,sym_color='red',/overplot,name=type+' Eq. Coll. E')
  p6=scatterplot(coleCx,coleC,sym_thick=2,sym_color='red',/overplot)
  ;p7=scatterplot(coleBx,var3,sym_size=.7,sym_color='red',/overplot)

  ;l1=legend(target=[p5,p6],shadow=0,/device,font_size=22)


  ;p5=scatterplot(coleBx,colevartwc,sym_size=.7,sym_color='green',/overplot)
  p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2, thick=2)
  p5.xtitle='VMD um'
  p5.ytitle='LWC/TWC'

  p5.xrange=[2,42]
  p5.yrange=[0,3]


  liqonly2=where(trf gt -3. and lwc lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt 5)




  ;for LWC
  ;if type eq 'twc2' then p2=plot(massmeansorted,coleliqsorted,color='green',thick=2,linestyle=2,/device,/overplot)

  ;for TWC
  ;if type eq 'twc2' then p3=plot(massmeansorted,coletotsorted,color='green',thick=2,linestyle=2,/device,/overplot)

  ;for TWC2
  ;if type eq 'twc2' then p4=plot(massmeansorted,coleliqsorted/coletotsorted,color='green',thick=2,linestyle=2,/overplot)


  p5.font_size=22


  stop

end