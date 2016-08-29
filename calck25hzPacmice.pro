pro calcK25hzPacmice

  


  suffix='081816'
  restore,'saves/loopdata'+suffix+'.sav'


  level=600
  kType='twc'
  pickPlot=0

  case level of
    700:begin
      inds=[200:4730] 
    end
    600:begin
      inds=[5820:10300]
    end
    500:begin
      inds=[2500:3350]
    end
    400:begin
      inds=[3640:4380]
    end
    else: inds=[0:n1(pmb)]
  endcase

  

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
  betaAng=betaAng[inds]
  avyaw=avyaw[inds]
  tas=tas[inds]
  
  
  if kType eq 'lwc' then begin
    ColP=vlwccol*ilwccol
    RefP=vlwcRef*ilwcRef
  endif else begin
    ColP=vtwccol*itwccol
    RefP=vtwcRef*itwcRef
  endelse
  
  k=ColP/Refp
  
  ;p1=scatterplot(aias,k,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65,sym_color='black')

  if pickPlot eq 1 then begin
    x=where(abs(avroll) lt 8.6 and avpitch gt -1.8 and avpitch lt 7.2)
    p1=plot(aias,dimensions=[1200,900])
    ;s1=scatterplot(aias[x],/overplot,sym_color='red',symbol='.')
  endif
  


  case level of
    700:begin
      as1=[570,870]
      as2=[1570,1870]
      as3=[2100,2400]
      as4=[3050,3350]
      as5=[4020,4320]
    end
    600:begin
      as1=[200,500]
      as2=[960,1260]
      as3=[1890,2190]
      as4=[2890,3190]
      as5=[4000,4300]
    end
    500:begin
      as1=[105,165]
      as2=[305,365]
      as3=[430,490]
      as4=[745,805]
    end
    400:begin
      as1=[74,134]
      as2=[240,300]
      as3=[410,470]
      as4=[600,660]
    end
  endcase
  


  if isa(as5) eq 1 then begin
    filtInds=[dindgen(as1[1]-as1[0]+1,start=as1[0]), dindgen(as2[1]-as2[0]+1,start=as2[0]), dindgen(as3[1]-as3[0]+1,start=as3[0]), $
      dindgen(as4[1]-as4[0]+1,start=as4[0]), dindgen(as5[1]-as5[0]+1,start=as5[0])]
  endif else begin
    filtInds=[dindgen(as1[1]-as1[0]+1,start=as1[0]), dindgen(as2[1]-as2[0]+1,start=as2[0]), dindgen(as3[1]-as3[0]+1,start=as3[0]), $
      dindgen(as4[1]-as4[0]+1,start=as4[0])]
  endelse
  


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
  tas=tas[filtinds]


  if kType eq 'lwc' then begin
    ColP=vlwccol*ilwccol
    RefP=vlwcRef*ilwcRef
  endif else begin
    ColP=vtwccol*itwccol
    RefP=vtwcRef*itwcRef
  endelse
  
  k=ColP/RefP


  p1=scatterplot(aias,ColP,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65,sym_color='blue',/overplot)
  p1=scatterplot(aias,REfP,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65,sym_color='red',/overplot)
  
  l1=linfit(aias,ColP)
  l2=linfit(aias,REfP)
  
  xs=dindgen(1001,start=min(aias),increment=span(aias)/1000.)
  
  f1l=plot(xs,l1[0]+l1[1]*xs,'b',/overplot)
  f2l=plot(xs,l2[0]+l2[1]*xs,'r',/overplot)
 
 
  p1.font_size=26
stop
  exp=comfit(aias,k,[1.,1.,1.],/exponential,yfit=yfitb,itmax=400,status=x)
  if x ne 0 then stop
  fitx=dindgen(1001,start=min(aias),increment=span(aias)/1000.)
  fity=exp[0]*exp[1]^fitx+exp[2]
  p2=plot(fitx,fity,'red',thick=2,/overplot)
  print,exp
  stop
end
