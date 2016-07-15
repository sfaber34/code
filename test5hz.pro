pro test5hz
  
  

  restore,'saves/loopdatalaramie1hz.sav'
  x1hz=dindgen(n1(tas))
  p1=plot(x1hz,cdplwc,dimensions=[1600,1200])
  
  restore,'saves/loopdatalaramie5hz.sav'
  x5hz=dindgen(n1(tas))/5.
  p2=plot(x5hz,cdplwc,'red',/overplot)
  stop
end