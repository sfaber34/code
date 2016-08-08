pro calcBinnedVals


  suffix='lar700'
  
  
  restore,'saves/loopdata'+suffix+'.sav'

  ;LIQUID ONLY POINTS OR ALL
  liq=0

  ;liqOnly=where(trf gt -3d and lwc gt .02 and lwc lt 1.3 and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1))
  liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1))

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
    lwcNev1=lwcNev1[liqonly]
    flightsec=flightsec[liqonly]
    pmb=pmb[liqonly]
    ;lwcnoprescor=lwcnoprescor[liqonly]
    tas=tas[liqonly]
    aias=aias[liqonly]
    lwcClearAir=lwcclearair[liqonly]
  endif




  ;-------------------------------SET VAR---------------------------------------
  var=pmb
  ;-------------------------------SET VAR---------------------------------------

  ;STARTING LEFT VALUE
  binstart=500d

  ;WIDTH OF BINS
  bininc=50d
  
  ;MAX BIN VALUE
  binEnd=750d
  
  
  
  
  ;-----------------------------------------------------------------------------
  
  
  
  
  
  

  saveName='calcBins'+suffix+'.sav'

  binBounds=dindgen(ceil((binEnd-binstart)/bininc),start=binstart,increment=bininc)
  binBounds=[binBounds,binEnd]
  
  binInds=make_array(n1(pmb),n1(binBounds))*!values.d_nan

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
  colevarbothLwc=[]
  colevarbothTwc=[]
  cdpVlwc=[]
  cdpVtwc=[]
  cdpVLwcCor=[]
  cdpVTwcCor=[]
  cdpVlwcSD=[]
  cdpVtwcSD=[]
  cdpVLwcCorSD=[]
  cdpVTwcCorSD=[]
  cole11con=[]
  cole12con=[]
  cole13con=[]
  cole14con=[]
  colevarLwc2=[]
  colevarbothTwc2=[]
  lwctwc=[]
  lwctwc2=[]
  binR=[]
  lwc100Vlwc=[]
  lwc100Vtwc=[]
  lwc100Vlwc=[]
  lwc100Vtwc=[]
  lwcDtwc=[]
  lwcDtwc=[]
  vmdGeoMean=[]
  colevarTwcB=[]
  colevarLwcB=[]
  lwcq1=[]
  lwcq3=[]
  twcq1=[]
  twcq3=[]
  lwc100Vcdplwc=[]
  lwc100Mean=[]
  lwc100VLwcq1=[]
  lwc100VLwcq3=[]
  lwc100VCdplwcq1=[]
  lwc100VCdplwcq3=[]
  vmdMean=[]
  cdpDBarMean=[]
  cdpVlwcq1=[]
  cdpVlwcq3=[]
  lwcVcdpq1=[]
  lwcVcdpq3=[]
  lwcVcdp=[]
  binGeoMean=[]
  colELiqUPMean=[]
  colELiqUMean=[]
  lwcMean=[]
  lwcOoc=[]
  lwcOocq1=[]
  lwcOocq3=[]
  pmbMed=[]
  lwcOocSDev=[]
  vmdMed=[]
  lwctwcq1=[]
  lwctwcq3=[]
  cdpVtwcQ1=[]
  cdpVtwcQ3=[]
  cdpConcMean=[]
  xVarMean=[]
  lwcCAEMed=[]
  lwcCAEq1=[]
  lwcCAEq3=[]
  lwcCAEStdDev=[]



  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------CALC BINNED VALUES-------------------------------------------
  ;--------------------------------------------------------------------------------------------------------



  for i=0,n(bininds[0,*]) do begin

    preBins=bininds[*,i]
    bins=preBins[where(finite(preBins) eq 1)]
    if bins[0] eq -1 or finite(bins[0]) eq 0 then break
    
    print,min(var[bins]),'----',max(var[bins])

    coleControlTwc=[coleControlTwc,mean(lwc[bins])/mean(twc[bins])]
    coleControlLwc=[coleControlLwc,mean(twc[bins])/mean(lwc[bins])]
    colevarTwc=[colevarTwc,mean(lwcVarE[bins])/mean(twc[bins])]
    colevarLwc=[colevarLwc,mean(twcVarE[bins])/mean(lwc[bins])]
    colevarTwcB=[colevarTwcB,mean(lwc[bins])/mean(twcVarE[bins])]
    colevarLwcB=[colevarLwcB,mean(twc[bins])/mean(lwcVarE[bins])]
    colevarbothTwc=[colevarbothTwc,mean(lwcVarE[bins])/mean(twcVarE[bins])]
    colevarbothLwc=[colevarbothLwc,mean(twcVarE[bins])/mean(lwcVarE[bins])]
    cdpVlwc=[cdpVlwc,med(lwc[bins])/med(cdplwc[bins])-1.]
    cdpVLwcQ1=[cdpVLwcQ1,cdpVlwc[i]-stddev(lwc[bins]/cdplwc[bins]-1.,/nan)]
    cdpVLwcQ3=[cdpVLwcQ3,cdpVlwc[i]+stddev(lwc[bins]/cdplwc[bins]-1.,/nan)]
    lwcVCdp=[lwcVCdp,abs(med(cdplwc[bins])/med(lwc[bins]))-1.]
    cdpVtwc=[cdpVtwc,mean(cdplwc[bins])/mean(twc[bins])]    
    cdpVLwcCor=[cdpVLwcCor,mean(cdplwc[bins])/mean(lwcVarE[bins])]
    cdpVTwcCor=[cdpVTwcCor,mean(cdplwc[bins])/mean(twcVarE[bins])]
    ;lwctwc=[lwctwc,(med(twc[bins])-med(lwc[bins]))/abs(med(lwc[bins]))]
    ;lwctwcq1=[lwctwcq1,(q1(twc[bins])-q1(lwc[bins]))/abs(q1(lwc[bins]))]
    ;lwctwcq3=[lwctwcq3,(q3(twc[bins])-q3(lwc[bins]))/abs(q3(lwc[bins]))]
    lwc100Vlwc=[lwc100Vlwc,mean(lwcVarE[bins])/mean(lwc100[bins])]
    lwc100Vtwc=[lwc100Vtwc,mean(twcVarE[bins])/mean(lwc100[bins])]
    lwc100Vcdplwc=[lwc100Vcdplwc,mean(cdplwc[bins])/mean(lwc100[bins])]
    vmdMean=[vmdMean,mean(vmd[bins])]
    cdpDBarMean=[cdpDBarMean,mean(cdpdbar[bins])]
    lwcMean=[lwcMean,mean(lwc[bins])]
    cdpConcMean=[temporary(cdpConcMean),mean(cdpConc[bins])]
    ;xVarMean=[temporary(xVarMean),((binStart+binInc*(i+1.))-(binStart+binInc*i))/2.+binInc*i]



    twcK=lwc[bins]/twc[bins]
    lwcK=twc[bins]/lwc[bins]
    lwcfixedsort=sort(twcK)
    lwcsorted=twcK[lwcfixedsort]
    twcfixedsort=sort(lwcK)
    twcsorted=lwcK[twcfixedsort]


    lwc100KLwc=lwc[bins]/lwc100[bins]
    lwc100Lwcsort=sort(lwc100KLwc)
    lwc100Lwcsorted=lwc100KLwc[lwc100Lwcsort]


    lwc100KCdplwc=cdplwc[bins]/lwc100[bins]
    lwc100KCdplwcsort=sort(lwc100KCdplwc)
    lwc100KCdplwcsorted=lwc100KCdplwc[lwc100KCdplwcsort]


    lwcRatio=lwc[bins]/lwc100[bins]
    twcRatio=twc[bins]/lwc100[bins]

    lwcRatiosort=sort(lwcRatio)
    lwcRatiosorted=lwcRatio[lwcRatiosort]

    twcRatiosort=sort(twcRatio)
    twcRatiosorted=twcRatio[twcRatiosort]


    lwcVCdpDist=(lwc[bins]-cdplwc[bins])/lwc[bins]
    lwcVCdpDistS=sort(lwcVCdpDist)
    lwcVCdpDistSD=lwcVCdpDist[lwcVCdpDistS]

    cdpVLwcDist=(cdplwc[bins]-lwc[bins])/cdplwc[bins]
    cdpVLwcDistS=sort(cdpVLwcDist)
    cdpVLwcDistSD=cdpVLwcDist[cdpVLwcDistS]



    lwcq1=[lwcq1,mean(lwc[bins])/mean(twc[bins])-lwcsorted[n_elements(lwcsorted)*.25]]
    lwcq3=[lwcq3,lwcsorted[n_elements(lwcsorted)*.75]-mean(lwc[bins])/mean(twc[bins])]
    twcq1=[twcq1,mean(twc[bins])/mean(lwc[bins])-twcsorted[n_elements(twcsorted)*.25]]
    twcq3=[twcq3,twcsorted[n_elements(twcsorted)*.75]-mean(twc[bins])/mean(lwc[bins])]
    lwc100VLwcq1=[lwc100VLwcq1,lwc100Lwcsorted[n_elements(lwc100Lwcsorted)*.25]]
    lwc100VLwcq3=[lwc100VLwcq3,lwc100Lwcsorted[n_elements(lwc100Lwcsorted)*.75]]
    lwc100VCdplwcq1=[lwc100VCdplwcq1,mean(lwc100[bins])/mean(cdplwc[bins])-lwc100KCdplwcsorted[n_elements(lwc100KCdplwcsorted)*.25]]
    lwc100VCdplwcq3=[lwc100VCdplwcq3,lwc100Lwcsorted[n_elements(lwc100KCdplwcsorted)*.75]-mean(lwc100[bins])/mean(cdplwc[bins])]


