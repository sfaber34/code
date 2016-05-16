pro lwc100ErrorBars





  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------COLE SCATTER----------------------------------------------
  ;--------------------------------------------------------------------------------------------------------




  cgcleanup


  xs=dindgen(501,start=0,increment=.1)

  ;p1=scatterplot(korX,korY,sym_color=grey,sym_size=.1,symbol=0,dimensions=[1600,1200])



  restore,'colesavefile.sav'
  ;restore,'colesavefileB.sav'
  
  ;-----PLOT OPTIONS------
  
  varX=lwc100Mean
  varA=lwc100vlwc
  varAErrUp=LWC100VLWCQ3
  varAErrLow=LWC100VLWCQ1
  varB=lwc100Vcdplwc


  varAx=dindgen(n_elements(varA),start=binintstart,increment=.25)
  varBx=dindgen(n_elements(varB),start=minbin,increment=.5)
  hErr=dindgen(n_elements(varA),start=2.,increment=0)
  yErr=dindgen(n_elements(varA),start=0,increment=0)
  
  

  p5=scatterplot(varX,varA,sym_thick=2,sym_color='black',sym_filled=1,dimensions=[1600,1200])
  
  for i=0,n_elements(varA)-1 do begin
    p90=plot([varX[i],varX[i]],[varA[i],varA[i]-varAErrLow[i]],thick=2,/overplot)
    p91=plot([varX[i]-.04,varX[i]+.04],[varA[i]-varAErrLow[i],varA[i]-varAErrLow[i]],thick=2,/overplot,'r')
    
    p92=plot([varX[i],varX[i]],[varA[i],varA[i]+varAErrUp[i]],thick=2,/overplot)
    p93=plot([varX[i]-.04,varX[i]+.04],[varA[i]+varAErrUp[i],varA[i]+varAErrUp[i]],thick=2,/overplot)
  endfor
  
  
  p6=scatterplot(varX,varB,sym_thick=2,sym_color='red',sym_filled=1,/overplot)
  
  
  p66=plot([0,3.5],[1,1],color='grey',linestyle=2, thick=2,/overplot)
  
  
  p5.xrange=[0,3.5]
  p5.yrange=[0,2]
  p5.xtitle='VMD um'
  p5.ytitle='LWC/TWC'




  p5.font_size=22


end