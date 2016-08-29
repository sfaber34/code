pro checkBLError
  restore, 'saves/loopdatalar.sav'
  
  concThresh=0
  filt=where(cdpconc le concThresh and shift(cdpconc,1) le concThresh and shift(cdpconc,2) le concThresh and shift(cdpconc,3) le concThresh and shift(cdpconc,4) le concThresh and shift(cdpconc,5) le concThresh $
    and cdpconc le concThresh and shift(cdpconc,-1) le concThresh and shift(cdpconc,-2) le concThresh and shift(cdpconc,-3) le concThresh and shift(cdpconc,-4) le concThresh and shift(cdpconc,-5) le concThresh $
    and lwc gt 0)
    
  lwc=lwc[filt]
  cdpacc=cdpacc[filt]
  cdpdofrej=cdpdofrej[filt]
  lwc100=lwc100[filt]
  if isa(lwcnev) eq 1 then lwcnev=lwcnev[filt]
  
  
  h1=hist(lwc,size=.001,min=-.02)
  h1.xtitle='Baseline LWC [g m!U-3!N]'
  h1.ytitle='Relative Frequency'  
  h1.font_size=22
  h1.xrange=[-.022,.014]
  stop
end