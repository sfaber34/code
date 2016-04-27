pro liqonlyETot
 



plots=2

;STARTING LEFT VALUE
binint=2.

;WIDTH OF BINS
binsize=2.

;LIQUID ONLY POINTS OR ALL
liq=1






bincount=60/binsize
ticks=string(dindgen(bincount,start=bicnint,increment=binsize))
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
   
    liqOnly=where(trf gt -3. and lwc gt .02 and lwc lt .9)
    liqOnly2=where(trf gt -3. and lwc gt .02 and lwc lt .9)


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
      lwcfixedE=lwcfixedE[liqonly]
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
    ;------------------------------------------LWC VS LWC,TWC DIFF-------------------------------------------
    ;--------------------------------------------------------------------------------------------------------
    
    
    
    if plots eq 0 then begin


    

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)

      
      for i=0,n_elements(binistarti)-1 do begin
      
      bins=binindex[binistarti[i]:biniendi[i]]
      binscon=[binscon,bins]
      countscon=[countscon,n_elements(bins)]
     
     p1=scatterplot(lwc[bins],lwc[bins]-twc[bins],/overplot,sym_color=color[i],sym_size=.5,dimensions=[1600,1000])
     p1.xtitle='LWC g m!u-3!n'
     p1.ytitle='LWC - TWC g m!u-3!n' 
     p1.font_size=22  
     cole=ladfit([zeros,lwc[bins]],[zeros,lwc[bins]-twc[bins]])
      
      
     cole0=[cole0,cole[0]]
     cole1=[cole1,cole[1]]
     
     
     
     
  
      endfor
      
      for i=0,n_elements(cole0)-1 do begin
        p2=plot([.02,1.2],[cole0[i],1.2*cole1[i]+cole0[i]],/overplot,color=color[i],thick=2)
        perDiff=strcompress(ticks2[i]+'-'+ticks2[i+1]+'='+string(1.-cole1[i],format='(f8.4)'))
        t1=text(i*.11,.94,perDiff,font_size=16,color=color[i])
        print,perDiff
      endfor
      
     cole1=1.-cole1
     stop
    endif
    

;    stop


    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------LWC/TWC 1:1 COMP----------------------------------------------
    ;--------------------------------------------------------------------------------------------------------
    
    
    
    if plots eq 1 then begin


      

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)

      
      for i=0,n_elements(binistarti)-1 do begin

        bins=binindex[binistarti[i]:biniendi[i]]

        p1=scatterplot(lwc[bins],twc[bins],dimensions=[1000,1000],sym_color=color[0])
        p1.xrange=[0,.2]
        p1.yrange=[0,.2]
        
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
    endif
    
    
    
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;---------------------------------------------------HISTOGRAM---------------------------------------------
    ;--------------------------------------------------------------------------------------------------------
    
    if plots eq 2 then begin

    cgcleanup

      for k=0,1 do begin
        
       if k eq 0 then vars=cdpdbar[liqonly]
       if k eq 1 then vars=cdpdbar[liqonly2]
       
        h1=histogram(vars,min=2,binsize=2)
        p1=barplot(dindgen(n_elements(h1)),h1, histogram=1,dimensions=[1400,1200],nbars=2,index=k,fill_color=color[k],/overplot)
        
        p1.xrange=[0,n_elements(countscon)]
        p1.xmajor=n_elements(countscon)+1
        p1.xminor=0
        p1.xtickname=ticks
        p1.xtitle='Bin Edge um'
        p1.ytitle='Frequency'
        p1.title='CDP Diameter Dist (Liquid Only Points)'
        p1.font_size=22
        p1.xticklen=1
      endfor



    endif
    
    
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------LWC/TWC 1:1 COMP DIFFERENCE-----------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 3 then begin


      cgcleanup

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)



        p1=scatterplot(lwc,twc,sym_color='midnight blue',sym_size=.5,dimensions=[1000,1000])
        p1.xrange=[0,2.5]
        p1.yrange=[0,2.5]
        p1.xtitle='LWC g m!u-3!n'
        p1.ytitle='TWC g m!u-3!n'
        p1.TITLE='LWC vs. TWC Liquid Only Points' 
        p1.font_size=22
               


        cole=ladfit([zeros,lwc],[zeros,twc])
        p2=plot([0,2.5],[0,2.5],/overplot,color='orange red',thick=2,linestyle=2)
        p3=plot([0,2.5],[cole[0],2.5*cole[1]+cole[0]],/overplot,color='blue',thick=2)


        print,1.-cole[1]
        perDiff=strcompress('Percent Difference='+string((1.-cole[1])*100.)+'%')
        t1=text(.2,.2,perDiff,font_size=18)

