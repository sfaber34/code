pro lwctwc11




  plots=2

  ;STARTING LEFT VALUE
  binint=2.

  ;WIDTH OF BINS
  binsize=4.

  ;LIQUID ONLY POINTS OR ALL
  liq=0






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




  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    ;cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    cdpDEff=cdpDEff[liqonly]
    cdpVolMean=cdpVolMean[liqonly]
    cdpMassMean=cdpMassMean[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
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
    

      

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)

      
      for i=0,n_elements(binistarti)-1 do begin
      
        bins=binindex[binistarti[i]:biniendi[i]]
        
        for w=0,1 do begin
        
        if w eq 0 then liq=where(trf[bins] gt -3. and lwc[bins] lt .9)
        if w eq 1 then liq=where(trf[bins] gt -3. and lwc[bins] gt .1 and lwc[bins] lt .9)

        
        if w eq 0 then p1=scatterplot(lwc[liq],twc[liq],dimensions=[1000,1000],sym_color=color[w])
        if w eq 1 then p1=scatterplot(lwc[liq],twc[liq],dimensions=[1000,1000],sym_color=color[w],/overplot)
        p1.xrange=[-.02,max(lwc[liq])+.1]
        p1.yrange=[-.02,max(lwc[liq])+.1]
        
        cole=ladfit([zeros,lwc[bins]],[zeros,twc[bins]])
        p1.TITLE=STRCOMPRESS(string(min(var[bins]))+'-'+string(max(var[bins])),/remove_all)
        eff=strcompress(string(1.-cole[1]))
        t2=text(.8,.92,eff,font_size=22)
                
        p2=plot([0,2.5],[0,2.5],/overplot,color='black',thick=2,linestyle=2)
        p2=plot([0,2.5],[cole[0],2.5*cole[1]+cole[0]],/overplot,color=color[0],thick=2)
        p1.xtitle='LWC g m!u-3!n'
        p1.ytitle='TWC g m!u-3!n'
        p1.font_size=22
        
        ;savename=STRCOMPRESS('individual'+string(i)+'.jpg')
        ;p2.save,savename

        print,cole[1]
        
      endfor
    endfor
end
