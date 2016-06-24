pro collectionEffJustification
  restore,'saves/loopdata.sav'
  
  ;l1=lp(vmd,coleliq) --- coleff liq gt .9 5 - 35 vmd
  
  cdpbinnsum=[]
  for i=0,n(cdpbinn[0,*]) do begin
    cdpbinnsum=[cdpbinnsum,total(cdpbinn[*,i])]
  endfor
  
  cdpbinnsum=cdpbinnsum[where (cdpbinnsum lt 1100)]
  
  valid=where(lwc gt .02 and finite(vmd) eq 1)
  
  vmd=vmd[valid]
  lwc=lwc[valid]
  
  less=total(vmd[where((vmd le 5 or vmd ge 35))])
  over=total(vmd[where(vmd ge 5 and vmd le 35)])
  all=less+over
  
  x=where(lwc gt .02)
  h1=hist(vmd[x],minval=1,binsize=1)
  h1B=histogram(vmd,min=2)
  stop
end
