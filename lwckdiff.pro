pro lwcKDiff

  restore,'loopdata.sav'

  ;LIQUID ONLY POINTS OR ALL
  liq=0

  colorSelect=''


  liqOnly=where(trf gt -3. and lwc gt .02)

  if liq eq 1 then begin
    lwc=lwc[liqonly]
    lwcvare=lwcvare[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    dEff=dEff[liqonly]
    vvd=vvd[liqonly]
    vmd=vmd[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    cdpTrans=cdpTrans[liqonly]
    tas=tas[liqonly]
  endif
  
  yVar=abs(lwcnoprescor-lwcnev1)/abs(lwcnev1)
  yVar=f(yVar)

  s1=scatterplot(tas,yVar,dimensions=[1600,1000],sym_size=.5,sym_transparency=70,sym_filled=1)
  
  
end  