stop
    endif
    
    
    
    
    
    
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;---------------------------------------------------HISTOGRAM---------------------------------------------
    ;--------------------------------------------------------------------------------------------------------

    if plots eq 4 then begin

cgcleanup

      for k=0,3 do begin

       if k eq 0 then vars=cdpdbar[0:150]
       if k eq 1 then vars=cdpVolmean[0:150]
       if k eq 2 then vars=cdpDEff[0:150]
       if k eq 3 then vars=cdpMassMean[0:150]


        p1=plot(dindgen(n_elements(vars)),vars, dimensions=[1400,1200],color=color[k],/overplot)

        p1.xtitle='Bin Edge um'
        p1.ytitle='Frequency'
        p1.title='CDP Diameter Dist (Liquid Only Points)'
        p1.font_size=22
  
      endfor



    endif
    
    
    
    
    
    
    
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------ROLL OFF----------------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 5 then begin

    cgcleanup


      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)




        p1=scatterplot(lwc,lwc-twc,sym_color=grey,sym_size=.4,dimensions=[1600,1200],/overplot)


      p1.xrange=[0,.6]
      p1.yrange=[-.5,.5]

      fit=poly_fit([lwc],[lwc-twc],2,yfit=yfit)
      p1.TITLE=STRCOMPRESS(string(min(var[bins]))+'-'+string(max(var[bins])),/remove_all)


      lwcsort=sort(lwc)
      lwcsorted=lwc[lwcsort]
      fitsort=yfit[lwcsort]

      p2=plot(lwcsorted,fitsort,/overplot,color='green',thick=2,linestyle=2)
      p2=plot([0,2.5],[0,0],/overplot,color='Black',thick=1)
      p1.xtitle='LWC g m!u-3!n'
      p1.ytitle='TWC g m!u-3!n'
      p1.font_size=22
      
      stop
    endif
    
    
    






    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------COLE E----------------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 6 then begin

      cgcleanup
      restore,'col.sav'

      zeros=dindgen(100000,start=0,increment=0)

      
      cole1[0:4]=.6864
      cole1[26]=1.
      cole1[30:42]=1.
      
      cole1=cole1[5:30]

      xvar=dindgen(n_elements(cole1),start=2.5,increment=1)

      p1=scatterplot(xvar,cole1,sym_color='black',sym_size=1,dimensions=[1600,1200],/overplot)


     

      fit=poly_fit(xvar,cole1,3,yfit=yfit)
      



      p2=plot(xvar,yfit,/overplot,color='green',thick=2,linestyle=2)
      
      p1.xtitle='LWC g m!u-3!n'
      p1.ytitle='TWC g m!u-3!n'
      p1.font_size=22

      stop
    endif
    
    
    
    
    
    
    
    
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------ROLL OFF 2----------------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 7 then begin

      cgcleanup


      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)




      p1=scatterplot(trf,lwc-twc,sym_color=grey,sym_size=.4,dimensions=[1600,1200])



      fit=poly_fit([trf],[lwc-twc],10,yfit=yfit)
      p1.TITLE=STRCOMPRESS(string(min(var[bins]))+'-'+string(max(var[bins])),/remove_all)


      lwcsort=sort(cdpMassMean)
      lwcsorted=cdpMassMean[lwcsort]
      fitsort=yfit[lwcsort]

      p2=plot(lwcsorted,fitsort,/overplot,color='green',thick=2,linestyle=2)
      p2=plot([0,50],[0,0],/overplot,color='Red',thick=1, linestyle=2)
      p1.xtitle='LWC g m!u-3!n'
      p1.ytitle='TWC g m!u-3!n'
      p1.font_size=22

      stop
    endif
    
    
    







    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------COL E ----------------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 8 then begin

      cgcleanup

      korX=[2,2.5,5,7.5,10,12.5,15,17.5,20,22.5,23.75]
      korY=[.06,.1,.34,.5,.64,.73,.8,.85,.88,.9,.91]
      korX=korX*1.04436
      



      p1=scatterplot(korX,korY,sym_color=grey,sym_size=.4,symbol=0,dimensions=[1600,1200])



      fit=poly_fit(korX,korY,6,yfit=yfit)     



      p2=plot(korX,yfit,/overplot,color='green',thick=2,linestyle=1)
      p3=plot(korX,yfit+.12,/overplot,color='green',thick=2,linestyle=2)
      p4=plot(korX,yfit-.12,/overplot,color='green',thick=2,linestyle=2)
      
      
      restore,'cole1.sav'
      
      cole1x=dindgen(n_elements(cole1),start=1,increment=1)
      
      p5=scatterplot(cole1x,cole1,sym_size=.5,sym_color='black',/overplot)
      
      
      
      restore,'cole4.sav'

      cole2x=dindgen(n_elements(cole4),start=1,increment=1)

      p5=scatterplot(cole2x,cole4,sym_size=.5,sym_color='red',/overplot)
      
      
      
      
      restore,'cole3.sav'

      cole3x=dindgen(n_elements(cole3),start=1,increment=1)

      p5=scatterplot(cole3x,cole3,sym_size=.5,sym_color='blue',/overplot)
      p5.YRANGE=[0,1]
      p5.xrange=[0,25]
      
      
      
      p1.font_size=22

      stop
    endif





    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------CDP D VS. DIFF ----------------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 9 then begin

      ;cgcleanup




      p1=scatterplot(cdpmassmean,lwc-twc,sym_color='orange',sym_size=.4,dimensions=[1600,1200],/overplot)



      fit=poly_fit(lwc,lwc-twc,6,yfit=yfit)



      ;p2=plot(lwc,yfit,/overplot,color='green',thick=2,linestyle=1)


      p1.font_size=22

      stop
    endif
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------MOMENT 1:1 COMP DIFFERENCE-----------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 10 then begin


      cgcleanup

      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)



      p1=scatterplot(cdpmassmean,cdpdeff*1.04436,sym_color='black',sym_size=.5,dimensions=[1000,1000])