;    lwcOoc=[lwcOoc,(med(abs(lwcnoprescor[bins])))]
;    lwcOocq1=[lwcOocq1,q1(abs(lwcnoprescor[bins]))]
;    lwcOocq3=[lwcOocq3,q3(abs(lwcnoprescor[bins]))]
;    lwcOocSDev=[lwcOocSDev,(stddev(abs(lwcnoprescor[bins])))]
;    pmbMed=[pmbMed,mean(pmb[bins])]
;    vmdMed=[vmdMed,mean(vmd[bins])]
    
    match,bins,lwcclearairi,amatch,bmatch
    matched=bins[amatch]
    lwcCAEMed=[lwcCAEMed,mean(abs(lwcnpc[matched]))]
    lwcCAEq1=[lwcCAEq1,q1(abs(lwcnpc[matched]))]
    lwcCAEq3=[lwcCAEq3,q3(abs(lwcnpc[matched]))]
    lwcCAEStdDev=[lwcCAEStdDev,stddev(abs(lwcnpc[matched]))]


  endfor
  xVarMean=(binBounds+shift(binBounds,-1))/2.
  xVarMean=xVarMean[0:n1(xVarMean,-2)]
  xVar=xVarMean

  save,filename='saves/'+saveName,coleControlLwc,coleControlTwc,vmdGeoMean,$
    colevarLwc,colevarTwc,colevarbothLwc,colevarbothTwc,binsizestart,$
    binintstart,cdpVlwc,cdpVtwc,colevarLwc2,pmbMed,cdpVtwcQ1,cdpVtwcQ3,$
    colevarbothTwc2,lwctwc,lwctwc2,minbin,lwc100Vcdplwc,lwcMean,cdpConcMean,$
    lwc100Vtwc,lwc100Vlwc,lwc100Vtwc,lwc100Mean,colELiqUMean,lwctwcq1,lwctwcq3,$
    lwcq1,lwcq3,twcq1,twcq3,color,vmdMean,cdpVlwcq1,cdpVlwcq3,vmdMed,xVar,$
    lwc100VLwcq1,lwc100VLwcq3,lwc100VCdplwcq1,lwc100VCdplwcq3,lwcOocSDev,$
    lwcVcdpq1,lwcVcdpq3,lwcVCdp,cdpDBarMean,binGeoMean,lwcOoc,lwcOocq1,lwcOocq3,$
    lwcCAEMed,lwcCAEq1,lwcCAEq3,lwcCAEStdDev





end
