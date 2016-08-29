pro calcK25hzLaramie




  suffix='0304'
  restore,'saves/loopdata'+suffix+'.sav'


  level=700
  kType='twc'
  pickPlot=0

  case level of
    700:begin
      inds=[480:5200]
    end
    600:begin
      inds=[6600:11270]
    end
    500:begin
      inds=[12460:18390]
    end
    400:begin
      inds=[20000:29200]
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

  p1=scatterplot(aias,k,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65,sym_color='black')

  if pickPlot eq 1 then begin
    x=where(avroll lt -1.7726989 and avroll gt -4.7847276)
    xvals=dindgen(n1(aias))
    p1=plot(aias,dimensions=[1200,900])
    s1=scatterplot(xvals[x],aias[x],/overplot,sym_color='red',symbol='.')
  endif



  case level of
    700:begin
      as1=[765,1065]
      as2=[2570,2870]
      as3=[3150,3450]
      as4=[4380,4680]
    end
    600:begin
      as1=[580,880]
      as2=[1580,1880]
      as3=[2350,2650]
      as4=[3550,3850] ;Bad LWC group
      as5=[4200,4500]
      
      ;W/ bad LWC group
;      as1=[580,880]
;      as2=[1580,1880]
;      as3=[3550,3850]
;      as4=[4350,4750] ;Bad LWC group
    end
    500:begin
      as1=[880,1180]
      as2=[1650,1950]
      as3=[2230,2530]
      as4=[3300,3500]
      as5=[3950,4250]
    end
    400:begin
      as1=[990,1290]
      as2=[1880,2180]
      ;as3=[4500,4800]
      as3=[2530,2830]
      as4=[5980,6280]
    end
  endcase



  if isa(as5) eq 1 and isa(as4) eq 1 then begin
    filtInds=[dindgen(as1[1]-as1[0]+1,start=as1[0]), dindgen(as2[1]-as2[0]+1,start=as2[0]), dindgen(as3[1]-as3[0]+1,start=as3[0]), $
      dindgen(as4[1]-as4[0]+1,start=as4[0]), dindgen(as5[1]-as5[0]+1,start=as5[0])]
  endif
  
  if isa(as4) eq 1 and isa(as5) eq 0 then begin
    filtInds=[dindgen(as1[1]-as1[0]+1,start=as1[0]), dindgen(as2[1]-as2[0]+1,start=as2[0]), dindgen(as3[1]-as3[0]+1,start=as3[0]), $
      dindgen(as4[1]-as4[0]+1,start=as4[0])]
  endif
  
  if isa(as3) eq 1 and isa(as4) eq 0 then begin
    filtInds=[dindgen(as1[1]-as1[0]+1,start=as1[0]), dindgen(as2[1]-as2[0]+1,start=as2[0]), dindgen(as3[1]-as3[0]+1,start=as3[0])]
  endif



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


  p1=scatterplot(aias,k,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65,sym_color='blue',/overplot)
  ;p1=scatterplot(aias,refp,dimensions=[900,740],sym_filled=1,sym_size=1.2,sym_transparency=65,sym_color='blue',/overplot)
  ;  p1.xrange=[62,96]
  ;  p1.yrange=[1.68,1.8]
  p1.font_size=26

  exp=comfit(aias,k,[1.,1.,1.],/exponential,yfit=yfitb,itmax=400,status=x)
  if x ne 0 then stop
  fitx=dindgen(1001,start=min(aias),increment=span(aias)/1000.)
  fity=exp[0]*exp[1]^fitx+exp[2]
  p2=plot(fitx,fity,'red',thick=2,/overplot)
  print,exp
  stop
end
