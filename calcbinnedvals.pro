pro calcBinnedVals


  suffix='082516400'
  
  
  restore,'saves/loopdata'+suffix+'.sav'

  ;LIQUID ONLY POINTS OR ALL
  liq=1

  ;liqOnly=where(trf gt -3d and lwc gt .02 and lwc lt 1.3 and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1))
  ;liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and trf gt -3d and lwc lt 1.4 and lwc gt .01 and cdplwc gt .01 and cdpconc lt 200)
  
  concThresh=10
  
;  liqOnly=where(cdpconc le concThresh and shift(cdpconc,1) le concThresh and shift(cdpconc,2) le concThresh and shift(cdpconc,3) le concThresh and shift(cdpconc,4) le concThresh and shift(cdpconc,5) le concThresh $
;    and cdpconc le concThresh and shift(cdpconc,6) le concThresh and shift(cdpconc,7) le concThresh and shift(cdpconc,8) le concThresh and shift(cdpconc,9) le concThresh and shift(cdpconc,10) le concThresh $
;    and cdpconc le concThresh and shift(cdpconc,-1) le concThresh and shift(cdpconc,-2) le concThresh and shift(cdpconc,-3) le concThresh and shift(cdpconc,-4) le concThresh and shift(cdpconc,-5) le concThresh $
;    and cdpconc le concThresh and shift(cdpconc,-6) le concThresh and shift(cdpconc,-7) le concThresh and shift(cdpconc,-8) le concThresh and shift(cdpconc,-9) le concThresh and shift(cdpconc,-10) le concThresh)
;    liqOnly=where(cdpconc le concThresh)
;    
;  liqOnly=where(cdpconc le concThresh and trf gt -3 and twodp lt 1)

  liqOnly=filtliqLB(lwc,twodp,trf)
  
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
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    coleliq=coleliq[liqonly]
    coletot=coletot[liqonly]
    cdptrans=cdptrans[liqonly]
    cdpacc=cdpacc[liqonly]
    lwc100=lwc100[liqonly]
    ;lwcNev=lwcNev[liqonly]
    flightsec=flightsec[liqonly]
    pmb=pmb[liqonly]
    tas=tas[liqonly]
    aias=aias[liqonly]
    cdpdofrej=cdpdofrej[liqonly]
    avpitch=avpitch[liqonly]
    avroll=avroll[liqonly]
    avyaw=avyaw[liqonly]
    cdpLwcB=cdpLwcB[liqonly]
    lwcub=lwcub[liqonly]
    ;beta=beta[liqonly]
    ;hivs=hivs[liqonly]
  endif

  ;--------------------------------------------------------------------------------
  ;--------------------------------------------------------------------------------
  ;----------------------------------OPTIONS---------------------------------------
  var=vmd

  ;STARTING LEFT VALUE
  binstart=2d

  ;WIDTH OF BINS
  bininc=5d
  
  ;MAX BIN VALUE
  binEnd=50d
  
  
  
  
  ;--------------------------------------------------------------------------------
  ;--------------------------------------------------------------------------------
  ;--------------------------------------------------------------------------------
  
  
  
  
  
  

  saveName='calcBins'+suffix+'.sav'

  binBounds=dindgen(ceil((binEnd-binstart)/bininc),start=binstart,increment=bininc)
  binBounds=[binBounds,binEnd]
  
  binInds=make_array(n1(var),n1(binBounds))*!values.d_nan

  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------

  for i=1,n(binBounds) do begin
    selected=where(var ge binbounds[i-1] and var le binbounds[i])
    binInds[0:n(selected),i-1]=selected
  endfor


  coleControlLwc=[]
  coleControlTwc=[]
  colevarLwc=[]
  colevarTwc=[]
  lwctwc=[]
  binR=[]
  lwc100lwc=[]
  lwc100twc=[]
  lwc100lwc=[]
  lwc100twc=[]
  lwcDtwc=[]
  lwcDtwc=[]
  lwc100cdplwc=[]
  lwc100Mean=[]
  lwc100Lwcq1=[]
  lwc100Lwcq3=[]
  lwc100Cdplwcq1=[]
  lwc100Cdplwcq3=[]
  vmdMean=[]
  cdpDBarMean=[]
  binGeoMean=[]
  colELiqUPMean=[]
  colELiqUMean=[]
  lwcMean=[]
  pmbMed=[]
  vmdMed=[]
  lwctwcq1=[]
  lwctwcq3=[]
  cdpConcMean=[]
  xVarMean=[]
  lwcCAEMed=[]
  lwcCAEq1=[]
  lwcCAEq3=[]
  lwcCAEStdDev=[]
  lwcKormed=[]
  lwcKorq1=[]
  lwcKorq3=[]
  lwcTwcMed=[]
  lwcCdpMed=[]
  lwcCdpQ1=[]
  lwcCdpQ3=[]
  lwcKorDiffMed=[]
  lwcKorDiffQ1=[]
  lwcKorDiffQ3=[]
  twcCAEMed=[]
  twcCAEQ1=[]
  twcCAEQ3=[]


  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------CALC BINNED VALUES-------------------------------------------
  ;--------------------------------------------------------------------------------------------------------



  for i=0,n(bininds[0,*]) do begin

    preBins=bininds[*,i]
    bins=preBins[where(finite(preBins) eq 1)]
    if bins[0] eq -1 or finite(bins[0]) eq 0 then break
    
    print,min(var[bins]),'----',max(var[bins]),'---->',n1(bins)
    
    
    
    
    
    ;----------LWC V TWC------------
    lwcTwcMed=[lwcTwcMed,med(twc[bins])/med(lwc[bins])-1.]
    lwcTwcQ1=[lwcTwcQ1,(q1(twc[bins]/lwc[bins])-1.)]
    lwcTwcQ3=[lwcTwcQ3,(q3(twc[bins]/lwc[bins])-1.)]
    
    
    ;----------LWC V CDP------------
    lwcCdpMed=[lwcCdpMed,med(cdpLwc[bins])/med(lwc[bins])-1.]
    lwcCdpQ1=[lwcCdpQ1,(q1(cdpLwc[bins]/lwc[bins])-1.)]
    lwcCdpQ3=[lwcCdpQ3,(q3(cdpLwc[bins]/lwc[bins])-1.)]

    coleControlTwc=[coleControlTwc,mean(lwc[bins])/mean(twc[bins])]
    coleControlLwc=[coleControlLwc,mean(twc[bins])/mean(lwc[bins])]
    colevarTwc=[colevarTwc,mean(lwcVarE[bins])/mean(twc[bins])]
    colevarLwc=[colevarLwc,mean(twcVarE[bins])/mean(lwc[bins])]

    lwc100lwc=[lwc100lwc,mean(lwc[bins])/mean(lwc100[bins])]
    lwc100twc=[lwc100twc,mean(twcVarE[bins])/mean(lwc100[bins])]
    lwc100cdplwc=[lwc100cdplwc,mean(cdplwc[bins])/mean(lwc100[bins])]
    
    vmdMean=[vmdMean,mean(vmd[bins])]
    cdpDBarMean=[cdpDBarMean,mean(cdpdbar[bins])]
    lwcMean=[lwcMean,mean(lwc[bins])]
    cdpConcMean=[temporary(cdpConcMean),mean(cdpConc[bins])]

    ;----------LWC V KOROLEV LWC---------------
    
    if isa(lwcnev) eq 1 then begin
      match,bins,fin(lwcnev),amatch,bmatch
      matched=bins[amatch]
      lwcKorMed=[lwcKorMed,(med(lwc[bins])/med(lwcnev[bins]))-1.]
      lwcKorq1=[lwcKorq1,(q1(lwc[bins]/lwcnev[bins])-1.)]
      lwcKorq3=[lwcKorq3,(q3(lwc[bins]/lwcnev[bins])-1.)]
      lwcKorDiffMed=[lwcKorDiffMed,med(lwc[bins])-med(lwcnev[bins])]
      lwcKorDiffq1=[lwcKorDiffq1,q1(lwc[bins]-lwcnev[bins])]
      lwcKorDiffq3=[lwcKorDiffq3,q3(lwc[bins]-lwcnev[bins])]
    endif
    


    lwc100KLwc=lwc[bins]/lwc100[bins]
    lwc100Lwcsort=sort(lwc100KLwc)
    lwc100Lwcsorted=lwc100KLwc[lwc100Lwcsort]


    lwc100KCdplwc=cdplwc[bins]/lwc100[bins]
    lwc100KCdplwcsort=sort(lwc100KCdplwc)
    lwc100KCdplwcsorted=lwc100KCdplwc[lwc100KCdplwcsort]


    pmbMed=[pmbMed,mean(pmb[bins])]
    vmdMed=[vmdMed,mean(vmd[bins])]
    
