pro histogram





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
  ;restore,'colesavefile.sav'
  ;restore,'colesavefileB.sav'

  ;LIQUID ONLY POINTS OR ALL
  liq=1



  k=1
  ;liqOnly=where(trf gt -3. and lwc lt 1.1 and cdpconc gt 5)
  ;liqOnly=where(cdpconc gt 5)
  if k eq 0 then liqOnly=where(trf gt -3. and lwc lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt 5)
  if k eq 1 then liqOnly=where(trf gt -3. and lwc lt 1.1 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and cdpconc gt 5)
 
  print, n_elements(liqonly)

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
    cdpdbar2=cdpdbar2[liqonly]
  endif


        
    ;STARTING LEFT VALUE
    binint=2.

    ;WIDTH OF BINS
    binsize=1.



    ;SET VAR
    var=cdpmassmean

    

    if binsize eq 1 then begin
      bincount=60/(binsize*2.)
      ticks=string(dindgen(bincount,start=minbin,increment=binsize*2))
    endif else begin
      bincount=60/(binsize*2.)
      ticks=string(dindgen(bincount,start=minbin,increment=binsize))
    endelse
    
    ticks=[1:n_elements(ticks)]
    
    ticks=strsplit(ticks,'.',/extract)

    ticks2=make_array(n_elements(ticks),/string)
    for u=0,n_elements(ticks)-1 do begin
      ticks2[u]=ticks[u,0]
    endfor

    ticks=[strcompress(ticks2),' ',' ']
    
        
    barc=['blue','red']    
  
;    for i=0,1 do begin
      
    
    
       
        h1=histogram(var,min=binint,binsize=1)
        p1=barplot(dindgen(n_elements(h1),start=binint,increment=1),h1, histogram=1,dimensions=[1600,1200])
        ;p1=scatterplot(dindgen(n_elements(h1),start=2,increment=.1),h1,dimensions=[1600,1200])
        
        p1.xrange=[0,n_elements(h1)]
        p1.xmajor=n_elements(h1)/2.+1
        p1.xminor=0
        p1.xtickname=ticks
        p1.xtitle='VMD um'
        p1.ytitle='Frequency'
        p1.font_size=22
        p1.xticklen=0

        stop
;    endfor
end
