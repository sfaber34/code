pro colETotb

  stuff='testdbins'
  
  
  
  
  
  if stuff eq 'testdbins' then begin
    restore,'loopdata.sav'
    
    
    
    
    binint=3

    binsize=5
    bincount=60/binsize

    dBarBI=dblarr(bincount,n_elements(pmb))
    dbarbinn=dindgen(bincount,start=0,increment=0)
    lwcliqonly=lwc[liqonly]
    twcliqonly=twc[liqonly]
    cdpdbarliqonly=cdpdbar[liqonly]
    cdpconcliqonly=cdpconc[liqonly]


    for i=0,bincount-1 do begin
      ind=where(cdpdbarliqonly ge binint and cdpdbarliqonly le binint+binsize)

      dbarbinn[i]=n_elements(ind)

      p=n_elements(dBarBI[i,*])-n_elements(ind)
      ind=[ind,replicate(!values.F_nan,p)]

      dBarBI[i,*]=ind


      binint=binint+binsize
    endfor
    
    
    cgcleanup

    color=['black','blue','red','green','purple','orange','pink','yellow','sky']
    for i=0,n_elements(dbarbi[*,0])-1 do begin
      
      liqonlyind=where(finite(dbarbi[i,*]) eq 1)
      
      
      
      p1=scatterplot(lwcliqonly[dbarbi[i,*]],lwcliqonly[dbarbi[i,*]]-twcliqonly[dbarbi[i,*]],dimensions=[1600,1000],sym_color=color[i],sym_size=.5,/overplot)
      cole=linfit(lwcliqonly[dbarbi[i,*]],lwcliqonly[dbarbi[i,*]]-twcliqonly[dbarbi[i,*]])
      print,1.-cole[1]
    endfor
    
   stop
    
    for i=0,n_elements(dBarBI[*,0])-1 do begin
      k=0
      for j=0,n_elements(dBarBI[0,*])-1 do begin
        if dBarBI[i,j] gt 0 and dBarBI[i,j] ne !values.F_nan then begin
          dBarBISave[i,k]=dBarBI[i,j]
          k++
        endif
      endfor  
    endfor  
    
    firstM=dindgen(n_elements(dBarBISave[*,0]),start=0,increment=0)
    thirdM=dindgen(n_elements(dBarBISave[*,0]),start=0,increment=0)
    
    firstM=dblarr(n_elements(dBarBISave[*,0]),n_elements(dBarBISave[0,*]))
    
    for i=0,n_elements(dBarBISave[*,0])-1 do begin
      savedvals=[]
      for j=0,n_elements(dBarBISave[0,*])-1 do begin
        savedvals=[savedvals,cdpdbar[dBarBISave[i,j]]]
      endfor
      firstM[i,*]=savedvals
      ;thirdM=(savedvals)^3.
    endfor
    
    stop
    
;    binint3m=0
;
;    binsize3m=1000
;    bincount3m=1.2d5/binsize3m
;    
;    dbarbinn=dindgen(bincount3m,start=0,increment=0)
;    dbarbi3m=dblarr(bincount3m,n_elements(pmb))
;    
;    for i=0,bincount3m-1 do begin
;      ind=where(dbarcube ge binint3m and dbarcube le binint3m+binsize3m)
;
;      dbarbinn[i]=n_elements(ind)
;
;      p=n_elements(dBarBI3m[i,*])-n_elements(ind)
;      ind=[ind,replicate(!values.F_nan,p)]
;
;      dBarBI3m[i,*]=ind
;
;      binint3m=binint3m+binsize3m
;    endfor
    
    stop
    
    
    
    
    stop
