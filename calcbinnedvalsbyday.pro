pro calcBinnedValsByDay


  suffix='cals'


  restore,'saves/loopdata'+suffix+'.sav'

  ;LIQUID ONLY POINTS OR ALL
  liq=1


  ;liqOnly=where(trf gt -3d and lwc gt .02 and lwc lt 1.3 and (cipmodconc0 lt .1 and finite(cipmodconc0) eq 1))
  ;liqOnly=where((cipmodconc0 lt .1 and finite(cipmodconc0) eq 1) and trf gt -3d and lwc lt 1.4 and lwc gt .01 and cdplwc gt .01 and cdpconc lt 200)

  concThresh=0
  
  liqOnly=where(cdpconc le concThresh and shift(cdpconc,1) le concThresh and shift(cdpconc,2) le concThresh and shift(cdpconc,3) le concThresh and shift(cdpconc,4) le concThresh and shift(cdpconc,5) le concThresh $
    and cdpconc le concThresh and shift(cdpconc,6) le concThresh and shift(cdpconc,7) le concThresh and shift(cdpconc,8) le concThresh and shift(cdpconc,9) le concThresh and shift(cdpconc,10) le concThresh $
    and cdpconc le concThresh and shift(cdpconc,-1) le concThresh and shift(cdpconc,-2) le concThresh and shift(cdpconc,-3) le concThresh and shift(cdpconc,-4) le concThresh and shift(cdpconc,-5) le concThresh $
    and cdpconc le concThresh and shift(cdpconc,-6) le concThresh and shift(cdpconc,-7) le concThresh and shift(cdpconc,-8) le concThresh and shift(cdpconc,-9) le concThresh and shift(cdpconc,-10) le concThresh $,
    and (twodp lt .05 or finite(twodp) eq 0))
  ;    liqOnly=where(cdpconc le concThresh)

  ;liqOnly=where(twodp lt 1. and trf gt -3. and lwc gt .01 and cdpconc lt 200 and vmd gt 8 and vmd lt 28)

  ;liqOnly=filtliqLB(lwc,twodp,trf)

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
    lwclb=lwclb[liqonly]
    beta=beta[liqonly]
    lwcsurf=lwcsurf[liqonly]
    ;hivs=hivs[liqonly]
    lwcnpc=lwcnpc[liqonly]
    pliqnpc=pliqnpc[liqonly]
    pLiqSurf=pLiqSurf[liqonly]
    flightDayN=flightDayN[liqonly]
    lwc700=lwc700[liqonly]
    lwc600=lwc600[liqonly]
    lwc500=lwc500[liqonly]
    lwc400=lwc400[liqonly]
    den=den[liqonly]
    twodp=twodp[liqonly]
  endif

  ;--------------------------------------------------------------------------------
  ;--------------------------------------------------------------------------------
  ;----------------------------------OPTIONS---------------------------------------





  saveName='calcBinsByDay'+suffix+'.sav'

 
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
  lwcCdpLb=[]
  lwcCdpUb=[]
  lwcSurfCAEMed=[]
  lwcSurfCAEq1=[]
  lwcSurfCAEq3=[]
  pliqSlopeMed=[]
  pliqSlopeq1=[]
  pliqSlopeq3=[]
  vlwccolMean=[]
  vlwcrefMean=[]
  ilwccolMean=[]
  ilwcrefMean=[]
  pmbMean=[]
  aiasMean=[]
  trfMean=[]
  lwc700Med=[]
  lwc700Q1=[]
  lwc700Q3=[]
  lwc600Med=[]
  lwc600Q1=[]
  lwc600Q3=[]
  lwc500Med=[]
  lwc500Q1=[]
  lwc500Q3=[]
  lwc400Med=[]
  lwc400Q1=[]
  lwc400Q3=[]
  day=[]


  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------CALC BINNED VALUES-------------------------------------------
  ;--------------------------------------------------------------------------------------------------------

  posDay=dindgen(30,start=0)
 
  for i=0,n(posDay) do begin

    bins=where(flightDayN eq posDay[i])
    if bins[0] eq -1 or finite(bins[0]) eq 0 then break

    ;print,min(var[bins]),'----',max(var[bins]),'---->',n1(bins)

    
    ;den=pmb*1d2/(287.*(trf+273.15))


    ;----------LWC V TWC------------
    lwcTwcMed=[lwcTwcMed,med(twc[bins])/med(lwc[bins])-1.]
    lwcTwcQ1=[lwcTwcQ1,(q1(twc[bins]/lwc[bins])-1.)]
    lwcTwcQ3=[lwcTwcQ3,(q3(twc[bins]/lwc[bins])-1.)]


    ;----------LWC V CDP------------
    lwcCdpMed=[lwcCdpMed,med(cdpLwc[bins])/med(lwc[bins])-1.]
    lwcCdpUb=[lwcCdpUb,med(cdpLwc[bins])/med(lwcub[bins])-1.]
    lwcCdpLb=[lwcCdpLb,med(cdpLwc[bins])/med(lwclb[bins])-1.]
    lwcCdpQ1=[lwcCdpQ1,(q1(cdpLwc[bins]/lwc[bins])-1.)]
    lwcCdpQ3=[lwcCdpQ3,(q3(cdpLwc[bins]/lwc[bins])-1.)]

    coleControlTwc=[coleControlTwc,mean(lwc[bins])/mean(twc[bins])]
    coleControlLwc=[coleControlLwc,mean(twc[bins])/mean(lwc[bins])]

    lwc100lwc=[lwc100lwc,mean(lwc[bins])/mean(lwc100[bins])]
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


    lwcCAEMed=[lwcCAEMed,med(lwcNPC[bins])]
    lwcCAEq1=[lwcCAEq1,q1(lwcNPC[bins])]
    lwcCAEq3=[lwcCAEq3,q3(lwcNPC[bins])]
    
    
    
    
    lwc700Med=[lwc700Med,med(lwc700[bins])]
    lwc700Q1=[lwc700Q1,Q1(lwc700[bins])]
    lwc700Q3=[lwc700Q3,Q3(lwc700[bins])]

    lwc600Med=[lwc600Med,med(lwc600[bins])]
    lwc600Q1=[lwc600Q1,Q1(lwc600[bins])]
    lwc600Q3=[lwc600Q3,Q3(lwc600[bins])]

    lwc500Med=[lwc500Med,med(lwc500[bins])]
    lwc500Q1=[lwc500Q1,Q1(lwc500[bins])]
    lwc500Q3=[lwc500Q3,Q3(lwc500[bins])]

    lwc400Med=[lwc400Med,med(lwc400[bins])]
    lwc400Q1=[lwc400Q1,Q1(lwc400[bins])]
    lwc400Q3=[lwc400Q3,Q3(lwc400[bins])]
    
    
    

    pliqSlopeMed=[pliqSlopeMed,med(pliqnpc[bins])/med(aias[bins])]
    pliqSlopeQ1=[pliqSlopeQ1,q1(pliqnpc[bins]/aias[bins])]
    pliqSlopeQ3=[pliqSlopeQ3,q3(pliqnpc[bins]/aias[bins])]
    
    lwcSurfCAEMed=[lwcSurfCAEMed,med(lwcSurf[bins])]
    lwcSurfCAEq1=[lwcSurfCAEq1,q1(lwcSurf[bins])]
    lwcSurfCAEq3=[lwcSurfCAEq3,q3(lwcSurf[bins])]

    twcCAEMed=[twcCAEMed,med(abs(twc[bins]))]
    twcCAEq1=[twcCAEq1,q1(abs(twc[bins]))]
    twcCAEq3=[twcCAEq3,q3(abs(twc[bins]))]
    
    vlwccolMean=[vlwccolMean,mean(vlwccol[bins])]
    vlwcrefMean=[vlwcrefMean,mean(vlwcref[bins])]
    ilwccolMean=[ilwccolMean,mean(ilwccol[bins])]
    ilwcrefMean=[ilwcrefMean,mean(ilwcref[bins])]
    
    pmbMean=[pmbMean,mean(pmb[bins])]
    aiasMean=[aiasMean,mean(aias[bins])]
    trfMean=[trfMean,mean(trf[bins])]

    day=[day,posDay[i]]

  endfor
 ;     writename=strcompress('meanFlightCar.csv')
 ;     xtickname=['030416','081816','112415','121715','012015','012515','030715','082516','082616','090416','090916','091016','091316','091616','092316']
