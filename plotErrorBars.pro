pro ploterrorbars





  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------PLOTS SCATTERS WITH ERROR BARS
  ;------------------------------------------USE CALCBINNEDVALS BEFOREHAND
  ;--------------------------------------------------------------------------------------------------------





  xs=dindgen(501,start=0,increment=.1)

  ;p1=scatterplot(korX,korY,sym_color=grey,sym_size=.1,symbol=0,dimensions=[1600,1200])



  restore,'calFLEff900.sav'
  ;restore,'colesavefileB.sav'
  
  ;-----PLOT OPTIONS------
  
  varX=pmbMed
  varA=lwcooc
  varAErrUp=lwcoocq3
  varAErrLow=lwcoocq1
  varB=lwc100Vcdplwc


  varAx=dindgen(n_elements(varA),start=binintstart,increment=.25)
  varBx=dindgen(n_elements(varB),start=minbin,increment=.5)
  hErr=dindgen(n_elements(varA),start=2.,increment=0)
  yErr=dindgen(n_elements(varA),start=0,increment=0)
  
  lineRange=10.
  color='red'

  p5=scatterplot(varX,varA,sym_thick=2,sym_color=color,sym_filled=1,dimensions=[1600,1200],/overplot)
  
  for i=0,n_elements(varA)-1 do begin
    p90=plot([varX[i],varX[i]],[varA[i],varAErrLow[i]],thick=2,color=color,/overplot)
    p91=plot([varX[i]-lineRange,varX[i]+lineRange],[varAErrLow[i],varAErrLow[i]],thick=2,color=color,/overplot)
    
    p92=plot([varX[i],varX[i]],[varA[i],varAErrUp[i]],thick=2,color=color,/overplot)
    p93=plot([varX[i]-lineRange,varX[i]+lineRange],[varAErrUp[i],varAErrUp[i]],thick=2,color=color,/overplot)
  endfor
  
 
  




  p5.font_size=22


end