pro calcBinnedVals




  plots=1

  ;STARTING LEFT VALUE
  binint=400d
  binintstart=binint

  ;WIDTH OF BINS
  binsize=50.
  binsizestart=binsize

  ;LIQUID ONLY POINTS OR ALL
  liq=1
  
  saveName='calFLEff900.sav'


  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------




  restore,'loopdata900.sav'

  liqOnly=clearAirLiq

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
    colELiqUP=colELiqUP[liqonly]
    colELiqU=colELiqU[liqonly]
    lwcNev1=lwcNev1[liqonly]
    flightsec=flightsec[liqonly]
    pmb=pmb[liqonly]
    lwcnoprescor=lwcnoprescor[liqonly]
  endif

  minbin=binint


  ;-------------------------------SET VAR---------------------------------------
  var=pmb
  ;-------------------------------SET VAR---------------------------------------


  binint2=binint+binsize


  binstart=[]
  binend=[]
  binindex=[]
  binistarti=[]
  biniendi=[]
  binscon=[]
  countscon=[]
  ncountscon=[0]
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



  starti=0
  endi=0

  binNum=ceil(max(var)/binsize)

  for i=0,binNum do begin
    selectinds=where(var ge binint and var le binint2)

    if binint lt max(var) then begin

      vmdGeoMean=[vmdGeoMean,(min(vmd[selectinds])+max(vmd[selectinds]))/2.]
      lwc100Mean=[lwc100Mean,(min(lwc100[selectinds])+max(lwc100[selectinds]))/2.]

      binindex=[binindex,selectinds]
      binistarti=[binistarti,starti]

      endi=starti+n_elements(selectinds)
      biniendi=[biniendi,endi-1]

    endif
    starti=endi



    binint=binint+binsize
    binint2=binint2+binsize
  endfor




  for i=0,n_elements(binistarti)-1 do begin

    bins=double(binindex[binistarti[i]:biniendi[i]])
    binscon=[binscon,bins]
    countscon=double([countscon,n_elements(bins)])

  endfor




  ncountscon=dindgen(n_elements(binistarti),start=ncountscon, increment=0)




  ;--------------------------------------------------------------------------------------------------------
  ;------------------------------------------LWC VS LWC,TWC DIFF-------------------------------------------
  ;--------------------------------------------------------------------------------------------------------





  zeros=dindgen(100000,start=0,increment=0)
  twos=dindgen(100000,start=0,increment=0)

  count=0.
  for i=0,n_elements(binistarti)-1 do begin

    bins=binindex[binistarti[i]:biniendi[i]]
    binscon=[binscon,bins]
    countscon=[countscon,n_elements(bins)]





    coleControlTwc=[coleControlTwc,mean(lwc[bins])/mean(twc[bins])]
    coleControlLwc=[coleControlLwc,mean(twc[bins])/mean(lwc[bins])]    
    colevarTwc=[colevarTwc,mean(lwcVarE[bins])/mean(twc[bins])]
    colevarLwc=[colevarLwc,mean(twcVarE[bins])/mean(lwc[bins])]
    colevarTwcB=[colevarTwcB,mean(lwc[bins])/mean(twcVarE[bins])]
    colevarLwcB=[colevarLwcB,mean(twc[bins])/mean(lwcVarE[bins])]
    colevarbothTwc=[colevarbothTwc,mean(lwcVarE[bins])/mean(twcVarE[bins])]
    colevarbothLwc=[colevarbothLwc,mean(twcVarE[bins])/mean(lwcVarE[bins])]
    cdpVlwc=[cdpVlwc,(mean(cdplwc[bins])-mean(lwc[bins]))/mean(cdplwc[bins])]
    lwcVCdp=[lwcVCdp,(mean(lwc[bins])-mean(cdplwc[bins]))/mean(lwc[bins])]
    cdpVtwc=[cdpVtwc,mean(cdplwc[bins])/mean(twc[bins])]
    cdpVLwcCor=[cdpVLwcCor,mean(cdplwc[bins])/mean(lwcVarE[bins])]
    cdpVTwcCor=[cdpVTwcCor,mean(cdplwc[bins])/mean(twcVarE[bins])]
    lwctwc=[lwctwc,mean(lwcVarE[bins])/mean(twcVarE[bins])]
    lwc100Vlwc=[lwc100Vlwc,mean(lwcVarE[bins])/mean(lwc100[bins])]
    lwc100Vtwc=[lwc100Vtwc,mean(twcVarE[bins])/mean(lwc100[bins])]
    lwc100Vcdplwc=[lwc100Vcdplwc,mean(cdplwc[bins])/mean(lwc100[bins])]
    vmdMean=[vmdMean,mean(vmd[bins])]
    cdpDBarMean=[cdpDBarMean,mean(cdpdbar[bins])]
    binGeoMean=[binGeoMean,binintstart+binsizestart*(i+1.)-.5*binsizestart]
    lwcMean=[lwcMean,mean(lwc[bins])]
    colELiqUMean=[colELiqUMean,mean(colELiqU[bins])]




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
    cdpVlwcq1=[cdpVlwcq1,cdpVLwcDistSD[n_elements(cdpVLwcDistSD)*.25]]
    cdpVlwcq3=[cdpVlwcq3,cdpVLwcDistSD[n_elements(cdpVLwcDistSD)*.75]]
    lwcVcdpq1=[lwcVcdpq1,lwcVCdpDistSD[n_elements(lwcVCdpDistSD)*.25]]
    lwcVcdpq3=[lwcVcdpq3,lwcVCdpDistSD[n_elements(lwcVCdpDistSD)*.75]]
    
    lwcOoc=[lwcOoc,(med(abs(lwcnoprescor[bins])))*100d]
    lwcOocq1=[lwcOocq1,q1(abs(lwcnoprescor[bins]))*100d]
    lwcOocq3=[lwcOocq3,q3(abs(lwcnoprescor[bins]))*100d]
    pmbMed=[pmbMed,mean(pmb[bins])]


    print,binintstart+binsizestart*(i+1.),'-',n_elements(bins)
  endfor


    save,filename=saveName,coleControlLwc,coleControlTwc,vmdGeoMean,$
      colevarLwc,colevarTwc,colevarbothLwc,colevarbothTwc,binsizestart,$
      binintstart,cdpVlwc,cdpVtwc,cdpVLwc,cdpVTwc,colevarLwc2,pmbMed,$
      colevarbothTwc2,lwctwc,lwctwc2,minbin,lwc100Vcdplwc,lwcMean,$
      lwc100Vtwc,lwc100Vlwc,lwc100Vtwc,lwc100Mean,colELiqUMean,$
      lwcq1,lwcq3,twcq1,twcq3,color,vmdMean,cdpVlwcq1,cdpVlwcq3,$
      lwc100VLwcq1,lwc100VLwcq3,lwc100VCdplwcq1,lwc100VCdplwcq3,$
      lwcVcdpq1,lwcVcdpq3,lwcVCdp,cdpDBarMean,binGeoMean,lwcOoc,lwcOocq1,lwcOocq3





end
