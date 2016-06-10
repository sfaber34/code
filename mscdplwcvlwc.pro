pro msCdplwcVLwc

  restore,'loopdata.sav'

  plots=2

  ;STARTING LEFT VALUE
  binint=0

  ;WIDTH OF BINS
  binsize=150

  ;LIQUID ONLY POINTS OR ALL
  liq=1


  liqOnly=where(trf gt -3. and lwc gt .01 and vmd gt 15.)

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
  endif

  ;-------------------------------SET VAR---------------------------------------
  var=cdpconc
  ;-------------------------------SET VAR---------------------------------------








  bincount=max(cdpconc)/binsize
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
  ;w=window(dimensions=[1800,1200])

  for i=0,n_elements(binistarti)-1 do begin

    bins=binindex[binistarti[i]:biniendi[i]]

    p1=scatterplot(cdplwc[bins],lwc[bins],sym_color=color[2],sym_size=.5,/current,SYM_TRANSPARENCY=80,sym_filled=1,margin=50,layout=[3.,ceil((n_elements(binistarti)-1)/3.),i+1.],/device)
    p2=plot([0,2.8],[0,2.8],thick=2,/overplot)
    cole2=ladfit([zeros,cdplwc[bins]],[zeros,lwc[bins]])

    cole3=ladfit([zeros,cdplwc[bins]],[zeros,lwc[bins]])

    print,(binistarti[i])

    p1.xrange=[0.,2.8]
    p1.yrange=[0.,2.8]



  endfor
  save,filename='fixedEError.sav',fixedbotherror,fixedlwcerror,fixedtwcerror,/verbose


end
