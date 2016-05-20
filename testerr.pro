pro testErr
  restore,'loopdata.sav'
  
  
  p1=plot(lwc[2200:2800],dimensions=[1600,1200])
  p2=plot(lwcVarE[2200:2800],/overplot,'r')
  p3=plot(lwcErrColE[2200:2800],/overplot,'g')
end