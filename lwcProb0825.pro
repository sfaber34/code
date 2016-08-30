pro lwcProb0825
  restore,'saves/loopdata082516400.sav'
  
  ;inds=filtliqLTB(lwc,twc,twodp,trf)
  inds=filtliqLB(lwc,twodp,trf)
  
  
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
  twc=twc[inds]
  twodp=twodp[inds]
  vmd=vmd[inds]
  cdpconc=cdpconc[inds]
  cdplwc=cdplwc[inds]
  cdpTrans=cdpTrans[inds]
  cdpdofrej=cdpdofrej[inds]
  cdpacc=cdpacc[inds]
  
  
 p1=scatterplot(cdplwc/lwc-1.,cdpdofrej/cdpacc)
;  
;  p1=scatterplot(pmb[lwcClearAirI],lwc[lwcClearAirI],sym_color='blue',/overplot)

xs=dindgen(n1(pmb))
p1=plot(xs,vtwccol)
p2=plot(xs,vtwcref,'--r',/overplot)
  
  stop
end