pro blSelectEx
  suffix='0807'

  restore,'saves/loopdata'+suffix+'.sav'
  
  flightsec=flightsec/5.
  
  p1=plot(flightsec,vlwccol/vlwcref,dimensions=[1400,780],thick=1,font_size=26)
  
  ;thresh=threshliq[0]
  thresh=0
  
  p1.xrange=[3800,4800]
  p1.yrange=[1.63,1.8]
  p3=plot(smliqx/5.,smliq+thresh,/overplot,'--r',thick=2)
  p4=plot(smliqx/5.,smliq,/overplot,'r',thick=2)
  
  
;  sm1=ts_smooth(vlwccol,250)
  
  
  
  s5=scatterplot(flightsec[lwcClearAirI],vlwccol[lwcClearAirI]/vlwcref[lwcClearAirI],sym_color='blue',symbol='.',sym_transparency=40,sym_size=4,sym_filled=1,/overplot)
  s5.xtitle='Flight Time [sec]'
  s5.ytitle='V!DLWC COL!N / V!DLWC REF'
  
  p6=plot(flightsec,lwc,dimensions=[1400,780],thick=1,font_size=26)
  p6.xrange=p1.xrange
  s7=scatterplot(flightsec[lwcClearAirI],lwc[lwcClearAirI],sym_color='blue',symbol='.',sym_transparency=40,sym_size=4,sym_filled=1,/overplot)
  s7.xtitle='Flight Time [sec]'
  s7.ytitle='LWC'
  s7.yrange=[-.02,.4]
  stop
end