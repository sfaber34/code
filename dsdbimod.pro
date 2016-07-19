pro dsdBimod

  restore,'saves/loopdatacope1hz.sav'
  
  x=where(cdpBinSecSum gt 50)
 
  ;h1=hist(cdpBinN[13817])
  p1=plot(cdpBinBimod)
  stop
end