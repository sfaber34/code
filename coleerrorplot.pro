pro coleerrorplot


  cgcleanup


  xs=dindgen(501,start=0,increment=.1)

  restore,'colesavefile.sav'
  restore,'colesavefileB.sav'

  ;-----PLOT OPTIONS------

  xLow=0.
  xHigh=50.
  yLow=0.
  yHigh=1.3


  varXA=binGeoMean
  varAData=lwcVCdp
  varAErrLowData=lwcVCdpQ1
  varAErrUpData=lwcVCdpQ3
  varXB=binGeoMeanB
  varBData=lwcVCdpB
  varBErrLowData=lwcVCdpQ1B
  varBErrUpData=lwcVCdpQ3B
  
  varA=lwcmean 
  varAErrUp=colELiqUMean
  varAErrLow=varAErrLowData*100.
  varB=varBData*100.
  varBErrLow=varBErrLowData*100.
  varBErrUp=varBErrUpData*100.
  
  
  symColor='Navy'
  ;symColorB='Red'


  varAx=dindgen(n_elements(varA),start=binintstart,increment=.25)
  varBx=dindgen(n_elements(varB),start=minbin,increment=.5)
  hErr=dindgen(n_elements(varA),start=2.,increment=0)
  yErr=dindgen(n_elements(varA),start=0,increment=0)



  p5=scatterplot(varXA,varA,sym_thick=2,sym_color=symColor,sym_filled=1,dimensions=[1600,1200])
  ;p6=scatterplot(varXB,varB,sym_thick=2,sym_color=symColorB,sym_filled=1,/overplot)


  xErrBar=(.5/abs(xHigh-xLow))*abs(xHigh-xLow)
  
  for i=0,num(vara) do begin
    p92=plot([varXA[i],varXA[i]],[varA[i],varAErrUp[i]+varA[i]],thick=2,color=symColor,/overplot)
    p93=plot([varXA[i]-xErrBar,varXA[i]+xErrBar],[varAErrUp[i]+varA[i],varAErrUp[i]+varA[i]],color=symColor,thick=2,/overplot)
  endfor
  
  
  
;  for i=0,n_elements(varB)-1 do begin
;    p94=plot([varXB[i],varXB[i]],[varBErrLow[i],varB[i]],thick=2,color=symColorB,/overplot)
;    p95=plot([varXB[i]-xErrBar,varXB[i]+xErrBar],[varBErrLow[i],varBErrLow[i]],color=symColorB,thick=2,/overplot)
;  
;    p96=plot([varXB[i],varXB[i]],[varB[i],varBErrUp[i]],thick=2,color=symColorB,/overplot)
;    p97=plot([varXB[i]-xErrBar,varXB[i]+xErrBar],[varBErrUp[i],varBErrUp[i]],color=symColorB,thick=2,/overplot)
;  endfor


  p5.xrange=[xLow,xHigh]
  p5.yrange=[yLow,yHigh]  
  p5.xtitle='VMD um'
  p5.ytitle='LWC/TWC'
  p5.yticklen=1
  p5.ygridstyle=0
  p5.ysubgridstyle=1



  p5.font_size=22


end