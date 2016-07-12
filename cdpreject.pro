pro cdpreject
  restore,'saves/loopdataCope.sav'


  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;Plots CDP count bin stats
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------




  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------

  liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and trf gt -3d and lwc gt .01 and lwc lt 1.3 and cdpconc lt 800) ;Cope

  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    dEff=dEff[liqonly]
    vvd=vvd[liqonly]
    vmd=vmd[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwcVarE=lwcVarE[liqonly]
    twcVarE=twcVarE[liqonly]
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    coleliq=coleliq[liqonly]
    coletot=coletot[liqonly]
    lwcErrColE=lwcErrColE[liqonly]
    cdptrans=cdptrans[liqonly]
    cdpacc=cdpacc[liqonly]
    cdpbinvar=cdpbinvar[liqonly]
    cdpbinkert=cdpbinkert[liqonly]
    cdpbinskew=cdpbinskew[liqonly]
    cdpbinbimod=cdpbinbimod[liqonly]
    cdpBinMAD=cdpBinMAD[liqonly]
    cdpBinSD=cdpBinSD[liqonly]
    cdpdofrej=cdpdofrej[liqonly]
    cdpadcover=cdpadcover[liqonly]
    cdpTransRej=cdpTransRej[liqonly]
  endif

  color=[color,color,color,color,color]

  ;-----------------------
  xVar=cdpacc
  yVar=cdptrans
  ;-----------------------
  
  ;-----------------------
  var=abs(cdplwc-lwc)/abs(lwc)
  ;-----------------------

  s1=scatterplot(xVar,yVar,dimensions=[1400,1000],margin=50,/device,sym_filled=1,sym_size=.4,sym_transparency=50,sym_color='black')
  s1.xrange=[0,3e4]
  ;s1.yrange=[0,3e4]

  
  
  startbin=-.5
  bininc=.1
  maxbin=.5
  binBounds=dindgen(ceil((maxbin-startbin)/bininc),start=startbin,increment=bininc)
  binBounds=[temporary(binBounds),maxbin]
  interFitVals=[]
  slopeFitVals=[]
  zeros=dindgen(100000)*0
  xS=dindgen(3e4+1.,start=0,increment=1)

  for i=1,n(binbounds) do begin
    print,binbounds[i-1],'-->',binbounds[i]
    sel=where(var ge binbounds[i-1] and var le binbounds[i])
    s1=scatterplot(xVar[sel],yVar[sel],sym_filled=1,sym_size=.4,sym_transparency=25,sym_color=color[i],/overplot)
    
    
    xVarFit=xVar[sel]
    yVarFit=yVar[sel]
    
    xVarFit=xVarFit[sort(xVarFit)]
    yVarFit=yVarFit[sort(yVarFit)]
    
    xVarFit=[xVarFit]
    yVarFit=[yVarFit]
    

    fit=ladfit(xVarFit,yVarFit)
    interFitVals=[temporary(interFitVals),fit[0]]
    slopeFitVals=[temporary(slopeFitVals),fit[1]]
  endfor
  
  for i=0,n(interFitVals) do begin
    fitPlot=plot(xS,interFitVals[i]+xS*slopeFitVals[i],color='black',thick=4,transparency=60,/overplot)
    fitPlot=plot(xS,interFitVals[i]+xS*slopeFitVals[i],color=color[i+1],thick=2,/overplot)
  endfor

end