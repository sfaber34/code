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
  
  ;inds=[2130:3500] ;COPE 400 mb
  
  xVals=dindgen(max(inds)-min(inds),start=0)
  
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
  
  ;p1=plot(dindgen(n1(aias))/60.,aias,margin=100,/device,dimensions=[1400,1100],thick=2)
  ;p1.xrange=[0,15.98]
  
;  p2=plot(avroll,margin=50,/device,dimensions=[1400,1100],layout=[1,2,1],'b')
;  p3=plot(avpitch,margin=50,/device,dimensions=[1400,1100],layout=[1,2,2],'r',/current)
    
   x=where(abs(avroll) lt 8.6)
   p1=plot(xVals,aias)
   s1=scatterplot(xVals[x],aias[x],/overplot,sym_color='red',symbol='.')

    
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


;--COPE 400mb--
;  as1=[135,185]
;  as2=[290,350]
;  as3=[420,480]
;  as4=[700,760]
;  as5=[886,946]
 
  
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
  
  
  p1=scatterplot(aias,lwcK,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65)
;  p1.xrange=[62,96]
;  p1.yrange=[1.68,1.8]
  p1.font_size=26
  
  exp=comfit(aias,lwcK,[1.,1.,1.],/exponential,yfit=yfitb,itmax=400,status=x)

  fitx=dindgen(1001,start=min(aias),increment=span(aias)/1000.)
  fity=exp[0]*exp[1]^fitx+exp[2]
  p2=plot(fitx,fity,'red',thick=2,/overplot)
  print,exp
stop
end
