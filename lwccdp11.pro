pro lwccdp11




  plots=2

  ;STARTING LEFT VALUE
  binint=2

  ;WIDTH OF BINS
  binsize=2

  ;LIQUID ONLY POINTS OR ALL
  liq=1






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


  liqOnly=where(trf gt -3. and lwc lt 1.1 and cdpconc ge 5)

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
  endif




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
  w=window(dimensions=[1000,1000])

  for i=0,n_elements(binistarti)-1 do begin

    bins=binindex[binistarti[i]:biniendi[i]]




    p1=scatterplot(cdplwc[bins],lwcfixede[bins],sym_color=color[i],symbol='.',/overplot,SYM_TRANSPARENCY=50)
    cole2=ladfit([zeros,cdplwc[bins]],[zeros,lwcfixede[bins]])

    cole3=ladfit([zeros,cdplwc[bins]],[zeros,lwcfixede[bins]])

    print,(1.-cole3[1])*100.
;    p2=plot([0,maxx],[cole[0],maxx*cole[1]+cole[0]],/overplot,thick=2,color='black')
;    p2=plot([0,maxx],[cole2[0],maxx*cole2[1]+cole2[0]],/overplot,thick=2,color='red')
;    p2=plot([0,maxx],[0,maxx],/overplot,color='green',thick=2,linestyle=2)

;    p1.xtitle='LWC g m!u-3!n'
;    p1.ytitle='TWC g m!u-3!n'
;    p1.font_size=22

    p1.xrange=[0.,1.1]
    p1.yrange=[0.,1.1]


;    fixedbotherror=[fixedbotherror,(1.-cole[1])*100.]
;    fixedlwcerror=[fixedlwcerror,(1.-cole2[1])*100.]
;    fixedtwcerror=[fixedtwcerror,(1.-cole3[1])*100.]
;    print,cole[1],'-',cole2[1],'-',cole3[1]


  endfor
  save,filename='fixedEError.sav',fixedbotherror,fixedlwcerror,fixedtwcerror,/verbose


end
