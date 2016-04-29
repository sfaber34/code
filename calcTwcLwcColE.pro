pro calcTwcLwcColE




  plots=2

  ;STARTING LEFT VALUE
  binint=4.2
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



  color=['black','deep sky blue','green','firebrick','purple','dark orange','sienna',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'deep sky blue','green','firebrick','purple','dark orange','sienna','midnight blue',$
    'dark olive green','firebrick','dark slate grey','dark khaki','black','deep sky blue',$
    'green','firebrick','purple','dark orange',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black',$
    'midnight blue','dark olive green','firebrick','dark slate grey','dark khaki','black']



  restore,'loopdata.sav'

  liqOnly=where(trf gt -3. and lwcfixede lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwcfixede gt 0.05 and twcfixede gt 0.05 and cdpMassMean lt 40.)



  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpDEff=cdpDEff[liqonly]
    cdpVolMean=cdpVolMean[liqonly]
    cdpMassMean=cdpMassMean[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwcfixede=lwcfixede[liqonly]
    twcfixede=twcfixede[liqonly]
    twc2=twc2[liqonly]
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
  cdpVLwcFixedE=[]
  cdpVTwcFixedE=[]
  cdpVLwcCor=[]
  cdpVTwcCor=[]
  cdpVLwcFixedESD=[]
  cdpVTwcFixedESD=[]
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
  lwc100VlwcFixedE=[]
  lwc100VtwcFixedE=[]
  lwcDtwcFixedE=[]
  lwcDtwc=[]
  vmdGeoMean=[]
  colevarTwcB=[]
  colevarLwcB=[]


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





    coleControlTwc=[coleControlTwc,mean(lwcfixede[bins])/mean(twcfixede[bins])]
    coleControlLwc=[coleControlLwc,mean(twcfixede[bins])/mean(lwcFixede[bins])]
    colevarTwc=[colevarTwc,mean(lwc[bins])/mean(twcfixede[bins])]
    colevarLwc=[colevarLwc,mean(twc[bins])/mean(lwcfixede[bins])]
    colevarTwcB=[colevarTwcB,mean(lwcfixede[bins])/mean(twc[bins])]
    colevarLwcB=[colevarLwcB,mean(twcfixede[bins])/mean(lwc[bins])]
    colevarbothTwc=[colevarbothTwc,mean(lwc[bins])/mean(twc[bins])]
    colevarbothLwc=[colevarbothLwc,mean(twc[bins])/mean(lwc[bins])]
    cdpVLwcFixedE=[cdpVLwcFixedE,mean(cdplwc[bins])/mean(lwcfixede[bins])]
    cdpVTwcFixedE=[cdpVTwcFixedE,mean(cdplwc[bins])/mean(twcfixede[bins])]
    cdpVLwc=[cdpVLwcCor,mean(cdplwc[bins])/mean(lwc[bins])]
    cdpVTwcCor=[cdpVTwcCor,mean(cdplwc[bins])/mean(twc[bins])]
    colevarLwc2=[colevarLwc2,mean(twc2[bins])/mean(lwcfixede[bins])]
    colevarbothTwc2=[colevarbothTwc2,mean(lwcfixede[bins])/mean(twc2[bins])]
    lwctwc=[lwctwc,mean(lwc[bins])/mean(twc[bins])]
    lwctwc2=[lwctwc2,mean(lwc[bins])/mean(twc2[bins])]
    lwc100Vlwc=[lwc100Vlwc,mean(lwc100[bins])/mean(lwc[bins])]
    lwc100Vtwc=[lwc100Vtwc,mean(lwc100[bins])/mean(twc[bins])]
    lwc100VlwcFixedE=[lwc100VlwcFixedE,mean(lwc100[bins])/mean(lwcFixedE[bins])]
    lwc100VtwcFixedE=[lwc100VtwcFixedE,mean(lwc100[bins])/mean(twcFixedE[bins])]





    print,binintstart+binsizestart*(i+1.),'-',n_elements(bins)
  endfor


  if saveV eq 1 then begin
    coleControlTwcB=coleControlTwc
    coleControlLwcB=coleControlLwc
    colevarTwcB=colevarTwc
    colevarLwcB=colevarLwc
    colevarbothTwcB=colevarbothTwc
    colevarbothLwcB=colevarbothLwc
    cdpVLwcFixedEB=cdpVLwcFixedE
    cdpVTwcFixedEB=cdpVTwcFixedE
    cdpVLwcB=cdpVLwc
    cdpVTwcB=cdpVTwc
    colevarLwc2B=colevarLwc2
    colevarbothTwc2B=colevarbothTwc2
    lwctwcB=lwctwc
    lwctwc2B=lwctwc2
    vmdGeoMeanB=vmdGeoMean
    colevarTwcBB=colevartwc
    colevarLwcBB=colevarlwc

    save,filename='colesavefileB.sav',coleControlLwcB,coleControlTwcB,$
      colevarLwcB,colevarTwcB,colevarbothLwcB,colevarbothTwcB,binsizestartB,$
      binintstartB,cdpVLwcFixedEB,cdpVTwcFixedEB,cdpVLwcB,cdpVTwcB,colevarLwc2B,$
      colevarbothTwc2B,lwctwcB,lwctwc2B,minbin,vmdGeoMeanB,colevarTwcBB, colevarLwcBB,/verbose
  endif


  if saveV eq 0 then begin
    save,filename='colesavefile.sav',coleControlLwc,coleControlTwc,vmdGeoMean,$
      colevarLwc,colevarTwc,colevarbothLwc,colevarbothTwc,binsizestart,$
      binintstart,cdpVLwcFixedE,cdpVTwcFixedE,cdpVLwc,cdpVTwc,colevarLwc2,$
      colevarbothTwc2,lwctwc,lwctwc2,minbin,lwc100Vlwc,$
      lwc100Vtwc,lwc100VlwcFixedE,lwc100VtwcFixedE,/verbose
  endif





end
