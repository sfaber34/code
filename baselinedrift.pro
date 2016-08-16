pro baselineDrift
  restore,'saves/loopdatadrift.sav'
  
  x=dindgen(n1(pmb))
  p1=plot(x,lwc,dimensions=[1200,1000],font_size=22,thick=2,name='LWC')
  p2=plot(x,lwcPLiqFix,'r',/overplot,thick=2,name='LWC w Fixed k')
  p2.xrange=[6300,8200]
  p2.yrange=[-.05,.1]
  l1=legend(position=[.3,1],target=[p1,p2],shadow=0,font_size=22)
  stop
end