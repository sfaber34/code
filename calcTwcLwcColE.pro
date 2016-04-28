pro calcTwcLwcColE




  plots=2

  ;STARTING LEFT VALUE
  binint=4.2
  binintstart=binint

  ;WIDTH OF BINS
  binsize=.05
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

  liqOnly=where(trf gt -3. and lwcfixede lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwcfixede gt 0 and twcfixede gt 0 and cdpMassMean lt 40.)
 


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
  cole0=[]
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
  binRFixedE=[]
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
    
    ;p1=scatterplot(twcfixede[bins],lwcFixede[bins],/overplot,sym_color=color[i],sym_size=.5,dimensions=[1200,1200])
    cole1=ladfit([zeros,lwcfixede[bins]],[zeros,twcfixede[bins]])
    cole2=ladfit([zeros,twcfixede[bins]],[zeros,lwcFixede[bins]])
    cole3=ladfit([zeros,lwc[bins]],[zeros,twcfixede[bins]])
    cole4=ladfit([zeros,twc[bins]],[zeros,lwcfixede[bins]])
    cole19=ladfit([zeros,lwcfixede[bins]],[zeros,twc[bins]])
    cole20=ladfit([zeros,twcfixede[bins]],[zeros,lwc[bins]])
    cole5=ladfit([zeros,lwc[bins]],[zeros,twc[bins]])
    cole6=ladfit([zeros,twc[bins]],[zeros,lwc[bins]])
    cole7=ladfit([zeros,cdplwc[bins]],[zeros,lwcfixede[bins]])
    cole8=ladfit([zeros,cdplwc[bins]],[zeros,twcfixede[bins]])
    cole9=ladfit([zeros,cdplwc[bins]],[zeros,lwc[bins]])
    cole10=ladfit([zeros,cdplwc[bins]],[zeros,twc[bins]])
    cole11=ladfit([zeros,twc2[bins]],[zeros,lwcfixede[bins]])
    cole12=ladfit([zeros,lwcfixede[bins]],[zeros,twc2[bins]])
    cole13=ladfit([zeros,lwc[bins]],[zeros,twc[bins]])
    cole14=ladfit([zeros,lwc[bins]],[zeros,twc2[bins]])
    cole15=ladfit([zeros,lwc100[bins]],[zeros,lwcFixedE[bins]])
    cole16=ladfit([zeros,lwc100[bins]],[zeros,twcFixedE[bins]])
    cole17=ladfit([zeros,lwc100[bins]],[zeros,lwc[bins]])
    cole18=ladfit([zeros,lwc100[bins]],[zeros,twc[bins]])

    
    


    cole0=[cole0,cole1[0]]
    coleControlTwc=[coleControlTwc,cole1[1]]
    coleControlLwc=[coleControlLwc,cole2[1]]
    colevarTwc=[colevarTwc,cole3[1]]
    colevarLwc=[colevarLwc,cole4[1]]
    colevarTwcB=[colevarTwcB,cole19[1]]
    colevarLwcB=[colevarLwcB,cole20[1]]
    colevarbothTwc=[colevarbothTwc,cole5[1]]
    colevarbothLwc=[colevarbothLwc,cole6[1]]
    cdpVLwcFixedE=[cdpVLwcFixedE,cole7[1]]
    cdpVTwcFixedE=[cdpVTwcFixedE,cole8[1]]
    cdpVLwcCor=[cdpVLwcCor,cole9[1]]
    cdpVTwcCor=[cdpVTwcCor,cole10[1]]
    colevarLwc2=[colevarLwc2,cole11[1]]
    colevarbothTwc2=[colevarbothTwc2,cole12[1]]
    lwctwc=[lwctwc,cole13[1]]
    lwctwc2=[lwctwc2,cole14[1]]
    binRFixedE=[binRFixedE,mean(lwcfixede[bins]/twcfixede[bins])]
    binR=[binR,mean(lwc[bins]/twc[bins])]
    lwc100Vlwc=[lwc100Vlwc,cole17[1]]
    lwc100Vtwc=[lwc100Vtwc,cole18[1]]
    lwc100VlwcFixedE=[lwc100VlwcFixedE,cole15[1]]
    lwc100VtwcFixedE=[lwc100VtwcFixedE,cole16[1]]
    lwcDtwcFixedE=[lwcDtwcFixedE,mean(lwcFixedE[bins])/mean(twcFixedE[bins])]
    lwcDtwc=[lwcDtwc,mean(lwc[bins])/mean(twc[bins])]
    



    print,binintstart+binsizestart*(i+1.),'-',n_elements(bins)
  endfor
  

    if saveV eq 1 then begin
      cole0B=cole0
      coleControlTwcB=coleControlTwc
      coleControlLwcB=coleControlLwc
      colevarTwcB=colevarTwc
      colevarLwcB=colevarLwc
      colevarbothTwcB=colevarbothTwc
      colevarbothLwcB=colevarbothLwc
      cdpVLwcFixedEB=cdpVLwcFixedE
      cdpVTwcFixedEB=cdpVTwcFixedE
      cdpVLwcCorB=cdpVLwcCor
      cdpVTwcCorB=cdpVTwcCor
      colevarLwc2B=colevarLwc2
      colevarbothTwc2B=colevarbothTwc2
      lwctwcB=lwctwc
      lwctwc2B=lwctwc2
      vmdGeoMeanB=vmdGeoMean
      colevarTwcBB=colevartwc
      colevarLwcBB=colevarlwc
  
      save,filename='colesavefileB.sav',coleControlLwcB,coleControlTwcB,$
      colevarLwcB,colevarTwcB,colevarbothLwcB,colevarbothTwcB,binsizestartB,$
      binintstartB,cdpVLwcFixedEB,cdpVTwcFixedEB,cdpVLwcCorB,cdpVTwcCorB,colevarLwc2B,$
      colevarbothTwc2B,lwctwcB,lwctwc2B,minbin,vmdGeoMeanB,colevarTwcBB, colevarLwcBB,/verbose
    endif


    if saveV eq 0 then begin
      save,filename='colesavefilehighres.sav',coleControlLwc,coleControlTwc,vmdGeoMean,$
        colevarLwc,colevarTwc,colevarbothLwc,colevarbothTwc,binsizestart,$
        binintstart,cdpVLwcFixedE,cdpVTwcFixedE,cdpVLwcCor,cdpVTwcCor,colevarLwc2,$
        colevarbothTwc2,lwctwc,lwctwc2,binRFixedE,binR,minbin,lwc100Vlwc,$
        lwc100Vtwc,lwc100VlwcFixedE,lwc100VtwcFixedE,lwcDtwcFixedE,lwcDtwc,$
        colevarTwcB, colevarLwcB,/verbose
    endif
    




end
