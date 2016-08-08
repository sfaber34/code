pro ploterrorbars


  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------PLOTS SCATTERS WITH ERROR BARS--------------------------------
  ;------------------------------------------USE CALCBINNEDVALS BEFOREHAND---------------------------------
  ;--------------------------------------------------------------------------------------------------------

  cgcleanup
  
  plotArr=[]
  
  
  ;-----PLOT OPTIONS------
  
  
  lineWidth=7
  xBarThick=2
  xBarStyle='-'
  
  barTrans=20
  symTrans=6
  
  
  symSize=2.4
  symThick=4
  colorArr=['red','green','blue','black']
  suffixArr=['lar400','lar500','lar600','lar700']
  symArr=['x','o','+','D']
  
  for j=0,n(suffixArr) do begin
    suffix=suffixArr[j]
    colorSet=colorArr[j]
   
   restore,'saves/calcBins'+suffix+'.sav'
   
   varX=xVar
   varA=lwcCAEMed
   varAErrUp=lwcCAEq3
   varAErrLow=lwcCAEq1
   
   yBarThick=6.-j*1.4
   yBarThick=2.
   
    
    for i=0,n_elements(varA)-1 do begin
      p90=plot([varX[i],varX[i]],[varAErrLow[i],varA[i]],thick=yBarThick,color=colorSet,transparency=barTrans,/overplot,dimensions=[1200,1000],margin=[150,100,30,30],/device)
      p91=plot([varX[i]-lineWidth,varX[i]+lineWidth],[varAErrLow[i],varAErrLow[i]],thick=xBarThick,color=colorSet,linestyle=xBarStyle,transparency=barTrans,/overplot)

      p92=plot([varX[i],varX[i]],[varA[i],varAErrUp[i]],thick=yBarThick,color=colorSet,transparency=barTrans,/overplot)
      p93=plot([varX[i]-lineWidth,varX[i]+lineWidth],[varAErrUp[i],varAErrUp[i]],thick=xBarThick,color=colorSet,linestyle=xBarStyle,transparency=barTrans,/overplot)
    endfor
    p1=scatterplot(varX,varA,sym_color=colorSet,sym_filled=0,name=suffix+' mb',symbol=symArr[j],sym_size=symSize,sym_thick=symThick,sym_transparency=symTrans,/overplot)
    plotArr=[temporary(plotArr),p1]
  endfor
  
  p1.font_size=22
  ;p1.xmajor=9
;  p1.xtitle='Flight Level mb'
;  p1.ytitle='Absolute Median Clear Air Uncertainty g m!u-3!n'
  
  l1=legend(target=plotArr,auto_text_color=1,font_size=22,shadow=0,/device)
  
  

stop


end