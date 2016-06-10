pro lwcDiffVTrans

  restore,'loopdata.sav'

  plots=2

  ;STARTING LEFT VALUE
  binint=0.1

  ;WIDTH OF BINS
  binsize=.1

  ;LIQUID ONLY POINTS OR ALL
  liq=1
  
  colorSelect=''


  liqOnly=where(trf gt -3. and lwc gt .02 and lwc lt 1.3 and cdptrans gt 0.)

  if liq eq 1 then begin
    lwc=lwc[liqonly]
    lwcvare=lwcvare[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    dEff=dEff[liqonly]
    vvd=vvd[liqonly]
    vmd=vmd[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    cdpTrans=cdpTrans[liqonly]
    tas=tas[liqonly]
  endif
  
  lwcDiff=cdplwc-lwc
  cdpTransB=cdpTrans
  cdpTrans=cdpTransB*(tas/max(tas))
  lwcPerDiff=((lwc-cdplwc)/lwc)*100.

  ;p1=scatterplot(lwc,cdpTrans,dimensions=[1800,1000],sym_transparency=30,sym_filled=1,sym_size=.3)
  ;p1.xrange=[65,115]
  ;p1.yrange=[0,10]
  


  ;-------------------------------SET VAR---------------------------------------
  var=abs(lwc-cdpLwc)
  ;-------------------------------SET VAR---------------------------------------








  bincount=ceil(max(var)/binsize)
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
  cole1=[]


  starti=0
  endi=0

  for i=0,bincount-1 do begin
    selectinds=where(var ge binint and var le binint2)


    if selectinds[0] ne -1 then begin


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
  ;------------------------------------------LWC/TWC 1:1 COMP----------------------------------------------
  ;--------------------------------------------------------------------------------------------------------

  ;cgcleanup

  zeros=dindgen(100000,start=0,increment=0)
  twos=dindgen(100000,start=0,increment=0)

  fixedbotherror=[]
  fixedlwcerror=[]
  fixedtwcerror=[]
  maxx=1
  w=window(dimensions=[1800,1200],/device)
  
  x=dindgen(n_elements(binistarti),start=.1,increment=.1)
  for i=0,n_elements(binistarti)-1 do begin

    bins=binindex[binistarti[i]:biniendi[i]]
    
    cdpTransC=cdpTrans[bins]
    cdpTransSort=sort(cdpTransC)
    cdpTransSorted=cdpTransC[cdpTransSort]
    cdpTransMed=cdpTransSorted[n_elements(cdpTransC)*.5]
    cdpTransq1=cdpTransSorted[n_elements(cdpTransC)*.25]
    cdpTransq3=cdpTransSorted[n_elements(cdpTransC)*.75]
    
    meansC=cdptrans[bins]/cdpconc[bins]
    meansSort=sort(meansC)
    meansSorted=meansC[meansSort]
    cdpTransMed=meansSorted[n_elements(meansC)*.5]
    cdpTransq1=meansSorted[n_elements(meansC)*.25]
    cdpTransq3=meansSorted[n_elements(meansC)*.75]
    
    fit=linfit(lwc[bins],cdpTransC)

    ;p1=scatterplot(lwc[bins],cdpTransC,sym_color=color[i+1],sym_size=.5,/overplot,/current,SYM_TRANSPARENCY=50,sym_filled=1,margin=50,/device)
    p1=scatterplot(mean(abs(lwc[bins]-cdpLwc[bins])),mean(cdptrans[bins])/mean(cdpconc[bins]),sym_color=color[i],/overplot,sym_filled=1,sym_size=.5,SYM_TRANSPARENCY=50)
    ;p1=scatterplot(mean(cdpconc[bins]),fit[0],sym_color=color[0],/overplot,sym_filled=1)
    
;    e1=plot([mean(cdpTransC),mean(cdpTransC)],[cdpTransMed,cdpTransq1],color=color[i],thick=2,/overplot)
;    e2=plot([mean(cdpTransC),mean(cdpTransC)],[cdpTransMed,cdpTransq3],color=color[i],thick=2,/overplot)
;    e3=plot([mean(cdpTransC)-.04,mean(cdpTransC)+.04],[cdpTransq1,cdpTransq1],color=color[i],thick=2,/overplot)
;    e4=plot([mean(cdpTransC)-.04,mean(cdpTransC)+.04],[cdpTransq3,cdpTransq3],color=color[i],thick=2,/overplot)
    ;p1.xrange=[0,1.8]
    ;p1.yrange=[0,1.8]

    print,(cdptrans[max(bins)])
    


  endfor


end