;    match,bins,lwcclearairi,amatch,bmatch
;    matched=bins[amatch]
;    lwcCAEMed=[lwcCAEMed,med(lwcnpc[matched])]
;    lwcCAEq1=[lwcCAEq1,q1(lwcnpc[matched])]
;    lwcCAEq3=[lwcCAEq3,q3(lwcnpc[matched])]
;    lwcCAEStdDev=[lwcCAEStdDev,stddev(lwcnpc[matched])]


      lwcCAEMed=[lwcCAEMed,med(abs(lwc[bins]))]
      lwcCAEq1=[lwcCAEq1,q1(abs(lwc[bins]))]
      lwcCAEq3=[lwcCAEq3,q3(abs(lwc[bins]))]
      
      twcCAEMed=[twcCAEMed,med(abs(twc[bins]))]
      twcCAEq1=[twcCAEq1,q1(abs(twc[bins]))]
      twcCAEq3=[twcCAEq3,q3(abs(twc[bins]))]


  endfor
  
  xVarMean=(binBounds+shift(binBounds,-1))/2.
  xVarMean=xVarMean[0:n1(xVarMean,-2)]
  xVar=xVarMean

  save,filename='saves/'+saveName,coleControlLwc,coleControlTwc,$
    colevarLwc,colevarTwc,pmbMed,$
    lwc100cdplwc,lwcMean,cdpConcMean,lwcTwcMed,$
    lwc100twc,lwc100lwc,lwctwcq1,lwctwcq3,$
    color,vmdMean,vmdMed,xVar,lwcKorDiffMed,lwcKorDiffQ1,lwcKorDiffQ3,$
    lwcCdpq1,lwcCdpq3,lwcCdpMed,cdpDBarMean,twcCAEMed,twcCAEQ1,twcCAEQ3,$
    lwcCAEMed,lwcCAEq1,lwcCAEq3,lwcKorMed,lwcKorQ1,lwcKorQ3
    





end
