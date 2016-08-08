pro blSelectEx
  suffix='lar700'

  restore,'saves/loopdata'+suffix+'.sav'
  
  flightsec=flightsec/5.
  
  p1=plot(flightsec,vtwccol,dimensions=[1300,1000],thick=2,margin=100,/device,font_size=26)
  ;p1.xrange=[750/5.,2250/5.]
  ;p1.yrange=[4.88,5.15]
  
  
;  sm1=ts_smooth(vlwccol,250)
;  p3=plot(flightsec,sm1-(sm1-correctionLiq),/overplot,'r')
  
  
  s1=scatterplot(flightsec[twcClearAirI],vtwccol[twcClearAirI],sym_color='blue',symbol='.',sym_size=3,sym_filled=1,/overplot)
  
  stop
end