;      write_csv,writename,xtickname,vlwccolMean,vlwcrefMean,ilwccolMean,ilwcrefMean
 ;      write_csv,writename,xtickname,pmbMean,aiasMean,trfMean
  xVar=day

  save,filename='saves/'+saveName,coleControlLwc,coleControlTwc,$
    colevarLwc,colevarTwc,pmbMed,lwcCdpUb,lwcCdpLb,$
    lwc100cdplwc,lwcMean,cdpConcMean,lwcTwcMed,vlwccolMean,vlwcrefMean,ilwccolMean,ilwcrefMean,$
    lwc100twc,lwc100lwc,lwctwcq1,lwctwcq3,pliqSlopeMed,pliqSlopeq1,pliqSlopeq3,$
    color,vmdMean,vmdMed,xVar,lwcKorDiffMed,lwcKorDiffQ1,lwcKorDiffQ3,pmbMean,aiasMean,$
    lwcCdpq1,lwcCdpq3,lwcCdpMed,cdpDBarMean,twcCAEMed,twcCAEQ1,twcCAEQ3,trfMean,$
    lwcCAEMed,lwcCAEq1,lwcCAEq3,lwcKorMed,lwcKorQ1,lwcKorQ3,lwcSurfCAEMed,lwcSurfCAEq1,lwcSurfCAEQ3,$
    lwc700Med,lwc700Q1,lwc700Q3,lwc600Med,lwc600Q1,lwc600Q3,$
    lwc500Med,lwc500Q1,lwc500Q3,lwc400Med,lwc400Q1,lwc400Q3






end
