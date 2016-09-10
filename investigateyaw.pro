pro investigateYaw
  ;Use loop data for 082516, 082616
  
  restore,'saves/loopdatapac2526.sav'
;p1=plot(lwc)
  inds=[48846.:49400.]
  inds=filtliqLB(lwc,twodp,trf)
 
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
  cdpLwcB=cdpLwcB[inds]
  lwcub=lwcub[inds]
  stop
  

end