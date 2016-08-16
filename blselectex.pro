pro blSelectEx
  suffix='lar700'

  restore,'saves/loopdata'+suffix+'.sav'
  
  flightsec=flightsec/5.
  
  p1=plot(flightsec,vlwccol,dimensions=[1300,1000],thick=1,margin=[150,100,40,40],/device,font_size=26)
  
  p1.xrange=[4746,4890]
  p1.yrange=[4.94780,5.0357706]
  p3=plot(smliqx/5.,smliq+0.01324319,/overplot,'--r',thick=2)
  p4=plot(smliqx/5.,smliq,/overplot,'r',thick=2)
  
  
;  sm1=ts_smooth(vlwccol,250)
  
  
  
  s1=scatterplot(flightsec[lwcClearAirI],vlwccol[lwcClearAirI],sym_color='blue',symbol='.',sym_transparency=40,sym_size=4,sym_filled=1,/overplot)
  s1.xtitle='Flight Time [sec]'
  s1.ytitle='LWC Collector Voltage'
  
  stop
end