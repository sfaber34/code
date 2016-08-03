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
  
  

  ;inds=[1262:2210] ;700 mb
  inds=[2478:3437] ;600 mb
  ;inds=[3755:4847] ;500 mb
  ;inds=[5288:6930] ;400 mb
  
  
  
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
  
  p1=plot(aias,margin=50,/device,dimensions=[1400,1100])
  
;  p2=plot(avroll,margin=50,/device,dimensions=[1400,1100],layout=[1,2,1],'b')
;  p3=plot(avpitch,margin=50,/device,dimensions=[1400,1100],layout=[1,2,2],'r',/current)
    
    
    
  ;--700mb--  
;  as1=[228,278]
;  as2=[385,412]
;  as3=[538,588]
;  as4=[650,700]
;  as5=[839,889]

;--600mb--
  as1=[148,198]
  as2=[320,370]
  as3=[490,540]
  as4=[723,773]
  as5=[492,493]
  
  ;--500mb--
;  as1=[80,130]
;  as2=[250,300]
;  as3=[365,415]
;  as4=[590,640]
;  as5=[706,756]
  
  ;--400mb--
;  as1=[90,140]
;  as2=[265,315]
;  as3=[410,460]
;  as4=[411,412]
;  as5=[1380,1430]
 
  
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