;    
;    
;    
;    for i=0,bincount-1 do begin
;      if i eq 0 then step=binsize-1
;      if i gt 0 then step=binsize
;
;      ind=where(cdpdbar ge binint and cdpdbar le binint+step)
;
;      dbarbinn[i]=n_elements(ind)
;      dbarbinmean[i]=mean(cdpdbar[ind])
;      dbar3m[i]=mean(dbarcube[ind])
;      binint=binint+step
;    endfor
      
    
    
    stop
  endif




  if stuff eq 'fitcurve3' then begin
    cgcleanup

    restore,'loopdata.sav'
    
    
       
    unit=dindgen(14, start=0, increment=.2)
   
    lwcliqonly=lwc[liqonly]
    twcliqonly=twc[liqonly]
    p1=scatterplot(lwcliqonly,lwcliqonly-twcliqOnly,sym_color='black',symbol='+',dimensions=[1600,1000])

    
    geo=poly_fit(lwcliqonly,lwcliqonly-twcliqonly,3,yfit=yfitb)
    lin=ladfit(lwc,lwc-twc)


    lwcsort=sort(lwcliqonly)
    lwcsorted=lwcliqonly[lwcsort]
    yfitb=yfitb[lwcsort]

    ;p2=plot([],[],'r',/overplot)
    p2=plot(lwcsorted,yfitb,'r',/overplot)
    
    m=geo[0]+geo[1]*unit+geo[2]*unit^2.+geo[3]*unit^3.
    mshift=shift(m,1)
    mdiff=m-mshift
    
    stop
  endif









  if stuff eq 'directComp' then begin


    zeros=dindgen(10000,start=0., increment=0.)

    lwc=lwc[liqonly]
    twc=twc[liqonly]
    CDPDBAR=CDPDBAR[liqonly]
    CDPLWC=CDPLWC[liqonly]
    TRF=[liqonly]
    PMB=PMB[liqonly]

    lwc=[zeros,lwc]
    twc=[zeros,twc]
    

    p1=scatterplot(lwc,twc,sym_color='black',symbol='+',dimensions=[1100,1100])

  

    p1.xrange=[0,2.6]
    p1.yrange=[0,2.6]
    
    p2=plot([0,2.6],[0,2.6],'g',thick=2,/overplot)


    geofitb=ladfit([zeros,lwc],[zeros,TWC])

    print,(geofitb[1]-1.)*100.


    p3=plot([0,2.6],[0,2.6*geofitb[1]+geofitb[0]],'r',thick=2,/overplot)

    stop
  endif








  if stuff eq 'testVarColETot2' then begin
    restore,'concatsaves.sav'
    x=where(trfcon gt 5. and cdpdbarcon gt 3 and colETotTestCon gt 0 and colETotTestCon le 1)
    y=where(trfcon lt -5.)

    xs=dindgen(1000,start=0,increment=0)
    ys=dindgen(1000,start=.1,increment=0)

    p1=scatterplot(cdpdbarcon[x],lwccon[x]/twcnoecorcon[x],sym_color='red',symbol='.',dimensions=[1400,1000])

    xfit=[xs]
    yfit=[ys]

    pol=poly_fit(cdpdbarcon[x],colETotTestCon[x],3,yfit=yfit)
    geo=comfit(cdpdbarcon[x],colETotTestCon[x],[pol[1],.1,pol[0]],yfit=yfitb,/geometric,itmax=10000)

    xfilter=cdpdbarcon[x]
    sortx=sort(xfilter)
    xfilter=xfilter[sortx]
    yfilter=yfit[sortx]
    yfilterb=yfitb[sortx]

    p2=plot(xfilter,yfilter,/overplot)
    p3=plot(xfilter,yfilterb,/overplot,'blue')
    ;  p3=plot([0,2.7],[0,2.7],'g',thick=2,/overplot)
    ;  p3.xrange=[0,2.7]
    ;  p3.yrange=[0,2.7]
    stop
  endif









  if stuff eq 'testVarColETot' then begin
    ;cgcleanup
    lwccon=[]
    ascon=[]
    pmbcon=[]
    cdplwccon=[]
    twccon=[]
    lwcconx=[]
    cdplwcconx=[]
    twcconx=[]
    colETotTestCon=[]
    cdpdbarcon=[]
    twcnocolecorcon=[]
    trfcon=[]
    signalLiqcon=[]
    signalTotcon=[]
    clearairLiqCon=[]
    clearairTotCon=[]
    zeros=dindgen(1000,start=0.,increment=0.)

    flight=['0710','0725','0727','0728','0729','0803','0806','0807','0814','0815']
    ;flight='0806'

    color=['black','blue']


    for i=0, n_elements(flight)-1 do begin



      g= nevBase(flight[i],'indicated','400')

      x=where(g.trf gt 5. and g.lwc gt .02)


      ;p2=scatterplot(g.cdpdbar[x],g.lwc[x]-g.twcnoecor[x],sym_color='black',symbol='+',dimensions=[968,1000])
      p3=scatterplot(g.lwc[g.liqonly],g.twc[g.liqonly],sym_color='green',symbol='+',dimensions=[1400,1000],/overplot)


      print,'--------------------------------------------------------'
      print,flight[i]
      print,n_elements(x)


      lwccon=[lwccon,g.lwc[g.liqonly]]
      ascon=[ascon,g.as[g.liqonly]]
      pmbcon=[pmbcon,g.pmb[g.liqonly]]
      cdplwccon=[cdplwccon,g.cdplwc[g.liqonly]]
      twccon=[twccon,g.twc[g.liqonly]]
      ;twcnocolecorcon=[twcnocolecorcon,g.twcNoECor[g.liqonly]]
      cdpdbarcon=[cdpdbarcon,g.cdpdbar[g.liqonly]]
      
      trfcon=[trfcon,g.trf[g.liqonly]]

      clearairLiqCon=[clearairLiqCon,g.clearairLiq[g.liqonly]]
      clearairTotCon=[clearairTotCon,g.clearairTot[g.liqonly]]

    endfor
    stop

    p2=scatterplot(lwccon,twcnocolecorcon,dimensions=[1000,1000],sym_color='blue',symbol='+')
    p5=scatterplot(lwccon,twccon,/overplot,sym_color='orange',symbol='+')

    p2.yrange=[0,3]
    p2.xrange=[0,3]
    p5=plot([0,3],[0,3],dimensions=[1000,1000],color='green',thick=2,linestyle=2,/overplot)
    ;save,filename='Only.sav',lwccon,twccon,colETotTestCon,cdpdbarcon,twcnocolecorcon,trfcon,ascon,pmbcon,cdplwccon




    lin=ladfit([zeros,lwccon],[zeros,twcnocolecorcon])
    p3=plot([0,2.],[0+lin[0],2.*lin[1]+lin[0]],color='purple',thick=2,/overplot)
    print,'diff=',lin[1]-1.

    lin=ladfit([zeros,lwccon],[zeros,twccon])
    p4=plot([0,2.],[0+lin[0],2.*lin[1]+lin[0]],color='red',thick=2,/overplot)
    print,'diff cor=',lin[1]-1.


    p5=plot([0,2],[0,2],dimensions=[1000,1000],color='green',thick=2,linestyle=2,/overplot)
    p3.xrange=[0,2.]
    p3.yrange=[0,2.]


    stop
  endif














  if stuff eq 'fitcurve' then begin
    restore,'concatsaves.sav'

    x=where(colETotTestCon gt 0. and colETotTestCon lt .9)


    ay=dindgen(10000,start=.1, increment=0)
    ax=dindgen(10000,start=1., increment=0)

    ;  by=dindgen(100,start=.70, increment=0)
    ;  bx=dindgen(100,start=7., increment=0)
    by=dindgen(700,start=.880, increment=0)
    bx=dindgen(700,start=9., increment=0)
    cy=dindgen(10000,start=.820, increment=0)
    cx=dindgen(10000,start=40, increment=0)



    lwccon=lwccon[x]
    twccon=twccon[x]
    ;  colETotTestCon=[twotens,colETotTestCon[x],ones]
    ;  cdpdbarcon=[threes,cdpdbarcon[x],fourty]


    cdpdbarcon=[ax,cdpdbarcon[x],bx,cx]
    colETotTestCon=[ay,colETotTestCon[x],by,cy]

    p1=scatterplot(lwccon,twccon/twcnoecorcon,sym_color='red',symbol='+',dimensions=[968,1000])

    ;p1.xrange=[-.1,2.6]
    p1.yrange=[0,1.2]


    unitVector=dindgen(370, start=3., increment=.1)

    x=[3.,4.5,6.,7.5,9.,11.5,15.,21.5]
    y=[.2,.3,.4,.5,.6,.7,.8,.9]


    geofitb=poly_fit(cdpdbarcon,colETotTestCon,4)
    geoFit=comfit(cdpdbarcon,colETotTestCon,[geofitb[0],.2,geofitb[2]],yfit=yfit,/geometric,itmax=4000,iter=its,yerror=yerror) ;400 true

    regLine=(geoFit[0])*unitVector^geoFit[1]+geoFit[2]


    regLine2=dindgen(n_elements(unitVector))
    for i=0,n_elements(unitVector)-1 do begin
      if unitVector[i] le 25 then begin
        regLine2[i]=geofitb[0]+geofitb[1]*unitVector[i]+geofitb[2]*unitVector[i]^2.+geofitb[3]*unitVector[i]^3.+geofitb[4]*unitVector[i]^4.
      endif else begin
        regLine2[i]=0.72314992+unitVector[i]*0.0030687526
      endelse
    endfor

    p6=scatterplot(x,y,/overplot)

    print,mean(abs(yerror))

    plot1b=plot(unitVector,regLine,'blue',/overplot)
    plot1b=plot(unitVector,regLine2,'green',/overplot)

    stop
  endif








  if stuff eq 'liqOnlyPoints' then begin
    ;;cgcleanup
    lwccon=[]
    cdplwccon=[]
    twccon=[]
    lwcconx=[]
    cdplwcconx=[]
    twcconx=[]
    cdpdbarcon=[]
    trfcon=[]
    pmbcon=[]
    cdpconccon=[]

    flight=['0710','0725','0727','0728','0729','0803','0806','0807','0814','0815','0821','0802','0722','0718']
    ;flight='0806'

    color=['black','blue']


    for i=0, n_elements(flight)-1 do begin



      g= nevBase(flight[i],'indicated','400')

      x=where(g.pmb gt 0.)


      p2=scatterplot(g.lwc[x],g.twc[x],sym_color='red',symbol='+',/overplot,dimensions=[968,1000])


      print,'--------------------------------------------------------'
      print,flight[i]
      print,n_elements(x)
      p2.yrange=[0,3]
      p2.xrange=[0,3]

      lwccon=[lwccon,g.lwc]
      cdplwccon=[cdplwccon,g.cdplwc]
      twccon=[twccon,g.twc]
      cdpdbarcon=[cdpdbarcon,g.cdpdbar]
      trfcon=[trfcon,g.trf]
      pmbcon=[pmbcon,g.pmb]
      cdpconccon=[cdpconccon,g.cdpconc]

    endfor
    p5=plot([0,3],[0,3],dimensions=[1000,1000],color='green',thick=2,linestyle=2,/overplot)
    save,filename='concatsavesb2.sav',lwccon,twccon,colETotTestCon,cdpdbarcon,cdplwccon,trfcon,pmbcon,twctestcon,cdpconccon
    stop
    p2=scatterplot(lwclinx,twclinx,dimensions=[1000,1000],sym_color='red',symbol='+',/overplot)


    lin=ladfit(lwclinx,twclinx)
    p3=plot([0,2.],[0+lin[0],2.*lin[1]+lin[0]],color='blue',thick=2,/overplot)
    p5=plot([0,2],[0,2],dimensions=[1000,1000],color='green',thick=2,linestyle=2,/overplot)
    p1.xrange=[0,2.]
    p1.yrange=[0,2.]
    print,'diff=',lin[1]-1.

    stop
  endif

end