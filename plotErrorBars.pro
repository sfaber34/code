pro ploterrorbars


  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------PLOTS SCATTERS WITH ERROR BARS--------------------------------
  ;------------------------------------------USE CALCBINNEDVALS BEFOREHAND---------------------------------
  ;--------------------------------------------------------------------------------------------------------

  cu
  
  plotArr=[]
  
  ;------------------------------------------------------------------------------------------
  ;---------------------------------PLOT OPTIONS---------------------------------------------
  
  lineWidth=7
  xBarThick=3
  xBarStyle='-'
  yBarThick=2.
  
  
  barTrans=40
  symTrans=20
  symSize=1.9
  symThick=3
  
  ;------------------------------------------------------------------------------------------
  ;------------------------------------------------------------------------------------------
  
  
  ;------------------------------------------------------------------------------------------
  ;------------------------------INPUT ARRAYS--------------------------------------
  colorArr=['black','red','blue','green','purple']
  ;colorArr='black'
  suffixArr=['bydayLar700','bydayLar600','bydayLar500','bydayLar400','bydayLar400Surf']
  suffixArr=['bydayPac700','bydayPac600','bydayPac500','bydayPac400','bydayPac400Surf']
  suffixArr=['Lar700','Lar600','Lar500','Lar400','Lar400Surf']
  suffixArr=['Pac700','Pac600','Pac500','Pac400','Pac400Surf']
  suffixArr=['Lar600','Pac600']
  
  symArr=['+','x','+','D','s']
  
  
  mainValsY=make_array(n1(suffixArr),500)*!values.d_nan
  
  ;------------------------------------------------------------------------------------------
  ;------------------------------------------------------------------------------------------
  
  for j=0,n(suffixArr) do begin
    suffix=suffixArr[j]
    colorSet=colorArr[j]
   
   restore,'saves/calcBins'+suffix+'.sav'
   
   
   ;------------------------------------------------------------------------------------------
   ;--------------------------------------INPUT ARRAYS----------------------------------------
   varX=xvar
   varA=lwccaemed
   varAErrUp=lwccaeq3
   varAErrLow=lwccaeq1
   
   
   ;DISPLAY AS PERCENTILES?
   percent=0
   if percent eq 1 then begin
    varA=varA*10.
    varAErrUp=varAErrUp*10.
    varAErrLow=varAErrLow*10.
   endif
   
   ;------------------------------------------------------------------------------------------
   ;------------------------------------------------------------------------------------------
   
    
    for i=0,n_elements(varA)-1 do begin
      p90=plot([varX[i],varX[i]],[varAErrLow[i],varA[i]],thick=yBarThick,color=colorSet,transparency=barTrans,/overplot,dimensions=[1000,800])
      p91=plot([varX[i]-lineWidth,varX[i]+lineWidth],[varAErrLow[i],varAErrLow[i]],thick=xBarThick,color=colorSet,linestyle=xBarStyle,transparency=barTrans,/overplot)

      p92=plot([varX[i],varX[i]],[varA[i],varAErrUp[i]],thick=yBarThick,color=colorSet,transparency=barTrans,/overplot)
      p93=plot([varX[i]-lineWidth,varX[i]+lineWidth],[varAErrUp[i],varAErrUp[i]],thick=xBarThick,color=colorSet,linestyle=xBarStyle,transparency=barTrans,/overplot)
    endfor
    
    for k=0,n(varx) do begin
      mainValsY[j,k]=varA[k]
    endfor

  endfor
  
  
  for u=0,n(suffixArr) do begin
    y=mainValsY[u,*]
    inds=where(finite(y) eq 1)
      p1=scatterplot(varX[inds],y[inds],sym_color=colorArr[u],sym_filled=0,name=suffix+' mb',symbol=symArr[u],sym_size=symSize,sym_thick=symThick,sym_transparency=symTrans,/overplot)
      plotArr=[temporary(plotArr),p1]
  endfor
  
;  p1.xrange=[450,630]
;  p1.yrange=[-.022,.02]
  zeroPlot=plot(p1.xrange,[0,0],'--',thick=2,/overplot)
  p1.font_size=20
  ;p1.xrange=[-1,max(xvar)+1]
  ;p1.xminor=0
  ;p1.xtickname=['','030416','081816','112415','121715','012015','012515','030715','082516','082616','090416','090916','091016','091316','091616','092316','']
  ;p1.xtext_orientation=90
  
  ;l1=legend(target=plotArr,auto_text_color=1,font_size=22,shadow=0,/device)
  
  

stop


end