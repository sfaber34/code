pro histogram2


  liq=1

  binint=7.
  
  binsize=1.
  
  restore,'loopdata.sav'

  liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and cdpMassMean lt 40.)




    bincount=60/(binsize*2.)
    ticks=string(dindgen(bincount,start=minbin,increment=binsize*2))


  ticks=[1:n_elements(ticks)]

  ticks=strsplit(ticks,'.',/extract)

  ticks2=make_array(n_elements(ticks),/string)
  for u=0,n_elements(ticks)-1 do begin
    ticks2[u]=ticks[u,0]
  endfor

  ticks=[strcompress(ticks2),' ',' ']




  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpDEff=cdpDEff[liqonly]
    cdpVolMean=cdpVolMean[liqonly]
    cdpMassMean=cdpMassMean[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwcExE=lwcExE[liqonly]
    twcExE=twcExE[liqonly]
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    coleliq=coleliq[liqonly]
    coletot=coletot[liqonly]
  endif



  h1=histogram(cdpMassMean,min=binint,binsize=1.)
  
  p1=barplot(dindgen(n_elements(h1),start=binint,increment=1),h1, histogram=1,dimensions=[1600,1200],margin=[110,70,30,20],/device)
  
  p1.xtitle='VMD um'
  p1.ytitle='Frequency'
  
  p1.font_size=22

  stop
end