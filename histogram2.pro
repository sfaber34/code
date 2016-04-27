;CALCS AND PLOTS MEAN ERROR/STDEV FOR EACH K LIQ CALC

pro histogram2






  ;cgcleanup
  flight=['0710','0725','0727','0728','0729','0803','0807','0814','0815']
  
  ;flight=['0710','0725','0727','0728','0729']
  kLevel=['400']
  ktype=['indicated']
  colors=['red','blue','black']
  yrange=[.05,-.05]
  xrange=[60,150]

  runcalc=1

  mean400=[]
  stdev400=[]
  mean600=[]
  stdev600=[]
  mean900=[]
  stdev900=[]
  meanlwcdiff400=[]
  slopePerCorComp=[]
  lwc100con=[]
  interceptPerCorComp=[]
  lwcPresCorcon=[]
  lwcnev1con=[]
  lwcnev10con=[]
  avpitchcon=[]
  avrollcon=[]
  betabcon=[]
  avyawcon=[]
  betaBcon=[]
  sigcon=[]
  lwccon=[]
  cdplwccon=[]
  column=dindgen(10,n_elements(flight))
  
  if runcalc eq 1 then begin
    for k=0,n_elements(ktype)-1 do begin



      for i=0,n_elements(kLevel)-1 do begin

        
        pmbcon=[]
        ascon=[]
        cdpdbar_NRBcon=[]
        cdpconc_NRBcon=[]
        lwcnoPresCorDiffcon=[]
        trfcon=[]
        clearaircon=[]
        hivscon=[]
        asdelcon=[]
        lwcnoPresCorcon=[]
        for j=0,n_elements(flight)-1 do begin
          g= nevBase(flight[j],ktype[k],kLevel[i])
          ;p1=scatterplot(g.pmb[g.clearair],g.lwcNoPresCor[g.clearair],/overplot,dimensions=[1400,1000])

        

          ;common g, g
          clearAir=g.clearAir
          pmb=g.pmb
          lwc=g.lwc
          time=g.time
          timeForm=g.timeForm
          as=g.as
          aiasMs=g.aiasMs
          tas=g.tas
          levelClearAir=g.levelClearAir
          avroll=g.avroll
          avpitch=g.avpitch
          pLiq=g.pLiq
          lwcnev1=g.lwcnev1
          lwcnoPresCor=g.lwcnoPresCor
          flightString=g.flightString
          kLiq=g.kLiq
          cdpdbar_NRB=g.cdpdbar
          cdpconc_NRB=g.cdpconc
          trf=g.trf
          lwc100=g.lwc100
          avyaw=g.avyaw
           

          x=where(abs(g.cdplwc) gt 0.001 and abs(g.lwcnev1) gt 0.001)
          perdiff=( g.cdplwc[x]-g.lwcnev1[x]) / abs((g.cdplwc[x]+g.lwcnev1[x])/2.)
          s=stddev(perdiff)
          m=mean(perdiff)
          
          p1= scatterplot(g.timeFlight,perdiff)
          stop
          
          print,'-----------------------'
          print,'-----------------------'
          print,'-----------------------'
          print, flight[j]
          print, kLevel[i]
          print,flight[j]

          print,s
          print,m


          pmbcon=[pmbcon,pmb]
          lwccon=[lwccon,lwc]
          ascon=[ascon,as]
          cdpdbar_NRBcon=[cdpdbar_NRBcon,cdpdbar_NRB]
          cdplwccon=[cdplwccon,g.cdplwc]
          trfcon=[trfcon,trf]
          lwc100con=[lwc100con,lwc100]
          lwcnev1con=[lwcnev1con,lwcnev1]
          clearaircon=[clearaircon,clearair]
          avpitchcon=[avpitchcon,avpitch]
          avrollcon=[avrollcon,avroll]
          ;betabcon=[betabcon,betab]
          avyawcon=[avyawcon,avyaw]
          lwcnoPresCorcon=[lwcnoPresCorcon,lwcnoPresCor]

          

          
          
          
          
          
          
        endfor






        lwcmean=mean(abs(lwcnoPresCorcon))
        dev=stddev(lwcnoPresCorcon)


        ave=(double(n_elements(clear))/double(n_elements(g.lwc)))*100.
