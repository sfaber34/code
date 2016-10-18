pro comparePacFits


  pmb=dindgen(500,start=800,increment=-1)
  aias=dindgen(500,start=60,increment=.08)
  aias=100

  coef=[2.238,-0.0003147,-0.007652,9.983e-08,2.815e-06,2.037e-05 ] ;For LAR
  kLiqSurf = (coef[0]) + coef[1]*pmb + coef[2]*aias + coef[3]*pmb^2. + coef[4]*pmb*aias + coef[5]*aias^2.
  
  
  
  savename=['pacFitAll700','pacFitAll600','pacFitAll500','pacFitAll400']
  
  for i=0,n(savename) do begin
    filename='saves/loopdata'+savename[i]+'.sav'
    restore,filename
    
    concThresh=0
    x=where(cdpconc le concThresh and shift(cdpconc,1) le concThresh and shift(cdpconc,2) le concThresh and shift(cdpconc,3) le concThresh and shift(cdpconc,4) le concThresh and shift(cdpconc,5) le concThresh $
    and cdpconc le concThresh and shift(cdpconc,6) le concThresh and shift(cdpconc,7) le concThresh and shift(cdpconc,8) le concThresh and shift(cdpconc,9) le concThresh and shift(cdpconc,10) le concThresh $
    and cdpconc le concThresh and shift(cdpconc,-1) le concThresh and shift(cdpconc,-2) le concThresh and shift(cdpconc,-3) le concThresh and shift(cdpconc,-4) le concThresh and shift(cdpconc,-5) le concThresh $
    and cdpconc le concThresh and shift(cdpconc,-6) le concThresh and shift(cdpconc,-7) le concThresh and shift(cdpconc,-8) le concThresh and shift(cdpconc,-9) le concThresh and shift(cdpconc,-10) le concThresh)
    lwcnpc=lwcnpc[x]
    pmb=pmb[x]
    aias=aias[x]
    
    p1=scatter(pmb,lwcnpc,symcol=color[i],/op)
  endfor
  
  
end