pro ploterrorbars


  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------PLOTS SCATTERS WITH ERROR BARS--------------------------------
  ;------------------------------------------USE CALCBINNEDVALS BEFOREHAND---------------------------------
  ;--------------------------------------------------------------------------------------------------------

  cgcleanup
  
  plotArr=[]
  
  ;------------------------------------------------------------------------------------------
  ;---------------------------------PLOT OPTIONS---------------------------------------------
  
  lineWidth=1.2
  xBarThick=3
  xBarStyle='-'
  yBarThick=2.
  
  
  barTrans=20
  symTrans=6
  symSize=2.4
  symThick=4
  
  ;------------------------------------------------------------------------------------------
  ;------------------------------------------------------------------------------------------
  
  
  ;------------------------------------------------------------------------------------------
  ;------------------------------INPUT ARRAYS--------------------------------------
  colorArr=['red','green','blue','black']
  colorArr='black'
  suffixArr=['082516400','082516500','082516600','082516700']
  suffixArr='082516400'
  symArr=['x','o','+','D']
  
  
  mainValsY=make_array(n1(suffixArr),500)*!values.d_nan
  
  ;------------------------------------------------------------------------------------------
  ;------------------------------------------------------------------------------------------
  
  for j=0,n(suffixArr) do begin
    suffix=suffixArr[j]
    colorSet=colorArr[j]
   
   restore,'saves/calcBins'+suffix+'.sav'
   
   
   ;------------------------------------------------------------------------------------------
   ;--------------------------------------INPUT ARRAYS----------------------------------------
   varX=xVar
   varA=lwcCdpMed
   varAErrUp=lwcCdpq1
   varAErrLow=lwcCdpq1
   
   
   ;DISPLAY AS PERCENTILES?
   percent=0
   if percent eq 1 then begin
    varA=varA*100.
    varAErrUp=varAErrUp*100.
    varAErrLow=varAErrLow*100.
   endif
   
   ;------------------------------------------------------------------------------------------
   ;------------------------------------------------------------------------------------------
   
    
    for i=0,n_elements(varA)-1 do begin
      p90=plot([varX[i],varX[i]],[varAErrLow[i],varA[i]],thick=yBarThick,color=colorSet,transparency=barTrans,/overplot,dimensions=[800,680])
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
  
  p1.font_size=22
  ;p1.xrange=[0,16]
  ;p1.yrange=[-100,20]
 ; p1.xmajor=9
;  p1.xtitle='Flight Level mb'
;  p1.ytitle='Absolute Median Clear Air Uncertainty g m!u-3!n'
  
  ;l1=legend(target=plotArr,auto_text_color=1,font_size=22,shadow=0,/device)
  
  

stop


end