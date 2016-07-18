pro calcLaramieK

  nclPath='../data/20160304.c1.nc'

  ;liquid reference voltage [V]
  vlwcref=loadvar('vlwcref', filename=nclPath)
  
  ;liquid collector voltage [V]
  vlwccol=loadvar('vlwccol', filename=nclPath)
  
  ;total reference voltage [V]
  vtwcref=loadvar('vtwcref', filename=nclPath)
  
  ;total collector voltage [V]
  vtwccol=loadvar('vtwccol', filename=nclPath)
  
  ;liquid reference current [A]
  ilwcref=loadvar('ilwcref', filename=nclPath)
  
  ;liquid collector current [A]
  ilwccol=loadvar('ilwccol', filename=nclPath)
  
  ;total reference current [A]
  itwcref=loadvar('itwcref', filename=nclPath)
  
  ;total collector current [A]
  itwccol=loadvar('itwccol', filename=nclPath)
  
  ;reverse flow static temperature [C]
  trf=loadvar('trf', filename=nclPath)
  
  ;true airspeed [m/s]
  tas=loadvar('tas', filename=nclPath)
  
  ;indicated airspeed [knot]
  aias=loadvar('aias', filename=nclPath)
  aias=aias*.514444
  
  pmb=loadvar('pmb', filename=nclPath)
  
  avroll=loadvar('avroll', filename=nclPath)
  avpitch=loadvar('avpitch', filename=nclPath)
  
  
  
  inds=[1262:2210]
  
  vlwcref=vlwcref[inds]
  vlwccol=vlwccol[inds]
  vtwcref=vtwcref[inds]
  vtwccol=vtwccol[inds]
  ilwcref=ilwcref[inds]
  ilwccol=ilwccol[inds]
  itwcref=itwcref[inds]
  itwccol=itwccol[inds]
  aias=aias[inds]
  pmb=pmb[inds]
  avroll=avroll[inds]
  avpitch=avpitch[inds]
    
  
  as1=[249,276]
  as2=[385,412]
  as3=[538,570]
  as4=[677,715]
  as5=[915,948]
 
  
  filtInds=[dindgen(as1[1]-as1[0]+1,start=as1[0]), dindgen(as2[1]-as2[0]+1,start=as2[0]), dindgen(as3[1]-as3[0]+1,start=as3[0]), $
    dindgen(as4[1]-as4[0]+1,start=as4[0]), dindgen(as5[1]-as5[0]+1,start=as5[0])]
    
    
  vlwcref=vlwcref[filtinds]
  vlwccol=vlwccol[filtinds]
  vtwcref=vtwcref[filtinds]
  vtwccol=vtwccol[filtinds]
  ilwcref=ilwcref[filtinds]
  ilwccol=ilwccol[filtinds]
  itwcref=itwcref[filtinds]
  itwccol=itwccol[filtinds]
  aias=aias[filtinds]
  pmb=pmb[filtinds]
  avroll=avroll[filtinds]
  avpitch=avpitch[filtinds]
    
    
    
  lwcColP=vtwccol*itwccol
  lwcRefP=vtwcRef*itwcRef
  lwcK=lwcColP/lwcRefP
  
  
  p1=scatterplot(aias,lwcK,dimensions=[1200,1600])
  
  poly=poly_fit(aias,lwcK,2,yfit=yfit)
  p2=plot(aias,yfit,'red',/overplot)
  
  ;(-0.0126704)*tas^(0.698457)+(2.01460)
  geo=comfit(aias,lwcK,[-0.0126704,0.698457,2.01460],/geometric,yfit=yfitb,itmax=400)
  p2=plot(aias,yfitb,'green',/overplot)
  stop
end