pro newScatters


  liq=1

  

  color=['black','navy','firebrick','dark green','magenta','coral','dodger blue','indian red','orange','olive drab','medium violet red']



  restore,'loopdata.sav'

  liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and cdpMassMean lt 40.)



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
    twc=twc[liqonly]
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    coleliq=coleliq[liqonly]
    coletot=coletot[liqonly]
  endif



  ;------PLOT VARS------

  varA=lwc/twc
  varB=''
  varX=cdpmassmean
  type='ratio'

  lwcInc=[0.05,.2,.4,.5,.75,1.,1.1]




  hErr=dindgen(n_elements(varA),start=2.,increment=0)
  yErr=dindgen(n_elements(varA),start=0,increment=0)


  p5=scatterplot(varX,varA,sym_thick=1,sym_color='black',symbol='.',dimensions=[1500,1200],sym_transparency=100,margin=[110,70,30,20],/device)
  p5.xrange=[0,42]
  p5.yrange=[0,2.]
  for f=0,n_elements(lwcInc)-2 do begin
    filter=where(lwc gt lwcInc[f] and lwc lt lwcInc[f+1])
    
    p6=scatterplot(varX[filter],varA[filter],sym_thick=1,symbol='.',sym_color=color[0],/overplot,sym_size=1.4,sym_filled=1)
    
;    t1=strcompress(string(lwcInc[f])+'-'+string(lwcInc[f+1]))
;    text1=text(200*(f+1),945,t1,/device,color=color[f+1],font_size=19)
  endfor
  
  if varB ne '' then p6=scatterplot(vmdGeoMean,varB,sym_thick=2,symbol='.',sym_color='blue',/overplot,sym_size=2)

  p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2, thick=2)
  p5.xtitle='VMD um'
  p5.ytitle='LWC/TWC'
  
  p5.xrange=[5,42]
  p5.yrange=[.5,1.5]
  
  p5.font_size=22
 
  
  
  
  
  
  massmeansort=sort(cdpmassmean)
  massmeansorted=cdpmassmean[massmeansort]
  coleliqsorted=coleliq[massmeansort]
  coletotsorted=coletot[massmeansort]
  colelwcsorted=colELiq[massmeansort]
  
  
  
  ;for LWC
  if type eq 'lwc' then p2=plot(massmeansorted,coleliqsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)

  ;for TWC
  if type eq 'twc' then p3=plot(massmeansorted,coletotsorted,color='red',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)


  if type eq 'ratio' then p3=plot(massmeansorted,coleliqsorted/coletotsorted,color='red',thick=2,linestyle=2,dimensions=[1200,1200],margin=[110,70,30,20],/device,/overplot)

stop

end