;      p1.xrange=[0,2.5]
;      p1.yrange=[0,2.5]
      p1.xtitle='LWC g m!u-3!n'
      p1.ytitle='TWC g m!u-3!n'
      p1.TITLE='LWC vs. TWC Liquid Only Points'
      p1.font_size=22
      
      cdpmassmean=cdpmassmean[where(finite(cdpmassmean) eq 1)]
      cdpdeff=cdpdeff[where(finite(cdpdeff) eq 1)]


      cole=ladfit([zeros,cdpmassmean],[zeros,cdpdeff*1.04436])
      p2=plot([0,50],[0,50],/overplot,color='orange red',thick=2,linestyle=2)
      p3=plot([0,50],[cole[0],50*cole[1]+cole[0]],/overplot,color='blue',thick=2)


      print,1.-cole[1]
      perDiff=strcompress('Percent Difference='+string((1.-cole[1])*100.)+'%')
      t1=text(.2,.2,perDiff,font_size=18)

      stop
    endif
    
    
    
    
    
    
    
    
    ;--------------------------------------------------------------------------------------------------------
    ;------------------------------------------LWC/TWC 1:1 COMP----------------------------------------------
    ;--------------------------------------------------------------------------------------------------------



    if plots eq 1 then begin




      zeros=dindgen(100000,start=0,increment=0)
      twos=dindgen(100000,start=0,increment=0)


      for i=0,n_elements(binistarti)-1 do begin

        bins=binindex[binistarti[i]:biniendi[i]]

        p1=scatterplot(lwc[bins],twc[bins],dimensions=[1000,1000],sym_color=color[0])
        p1.xrange=[0,.2]
        p1.yrange=[0,.2]

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
    endif





end
