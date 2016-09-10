pro calcK25hzPacmice

  
  cu

  suffix='081816'
  restore,'saves/loopdata'+suffix+'.sav'

  level=600
  kType='lwc'
  pickPlot=1

  case level of
    700:begin
      inds=[200:4730] 
    end
    600:begin
      inds=[5820:10300]
    end
    500:begin
      inds=[12450:16650]
    end
    400:begin
      inds=[18190:21911]
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
  ;betaAng=betaAng[inds]
  avyaw=avyaw[inds]
  tas=tas[inds]
  lwc100=lwc100[inds]
  lwc=lwc[inds]
  twodp=twodp[inds]

  
  ;p1=scatterplot(aias,k,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65,sym_color='black')

  if pickPlot eq 1 then begin
    x=where(abs(avroll) lt 8.6 and avpitch gt -1.8 and avpitch lt 7.2)
    xs=dindgen(n1(aias))
    p1=plot(xs/5.,aias,dimensions=[1200,900])
    ;s1=scatterplot(aias[x],/overplot,sym_color='red',symbol='.')
    stop
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
      as1=[450,750]
      as2=[1600,1900]
      as3=[2200,2500]
      as4=[3800,4100]
    end
    400:begin
      as1=[500,800]
      as2=[1100,1400]
      as3=[2200,2500]
      as4=[3050,3350]
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
    
    ColPR=vlwccol^2./rLwcCol
    RefPR=vlwcRef^2./rLwcRef
  endif else begin
    ColP=vtwccol*itwccol
    RefP=vtwcRef*itwcRef
    
    ColPR=vtwccol^2./rTwcCol
    RefPR=vtwcRef^2./rTwcRef
  endelse
  
  k=ColP/Refp
  kR=ColPR/RefpR


  p1=scatterplot(aias,k,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65,sym_color='blue',/overplot)
  p2=scatterplot(aias,kR,dimensions=[900,740],sym_filled=0,sym_size=1.2,sym_transparency=65,sym_color='red',/overplot)
  bounds=p1.xrange
;  l1=linfit(aias,ColP)
;  l2=linfit(aias,REfP)
;  
;  xs=dindgen(1001,start=min(aias),increment=span(aias)/1000.)
;  
;  f1l=plot(xs,l1[0]+l1[1]*xs,'b',/overplot)
;  f2l=plot(xs,l2[0]+l2[1]*xs,'r',/overplot)
 
 
  p1.font_size=26
  fitx=dindgen(1001,start=min(aias),increment=span(aias)/1000.)
  a=[5.649e-05,-0.01383,1.525,-0.001142]
  tryY=a[0]*exp(a[1]*fitx) + a[2]*exp(a[3]*fitx)
  tryY=a[0]*fitx^2.+a[1]*fitx+a[2]
  p2=plot(fitx,tryY,/overplot)
  p2.xrange=bounds


  exp=comfit(aias,k,a,/exponential,yfit=yfitb,status=x)
  if x ne 0 then stop
  
  fity=exp[0]*exp[1]^fitx+exp[2]
  p2=plot(fitx,fity,'red',thick=2,/overplot)
  print,exp
  stop
end
