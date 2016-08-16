pro collectionEffJustification
  restore,'saves/loopdata.sav'
  
  ;l1=lp(vmd,coleliq) --- coleff liq gt .9 5 - 35 vmd
  x=sort(vmd)
  vmd=vmd[x]
  coleliq=coleliq[x]
  coletot=coletot[x]
  p1=plot(vmd,coleliq,dimensions=[1200,1000],thick=3,'--')
  p2=plot(vmd,coletot,dimensions=[1200,1000],thick=3,'--r',/overplot)
  p1.xrange=[2,48]
  p1.yrange=[0,1]
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
  h1=hist(vmd[x],min=1,size=1)
  h1B=histogram(vmd,min=2)
  stop
end
