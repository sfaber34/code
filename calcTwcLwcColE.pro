pro calcTwcLwcColE




  plots=1

  ;STARTING LEFT VALUE
  binint=5.
  binintstart=binint

  ;WIDTH OF BINS
  binsize=2.
  binsizestart=binsize

  ;LIQUID ONLY POINTS OR ALL
  liq=1


  saveV=1


  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------




  restore,'loopdata.sav'

  ;liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and vmd lt 40. and cdpconc lt 600.)
  liqOnly=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.03 and twc gt 0.03 and cdpconc lt 300.)
  ;liqOnly=where(lwc gt 0.05 and lwc lt 1.2 and cdpconc lt 200.)


  if liq eq 1 then begin
    lwcVarE=lwcVarE[liqonly]
    twcVarE=twcVarE[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    dEff=dEff[liqonly]
    vvd=vvd[liqonly]
    vmd=vmd[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwc=lwc[liqonly]
    twc=twc[liqonly]
 
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    lwc100=lwc100[liqonly]
  endif

  minbin=binint

stop
  ;-------------------------------SET VAR---------------------------------------
  var=vmd
  ;-------------------------------SET VAR---------------------------------------



  binint2=binint+binsize


;  dBarBI=dblarr(bincount,n_elements(pmb))
;  dbarbinn=dindgen(bincount,start=0,increment=0)


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
  


  starti=0
  endi=0
  
  binNum=max(var)/binsize

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
    ;ncountscon=double([ncountscon+n_elements(bins)])


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



    print,binintstart+binsizestart*(i+1.),'-',n_elements(bins)
  endfor


  if saveV eq 1 then begin
    coleControlTwcB=coleControlTwc
    coleControlLwcB=coleControlLwc
    colevarTwcB=colevarTwc
    colevarLwcB=colevarLwc
    colevarbothTwcB=colevarbothTwc
    colevarbothLwcB=colevarbothLwc
    cdpVlwcB=cdpVlwc
    cdpVtwcB=cdpVtwc
    cdpVTwcB=cdpVTwc
    colevarLwc2B=colevarLwc2
    colevarbothTwc2B=colevarbothTwc2
    lwctwcB=lwctwc
    lwctwc2B=lwctwc2
    vmdGeoMeanB=vmdGeoMean
    colevarTwcBB=colevartwc
    colevarLwcBB=colevarlwc
    lwcq1B=lwcq1
    lwcq3B=lwcq3
    twcq1B=twcq1
    twcq3B=twcq3
    lwc100VcdplwcB=lwc100Vcdplwc
    lwc100MeanB=lwc100Mean
    lwc100VLwcq1B=lwc100VLwcq1
    lwc100VLwcq3B=lwc100VLwcq3
    lwc100VCdplwcq1B=lwc100VCdplwcq1
    lwc100VCdplwcq3B=lwc100VCdplwcq3
    vmdMeanB=vmdMean
    cdpVlwcq1B=cdpVlwcq1
    cdpVlwcq3B=cdpVlwcq3
    lwcVcdpq1B=lwcVcdpq1
    lwcVcdpq3B=lwcVcdpq3
    cdpVlwcB=cdpVLwc
    cdpDBarMeanB=cdpDBarMean
    binGeoMeanB=binGeoMean
    lwcVCdpB=lwcVCdp

    save,filename='colesavefileB.sav',coleControlLwcB,coleControlTwcB,$
      colevarLwcB,colevarTwcB,colevarbothLwcB,colevarbothTwcB,binsizestartB,$
      binintstartB,cdpVlwcB,cdpVtwcB,cdpVTwcB,colevarLwc2B,$
      colevarbothTwc2B,lwctwcB,lwctwc2B,minbin,vmdGeoMeanB,colevarTwcBB, colevarLwcBB,$
      lwcq1B,lwcq3B,twcq1B,twcq3B,color,lwc100VcdplwcB,lwc100MeanB,$
      lwc100VLwcq1B,lwc100VLwcq3B,lwc100VCdplwcq1B,lwc100VCdplwcq3B,$
      vmdMeanB,cdpVlwcq1B,cdpVlwcq3B,lwcVcdpq1B,lwcVcdpq3B,lwcVCdpB,$
      cdpDBarMeanB,binGeoMeanB,/verbose
  endif


  if saveV eq 0 then begin
    save,filename='colesavefile.sav',coleControlLwc,coleControlTwc,vmdGeoMean,$
      colevarLwc,colevarTwc,colevarbothLwc,colevarbothTwc,binsizestart,$
      binintstart,cdpVlwc,cdpVtwc,cdpVLwc,cdpVTwc,colevarLwc2,$
      colevarbothTwc2,lwctwc,lwctwc2,minbin,lwc100Vcdplwc,$
      lwc100Vtwc,lwc100Vlwc,lwc100Vtwc,lwc100Mean,$
      lwcq1,lwcq3,twcq1,twcq3,color,vmdMean,cdpVlwcq1,cdpVlwcq3,$
      lwc100VLwcq1,lwc100VLwcq3,lwc100VCdplwcq1,lwc100VCdplwcq3,$
      lwcVcdpq1,lwcVcdpq3,lwcVCdp,cdpDBarMean,binGeoMean,/verbose
  endif





end
