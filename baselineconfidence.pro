pro baselineConfidence
  restore,'saves/loopdata.sav'
  
  ;filt=where()
  
  s1=scatterplot(trf,(abs(twc-twcfixedlv)/abs(twcfixedlv))*100d,dimensions=[1400,1000],margin=50,/device)
stop
end