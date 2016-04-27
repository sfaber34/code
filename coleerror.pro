pro coleerror

 restore,'colesavefile.sav'

  bincount=60/binsizestart
  ticks=string(dindgen(bincount,start=binintstart,increment=binsizestart))
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

  
  
  coleB=cdpVLwcFixedE
  print,coleB
  

  



  coleBx=dindgen(n_elements(coleB),start=binintstart,increment=binsizestart)

  p5=scatterplot(coleBx,(abs(1.-lwctwc))*100.,sym_size=.7,sym_color='blue',dimensions=[1600,1200])
  p5=scatterplot(coleBx,(abs(1.-lwctwc2))*100.,sym_size=.7,sym_color='red',/overplot)
  p5=plot([0,50],[1,1],color='grey',/overplot,linestyle=2)

  p5.xrange=[0,50]
  p5.yrange=[-100,100]

  ;p5.


  p5.font_size=22

  stop


end