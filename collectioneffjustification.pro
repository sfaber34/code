pro collectionEffJustification
  restore,'saves/loopdatacope.sav'
  
  ;l1=lp(vmd,coleliq) --- coleff liq gt .9 5 - 35 vmd
  ;
;  x=sort(vmd)
;  vmd=vmd[x]
;  coleliq=coleliq[x]
;  coletot=coletot[x]
;  p1=plot(vmd,coleliq,dimensions=[1200,1000],thick=4,'--',name='LWC Sensor')
;  p2=plot(vmd,coletot,dimensions=[1200,1000],thick=4,'--r',/overplot,name='TWC Sensor')
;  p1.xrange=[2,48]
;  p1.yrange=[0,1]
;  p1.font_size=26
;  p1.xtitle='Droplet VMD [um]'
;  p1.ytitle='Droplet Collection Efficiency'
;  p1.xmajor=9
;  
;  l1=legend(target=[p1,p2],position=[.9,.67],font_size=26)

  
;  valid=where(lwc gt .02 and finite(vmd) eq 1)
;  
;  vmd=vmd[valid]
;  lwc=lwc[valid]
;  
;  less=total(vmd[where((vmd le 5 or vmd ge 35))])
;  over=total(vmd[where(vmd ge 5 and vmd le 35)])
;  all=less+over
  
  y=where(lwc gt 0.005 and trf gt -3)
  h1=hist(vmd[y],min=2,size=2)
  h1.xminor=0
  h1.font_size=22
  h1.xrange=[2,48]
  stop
end
