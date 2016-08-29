pro orientationError
  restore, 'saves/loopdataaircraftOrientation.sav'
  filt=lwcclearairi
  lwc=lwc[filt]
  cdpacc=cdpacc[filt]
  cdpdofrej=cdpdofrej[filt]
  lwc100=lwc100[filt]
  lwcnev=lwcnev[filt]
  avroll=avroll[filt]
  avpitch=avpitch[filt]
  beta=beta[filt]
  hivs=hivs[filt]
  avyaw=avyaw[filt]


  h1=hist(lwc,size=.001)
  h1.xrange=[-.02,.03]
  h1.xtitle='Baseline LWC [g m!U-3!N]'
  h1.ytitle='Relative Frequency'
  h1.font_size=22
  stop
end