pro lwcProb0825
  restore,'saves/loopdata082516.sav'
  
  inds=[29002:45400]
  inds=where(lwc gt 0 and cdplwc gt 0 and trf gt -3. and twodp le 1 and cdpconc lt 200)
  inds=where(cdpconc eq 0 and twodp eq 0)
  vlwcref=vlwcref[inds]
  vlwccol=vlwccol[inds]
  vtwcref=vtwcref[inds]
  vtwccol=vtwccol[inds]
  ilwcref=ilwcref[inds]
  ilwccol=ilwccol[inds]
  itwcref=itwcref[inds]
  itwccol=itwccol[inds]
  aias=aias[inds]
  pmb=pmb[inds]
  avroll=avroll[inds]
  avpitch=avpitch[inds]
  betaAng=betaAng[inds]
  avyaw=avyaw[inds]
  tas=tas[inds]
  lwc100=lwc100[inds]
  lwc=lwc[inds]
  twodp=twodp[inds]
  vmd=vmd[inds]
  cdpconc=cdpconc[inds]
  
  
 p1=scatterplot(vmd,cdplwc/lwc-1.)
;  
;  p1=scatterplot(pmb[lwcClearAirI],lwc[lwcClearAirI],sym_color='blue',/overplot)

xs=dindgen(n1(pmb))
p1=plot(xs,vtwccol)
p2=plot(xs,vtwcref,'--r',/overplot)
  
  stop
end