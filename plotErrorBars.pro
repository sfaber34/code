pro ploterrorbars


  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------PLOTS SCATTERS WITH ERROR BARS--------------------------------
  ;------------------------------------------USE CALCBINNEDVALS BEFOREHAND---------------------------------
  ;--------------------------------------------------------------------------------------------------------
cgcleanup
  
  plotArr=[]
  
  
  ;-----PLOT OPTIONS------
  
  
  lineWidth=4.
  xBarThick=4
  xBarStyle='-'
  
  barTrans=20
  symTrans=6
  
  
  symSize=1.8
  symThick=2
  colorArr=['red','green','blue','black']
  suffixArr=['400','500','600','700']
  suffixArr='Cope'
  
  for j=0,n(suffixArr) do begin
    suffix=suffixArr[j]
    colorSet=colorArr[j]
   
   restore,'saves/calcBins'+suffix+'.sav'
   
   varX=cdpconcmean
   varA=cdpVlwc
   varAErrUp=cdpVlwcq3
   varAErrLow=cdpVlwcq1
   
   yBarThick=6.-j*1.4
   yBarThick=2
   
    p1=scatterplot(varX,varA,sym_color=colorSet,sym_filled=1,name=suffix+' mb',symbol='x',sym_size=symSize,sym_thick=symThick,sym_transparency=symTrans,dimensions=[1200,1000],margin=[150,100,30,30],/device,/overplot)
    plotArr=[temporary(plotArr),p1]
    for i=0,n_elements(varA)-1 do begin
      p90=plot([varX[i],varX[i]],[varAErrLow[i],varA[i]],thick=yBarThick,color=colorSet,transparency=barTrans,/overplot)
      p91=plot([varX[i]-lineWidth,varX[i]+lineWidth],[varAErrLow[i],varAErrLow[i]],thick=xBarThick,color=colorSet,linestyle=xBarStyle,transparency=barTrans,/overplot)

      p92=plot([varX[i],varX[i]],[varA[i],varAErrUp[i]],thick=yBarThick,color='green',transparency=barTrans,/overplot)
      p93=plot([varX[i]-lineWidth,varX[i]+lineWidth],[varAErrUp[i],varAErrUp[i]],thick=xBarThick,color='green',linestyle=xBarStyle,transparency=barTrans,/overplot)
    endfor
  endfor
  
  p1.font_size=22
  p1.xmajor=9
  p1.xtitle='Flight Level mb'
  p1.ytitle='Absolute Median Clear Air Uncertainty g m!u-3!n'
  
  l1=legend(target=plotArr,auto_text_color=1,font_size=22,shadow=0,/device)
  
  

stop


end