pro lwcVcdpBinConcVAveTrans
  restore,'saves/loopdataCope.sav'
  
  
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;Plots LWC v. LWC/CDP percent difference binned by CDP conc v. Ave Trans
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  
  
  

  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------

  liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and trf gt -3d and lwc gt .01 and lwc lt 1.3) ;Cope

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
  endif
  
  color=[color,color,color,color,color]

  
  
  
  var=[]
  for j=0,n(lwc) do begin
    varb=linfit([0,cdpconc[j]],[0,cdptrans[j]])
    var=[temporary(var),varb[1]]
  endfor
  
  s1=scatterplot(cdptrans,(cdplwc/lwc)-1.,dimensions=[1400,1000],margin=50,/device,sym_filled=1,sym_size=.4,sym_transparency=70,sym_color='black')
  
  startbin=1.5
  bininc=.15
  maxbin=5.
  binBounds=dindgen(ceil((maxbin-startbin)/bininc),start=startbin,increment=bininc)
  binBounds=[temporary(binBounds),maxbin]


 

  for i=1,n1(binbounds) do begin
    sel=where(var ge binbounds[i-1] and var le binbounds[i])
    s2=scatterplot(lwc[sel],cdplwc[sel]-lwc[sel],/device,sym_filled=1,sym_size=.4,sym_transparency=40,sym_color=color[i],/overplot)
  endfor

  stop
end