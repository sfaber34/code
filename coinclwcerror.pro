pro coincLwcError
  ;Use loop data for 082516, 082616

  restore,'saves/loopdatacope.sav'
  ;inds=filtliqLB(lwc,twodp,trf)
  inds=where(trf gt -3 and lwc gt .01 and cipmodconc0 lt 1)

  lwc=lwc[inds]
  twc=twc[inds]
  cdpdbar=cdpdbar[inds]
  cdpconc=cdpconc[inds]
  dEff=dEff[inds]
  vvd=vvd[inds]
  vmd=vmd[inds]
  cdplwc=cdplwc[inds]
  trf=trf[inds]
  cipmodconc0=cipmodconc0[inds]
  cipmodconc1=cipmodconc1[inds]
  cipmodconc2=cipmodconc2[inds]
  coleliq=coleliq[inds]
  coletot=coletot[inds]
  cdptrans=cdptrans[inds]
  cdpacc=cdpacc[inds]
  lwc100=lwc100[inds]
  ;lwcNev=lwcNev[inds]
  flightsec=flightsec[inds]
  pmb=pmb[inds]
  tas=tas[inds]
  aias=aias[inds]
  cdpdofrej=cdpdofrej[inds]
  avpitch=avpitch[inds]
  avroll=avroll[inds]
  avyaw=avyaw[inds]
 ; cdpLwcB=cdpLwcB[inds]
  ;lwcub=lwcub[inds]
  lwcnev=lwcnev[inds]
  twcnev=twcnev[inds]
  
  
  xvar=cdpconc
  yvar=cdptrans
  
  s1=scatter(xvar,yvar)
  
  binBounds=[0,.10,.20,.30,.40,.50,.60,.70]
  binVar=abs(cdplwc/lwc)-1.
  
  for i=0,n(binbounds)-1 do begin
    sel=where(binVar gt binBounds[i] and binVar lt binBounds[i+1])
    s2=scatterplot(xvar[sel],yvar[sel],sym_color=color[i+1],/overplot,sym_size=.4,sym_filled=1)
  endfor
  
  stop


end