pro compareSigs
restore,'saves/loopdatacals.sav'

for i=0,1 do begin
  inds=where(flightDayN eq i)
  vlwccol=vlwccol[inds]
  vlwcref=vlwcref[inds]
  ilwccol=ilwccol[inds]
  ilwcref=ilwcref[inds]
  vtwccol=vtwccol[inds]
  vtwcref=vtwcref[inds]
  itwccol=itwccol[inds]
  itwcref=itwcref[inds]
  
  vlwccol=vlwccol[0:25000]
  vlwcref=vlwcref[0:25000]
  ilwccol=ilwccol[0:25000]
  ilwcref=ilwcref[0:25000]
  vtwccol=vtwccol[0:25000]
  vtwcref=vtwcref[0:25000]
  itwccol=itwccol[0:25000]
  itwcref=itwcref[0:25000]
  
  if i eq 0 then begin
    vlwccolA=vlwccol
    vlwcrefA=vlwcref
    ilwccolA=ilwccol
    ilwcrefA=ilwcref
    vtwccolA=vtwccol
    vtwcrefA=vtwcref
    itwccolA=itwccol
    itwcrefA=itwcref
  endif else begin
    vlwccolB=vlwccol
    vlwcrefB=vlwcref
    ilwccolB=ilwccol
    ilwcrefB=ilwcref
    vtwccolB=vtwccol
    vtwcrefB=vtwcref
    itwccolB=itwccol
    itwcrefB=itwcref
  endelse
endfor

stop

end