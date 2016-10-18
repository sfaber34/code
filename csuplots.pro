pro csuPlots
  restore,'saves/loopdata082616fixed.sav'
  restore,'inds.sav'
  concThresh=1
;  inds=where(cdpconc le concThresh and shift(cdpconc,1) le concThresh and shift(cdpconc,2) le concThresh and shift(cdpconc,3) le concThresh and shift(cdpconc,4) le concThresh and shift(cdpconc,5) le concThresh $
;    and cdpconc le concThresh and shift(cdpconc,6) le concThresh and shift(cdpconc,7) le concThresh and shift(cdpconc,8) le concThresh and shift(cdpconc,9) le concThresh and shift(cdpconc,10) le concThresh $
;    and cdpconc le concThresh and shift(cdpconc,-1) le concThresh and shift(cdpconc,-2) le concThresh and shift(cdpconc,-3) le concThresh and shift(cdpconc,-4) le concThresh and shift(cdpconc,-5) le concThresh $
;    and cdpconc le concThresh and shift(cdpconc,-6) le concThresh and shift(cdpconc,-7) le concThresh and shift(cdpconc,-8) le concThresh and shift(cdpconc,-9) le concThresh and shift(cdpconc,-10) le concThresh $,
;    and lwc lt .009 and twodp lt 0.0001)
    
    
    
  p1=scatter(pmb[inds],twc[inds],symcol='blue')

end