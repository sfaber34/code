pro calcTwcColeE




  plots=2

  ;STARTING LEFT VALUE
  binint=2.

  ;WIDTH OF BINS
  binsize=.3

  ;LIQUID ONLY POINTS OR ALL
  liq=0






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




  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------COLE SCATTER----------------------------------------------
  ;--------------------------------------------------------------------------------------------------------


  ;  coleControlLwc=[]
  ;  coleControlTwc=[]
  ;  colevarLwc=[]
  ;  colevarTwc=[]
  ;  colevarbothLwc=[]
  ;  colevarbothTwc=[]


  cgcleanup


  xs=dindgen(501,start=0,increment=.1)

  ;p1=scatterplot(korX,korY,sym_color=grey,sym_size=.1,symbol=0,dimensions=[1600,1200])



  massmeansort=sort(cdpmassmean)
  massmeansorted=cdpmassmean[massmeansort]
  coleliqsorted=coleliq[massmeansort]
  coletotsorted=coletot[massmeansort]


  restore,'colesavefile.sav'
  coleB=colecontrollwc
  
  
  filtx=dindgen(500001,start=0,inc=.0001)
  
  leftFilt=0.036144577*filtx+.5
  
  coleBx=dindgen(n_elements(colevartwc),start=binintstart,increment=binsizestart)
  
  filttwci=dindgen(n_elements(colevartwc),start=0,increment=0)
  for r=0,n_elements(colevartwc)-1 do begin
    if colevartwc[r] lt 0.036144577*coleBx[r]+.5 and colevartwc[r] lt 1.2 then filttwci[r]=1.
  endfor
  
  filttwc=where(filttwci eq 1.)
  
  coleBx=dindgen(n_elements(colevartwc),start=binintstart,increment=binsizestart)
  
  coleBx=coleBx[filttwc]
  

  type='twc'

  if type eq 'twc' then begin
    var1=colevarlwc
    var2=colevartwc[filttwc]
    ;var3=colevarbothlwc
  endif else begin
    var1=colevarcontroltwc
    var2=colevartwc
    ;var3=colevarbothtwc
  endelse



  ;for LWC
  if strmatch(type,'lwc',/fold_case) eq 1 then p2=plot(massmeansorted,coleliqsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=!margins,/device)

  ;for TWC
  if strmatch(type,'twc',/fold_case) eq 1 then p3=plot(massmeansorted,coletotsorted,color='green',thick=2,linestyle=2,dimensions=[1200,1200],margin=!margins,/device)


 


  hErr=dindgen(n_elements(colevartwc[filttwc]),start=2.,increment=0)
  yErr=dindgen(n_elements(colevartwc[filttwc]),start=0,increment=0)

  
  ;e6=errorplot(coleBx,var2,hErr,yErr,errorbar_thick=2,linestyle=6,xaxis=0,errorbar_color='light blue',symbol=0,/overplot)
  ;e7=errorplot(coleBx,var3,hErr,yErr,linestyle=6,xaxis=0,errorbar_color='light coral',symbol=0,/overplot)

  
  p6=scatterplot(coleBx[1:332],var2[1:332],sym_thick=2,sym_color='blue',/overplot,name=type+' Corrected Eq. Coll. E')
  ;p7=scatterplot(coleBx,var3,sym_size=.7,sym_color='red',/overplot)

  


  ;p5=scatterplot(coleBx,colevartwc,sym_size=.7,sym_color='green',/overplot)
  p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2, thick=2)
  p6=plot([0,24.9],[.5,1.4],/overplot,'r')
  p5.xtitle='VMD um'
  p5.ytitle='Equivalent/Corrected Equivalent Coll. E.'
  
  
  twos=dindgen(100,start=2.,increment=0)
  fives=dindgen(100,start=.05,increment=0)
  fitx=dindgen(151,start=2,increment=1)
  forcebx=dindgen(18,start=15.3,increment=0)
  forceby=dindgen(18,start=.868,increment=0)
  forcecx=dindgen(1,start=500,increment=0)
  forcecy=dindgen(1,start=.9,increment=0)
  
  
  fit2=poly_fit([coleBx[1:332]],[var2[1:332]],5,yfit=yfit2)
  ;fit1=comfit([coleBx[1:332]],[var2[1:332]],[fit2[2],.6,fit2[0]],yfit=yfit,itmax=10000,/geometric)
  ;fit1=comfit([twos,coleBx[1:332]],[fives,var2[1:332]],[0.91767128433475265,0.13260,-0.283137],yfit=yfit,itmax=10000,/geometric)
  fit3=poly_fit([forcebx,coleBx[103:332]],[forceby,var2[103:332]],2,yfit=yfit3)
  fit1=comfit([forcebx,coleBx[103:332]],[forceby,var2[103:332]],[0.5535,0.13260,0.553],yfit=yfit,itmax=10000,/geometric)
  
  
  line=fit1[0]*fitx^(fit1[1])+(fit1[2])
  
  p8=plot(fitx,line,color='purple',thick=2,/overplot)
  p7=plot(coleBx[1:69],yfit2,/overplot,color='orange',thick=2)
  
  fit4=linfit([33,55],[.9681,.991])
  
  line2=fit4[0]+fit4[1]*33
  
  p9=plot([33,55],[fit4[0]+fit4[1]*33,fit4[0]+fit4[1]*55],/overplot,color='red',thick=2)
  
  

  p5.xrange=[0,50]
  p5.yrange=[0,1.4]

  ;p5.


  p5.font_size=22


  stop

end