;        print,'mean=',lwcmean
;        print,'stddev=',dev



      endfor

    endfor
    lwcnev1=lwcnev1con
    lwc=lwccon
    lwcnoPresCor=lwcnoPresCorcon
    pmb=pmbcon
    cdplwc=cdplwccon
  endif
  
  
  

  ;if runcalc eq 1 then save,lwcmean400ind,lwcmean600ind,lwcmean900ind,lwcmean400true,lwcmean600true,lwcmean900true,lwcdev400ind,lwcdev600ind,lwcdev900ind,lwcdev400true,lwcdev600true,lwcdev900true ,filename='hist.sav'
  if runcalc eq 1 then save, lwcnev1, lwc, lwcnoPresCor, pmb, cdplwc, filename='hist.sav'
  if runcalc eq 1 then stop



  if runcalc eq 4 then begin
    restore, 'hist.sav'
    diff=cdplwc-lwc
    diff2=cdplwc-lwcnev1
    sig=where(lwcnev1 eq 0)
    
    
    p1=scatterplot(cdplwc,diff,dimensions=[1200,800],sym_size='.4')
    p1.xtitle="Korolev's LWC g m!U-3!N"
    p1.ytitle="LWC Difference (Korolev's LWC - Calculated LWC) g m!U-3!N"
    p1.font_size=22
    ;p1.yrange=[-.025,.025]
    ;p1.xrange=[-.1,2.6]
    
    p2=scatterplot(cdplwc,diff2,dimensions=[1200,800],sym_size='.4',sym_color='grey',/overplot)
    
    print, mean(abs(diff))
    print, stddev(diff)
    print,'-------------------------------'
    print, mean(abs(diff[sig]))
    print, stddev(diff[sig])
    ;p1.save,'lwcdirectcomp.png'
    stop
    
  
    plot1=scatterplot(pmb,lwcnoprescor,dimensions=[1200,800])
    
    plot1.xrange=[1000,350]
    plot1.yrange=[-.1,.1]
    plot1.xtitle='Flight Level Pressure'
    plot1.ytitle='Clear Air LWC Error (g m!u-3!n)'
    plot1.font_size=24
    
    l=linfit(pmb,lwcnoprescor)
    plot2=plot([1000,350],[l[1]*1000+l[0],l[1]*350+l[0]],'r',/overplot)
    plot1.save,'presdepnocorb.png'
    stop
  endif  


  if runcalc eq 3 then begin

    cgcleanup
    restore, 'hist.sav'


    inc=50.
    
    errorcon=[]

    
    
     for t=299.,1000. do begin
      x=mean(abs(lwcnoprescor[where(pmb gt t and pmb lt t+50.)]))
      errorcon=[errorcon,x]
      t=t+50.
     endfor
    

    
    
    ;h=histogram(pmb,binsize=inc)
    ;ticks=['.005','.010','.015','.020','.025',' ',' ']
    ticks2=dindgen(n_elements(errorcon),start=300,increment=50)


    plot1=barplot(ticks2,errorcon,histogram=1,dimensions=[1200,800])
    ;plot1.ylog=1
    
    ;plot1.xtickname=ticks
    plot1.xtext_orientation=270
    ;plot1.YRANGE=[0,100000]
    plot1.xminor=0
    plot1.yticklen=1
    plot1.ysubticklen=.08
    plot1.xtickinterval=50

   

    plot1.xtitle='Flight Level Pressure (mb)'
    plot1.ytitle='Mean Clear Air LWC Error (g m!U-3!N)'
    plot1.font_size=24
    plot1.save, 'ktrueperformanc.png'
  endif



  if runcalc eq 2 then begin
    
    cgcleanup
    restore, 'hist.sav'

   
    inc=.005
    h=histogram(lwcnev1,binsize=inc)
    ;ticks=['.005','.010','.015','.020','.025',' ',' ']
    ticks2=dindgen(n_elements(h),start=inc,increment=inc)


    plot1=barplot(ticks2,h,histogram=1,dimensions=[1000,800])
    plot1.ylog=1
    
    ;plot1.xtickname=ticks
    plot1.xtext_orientation=270
    plot1.YRANGE=[0,100000]
    plot1.xminor=0
    plot1.yticklen=1
    plot1.ysubticklen=.08
 
    
    plot1.xtickinterval=.005
    plot1.xrange=[950,300]
    plot1.xtitle='LWC g m!u-3!n'
    plot1.ytitle='Frequency'
    plot1.font_size=24
    
    stop
    plot1.save, 'clearairhist.ps'
  endif










;  if runcalc eq 0 then restore, 'hist.sav'
;
;  callevel=['400 mb Ind','600 mb Ind','900 mb Ind','400 mb True','600 mb True','900 mb True']
;  holder=dindgen(n_elements(callevel),start=0,increment=1)
;  kmeans=[lwcmean400ind,lwcmean600ind,lwcmean900ind,lwcmean400true,lwcmean600true,lwcmean900true]
;  devs=[lwcdev400ind,lwcdev600ind,lwcdev900ind,lwcdev400true,lwcdev600true,lwcdev900true]
;
;  plot1=scatterplot(holder,kmeans,dimensions=[1200,900], name='% Slope Correction')
;  ;plot1.xrange=[0,10]
;  ;plot1.yrange=[40,150]
;  plot1.xtickname=callevel
;  plot1.sym_filled=1
;  plot1.font_size=16
;  plot1.title='All Flights Clear Air LWC Mean Error'
;  plot1.ytitle='Absolute Mean Error g m!U-3!N'
;  plot1.xtitle='k Regression Flight Level and Airspeed Type'
;
;  ;leg1=legend(target=[plot1,plot2],shadow=0)
;
;  plot2=errorplot(holder,kmeans, devs,/overplot,linestyle=6,errorbar_thick=2)
;
;  plot2.xTICKVALUES=[0,1,2,3,4,5,6]
;  plot2.xrange=[-1,6]
;  plot2.xminor=0

  
  return

end





;p1=scatterplot(g.pmb[g.clearair],g.lwc[g.clearair])

;        if ktype[k] eq 'indicated' and kLevel[i] eq '400' then begin
;          lwcmean400ind=lwcmean
;          lwcdev400ind=dev
;        endif
;
;        if ktype[k] eq 'indicated' and kLevel[i] eq '600' then begin
;          lwcmean600ind=lwcmean
;          lwcdev600ind=dev
;        endif
;
;        if ktype[k] eq 'indicated' and kLevel[i] eq '900' then begin
;          lwcmean900ind=lwcmean
;          lwcdev900ind=dev
;        endif
;
;        if ktype[k] eq 'true' and kLevel[i] eq '400' then begin
;          lwcmean400true=lwcmean
;          lwcdev400true=dev
;        endif
;
;        if ktype[k] eq 'true' and kLevel[i] eq '600' then begin
;          lwcmean600true=lwcmean
;          lwcdev600true=dev
;        endif
;
;        if ktype[k] eq 'true' and kLevel[i] eq '900' then begin
;          lwcmean900true=lwcmean
;          lwcdev900true=dev
;        endif