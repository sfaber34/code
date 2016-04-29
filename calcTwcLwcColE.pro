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





    coleControlTwc=[coleControlTwc,median(lwcfixede[bins])/median(twcfixede[bins])]
    coleControlLwc=[coleControlLwc,median(twcfixede[bins])/median(lwcFixede[bins])]
    colevarTwc=[colevarTwc,median(lwc[bins])/median(twcfixede[bins])]
    colevarLwc=[colevarLwc,median(twc[bins])/median(lwcfixede[bins])]
    colevarTwcB=[colevarTwcB,median(lwcfixede[bins])/median(twc[bins])]
    colevarLwcB=[colevarLwcB,median(twcfixede[bins])/median(lwc[bins])]
    colevarbothTwc=[colevarbothTwc,median(lwc[bins])/median(twc[bins])]
    colevarbothLwc=[colevarbothLwc,median(twc[bins])/median(lwc[bins])]
    cdpVLwcFixedE=[cdpVLwcFixedE,median(cdplwc[bins])/median(lwcfixede[bins])]
    cdpVTwcFixedE=[cdpVTwcFixedE,median(cdplwc[bins])/median(twcfixede[bins])]
    cdpVLwc=[cdpVLwcCor,median(cdplwc[bins])/median(lwc[bins])]
    cdpVTwcCor=[cdpVTwcCor,median(cdplwc[bins])/median(twc[bins])]
    colevarLwc2=[colevarLwc2,median(twc2[bins])/median(lwcfixede[bins])]
    colevarbothTwc2=[colevarbothTwc2,median(lwcfixede[bins])/median(twc2[bins])]
    lwctwc=[lwctwc,median(lwc[bins])/median(twc[bins])]
    lwctwc2=[lwctwc2,median(lwc[bins])/median(twc2[bins])]
    lwc100Vlwc=[lwc100Vlwc,median(lwc100[bins])/median(lwc[bins])]
    lwc100Vtwc=[lwc100Vtwc,median(lwc100[bins])/median(twc[bins])]
    lwc100VlwcFixedE=[lwc100VlwcFixedE,median(lwc100[bins])/median(lwcFixedE[bins])]
    lwc100VtwcFixedE=[lwc100VtwcFixedE,median(lwc100[bins])/median(twcFixedE[bins])]





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
    save,filename='colesavefilehighres.sav',coleControlLwc,coleControlTwc,vmdGeoMean,$
      colevarLwc,colevarTwc,colevarbothLwc,colevarbothTwc,binsizestart,$
      binintstart,cdpVLwcFixedE,cdpVTwcFixedE,cdpVLwc,cdpVTwc,colevarLwc2,$
      colevarbothTwc2,lwctwc,lwctwc2,minbin,lwc100Vlwc,$
      lwc100Vtwc,lwc100VlwcFixedE,lwc100VtwcFixedE,/verbose
  endif





end
