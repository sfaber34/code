pro calcTwcLwcColE




  plots=1

  ;STARTING LEFT VALUE
  binint=7.
  binintstart=binint

  ;WIDTH OF BINS
  binsize=1.
  binsizestart=binsize

  ;LIQUID ONLY POINTS OR ALL
  liq=1


  saveV=0



  bincount=60/binsize
  ticks=string(dindgen(bincount,start=binint,increment=binsize))
  ticks=strsplit(ticks,'.',/extract)

  ticks2=make_array(n_elements(ticks),/string)
  for u=0,n_elements(ticks)-1 do begin
    ticks2[u]=ticks[u,0]
  endfor

  ticks=[strcompress(ticks2),' ',' ']


  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------
  ;---------------------------------------------------------------------------------------------------




  restore,'loopdata.sav'

  liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and cdpMassMean lt 40.)



  if liq eq 1 then begin
    lwcVarE=lwcVarE[liqonly]
    twcVarE=twcVarE[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpDEff=cdpDEff[liqonly]
    cdpVolMean=cdpVolMean[liqonly]
    cdpMassMean=cdpMassMean[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    twcVarE2=twcVarE2[liqonly]
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    lwc100=lwc100[liqonly]
  endif

  minbin=binint


  ;-------------------------------SET VAR---------------------------------------
  var=cdpMassMean
  ;-------------------------------SET VAR---------------------------------------



  binint2=binint+binsize


  dBarBI=dblarr(bincount,n_elements(pmb))
  dbarbinn=dindgen(bincount,start=0,increment=0)


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


  starti=0
  endi=0

  for i=0,bincount-1 do begin
    selectinds=where(var ge binint and var le binint2)


    if selectinds[0] ne -1 then begin

      vmdGeoMean=[vmdGeoMean,(min(cdpmassmean[selectinds])+max(cdpmassmean[selectinds]))/2.]

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
    cdpVlwc=[cdpVlwc,mean(cdplwc[bins])/mean(lwc[bins])]
    cdpVtwc=[cdpVtwc,mean(cdplwc[bins])/mean(twc[bins])]
    cdpVLwcCor=[cdpVLwcCor,mean(cdplwc[bins])/mean(lwcVarE[bins])]
    cdpVTwcCor=[cdpVTwcCor,mean(cdplwc[bins])/mean(twcVarE[bins])]
    colevarLwc2=[colevarLwc2,mean(twcVarE2[bins])/mean(lwc[bins])]
    colevarbothTwc2=[colevarbothTwc2,mean(lwc[bins])/mean(twcVarE2[bins])]
    lwctwc=[lwctwc,mean(lwcVarE[bins])/mean(twcVarE[bins])]
    lwctwc2=[lwctwc2,mean(lwcVarE[bins])/mean(twcVarE2[bins])]
    lwc100Vlwc=[lwc100Vlwc,mean(lwc100[bins])/mean(lwcVarE[bins])]
    lwc100Vtwc=[lwc100Vtwc,mean(lwc100[bins])/mean(twcVarE[bins])]
    lwc100Vlwc=[lwc100Vlwc,abs(mean(lwc100[bins])-mean(lwc[bins]))/((mean(lwc[bins])+mean(lwc100[bins]))/2.)]
    lwc100Vtwc=[lwc100Vtwc,abs(mean(lwc100[bins])-mean(twc[bins]))/((mean(twc[bins])+mean(lwc100[bins]))/2.)]


    
    twcK=lwc[bins]/twc[bins]
    lwcK=twc[bins]/lwc[bins]
    
    lwcfixedsort=sort(twcK)
    lwcsorted=twcK[lwcfixedsort]
    
    twcfixedsort=sort(lwcK)
    twcsorted=lwcK[twcfixedsort]
    
    
    lwcRatio=lwc[bins]/lwc100[bins]
    twcRatio=twc[bins]/lwc100[bins]
    
    lwcRatiosort=sort(lwcRatio)
    lwcRatiosorted=lwcRatio[lwcRatiosort]
    
    twcRatiosort=sort(twcRatio)
    twcRatiosorted=twcRatio[twcRatiosort]
    
    
    
    
    
    
    lwcq1=[lwcq1,mean(lwc[bins])/mean(twc[bins])-lwcsorted[n_elements(lwcsorted)*.25]]
    lwcq3=[lwcq3,lwcsorted[n_elements(lwcsorted)*.75]-mean(lwc[bins])/mean(twc[bins])]
    twcq1=[twcq1,mean(twc[bins])/mean(lwc[bins])-twcsorted[n_elements(twcsorted)*.25]]
    twcq3=[twcq3,twcsorted[n_elements(twcsorted)*.75]-mean(twc[bins])/mean(lwc[bins])]



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
    cdpVLwcB=cdpVLwc
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

    save,filename='colesavefileB.sav',coleControlLwcB,coleControlTwcB,$
      colevarLwcB,colevarTwcB,colevarbothLwcB,colevarbothTwcB,binsizestartB,$
      binintstartB,cdpVlwcB,cdpVtwcB,cdpVLwcB,cdpVTwcB,colevarLwc2B,$
      colevarbothTwc2B,lwctwcB,lwctwc2B,minbin,vmdGeoMeanB,colevarTwcBB, colevarLwcBB,$
      lwcq1B,lwcq3B,twcq1B,twcq3B,color,/verbose
  endif


  if saveV eq 0 then begin
    save,filename='colesavefile.sav',coleControlLwc,coleControlTwc,vmdGeoMean,$
      colevarLwc,colevarTwc,colevarbothLwc,colevarbothTwc,binsizestart,$
      binintstart,cdpVlwc,cdpVtwc,cdpVLwc,cdpVTwc,colevarLwc2,$
      colevarbothTwc2,lwctwc,lwctwc2,minbin,lwc100Vlwc,$
      lwc100Vtwc,lwc100Vlwc,lwc100Vtwc,$
      lwcq1,lwcq3,twcq1,twcq3,color,/verbose
  endif





end
