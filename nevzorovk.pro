pro nevzorovK

  ;airspeed type (true, indicated)
  airspeedType='true'

  ;select flight level (900,600,400)
  flightLevel=400

  findRange='true'

  ;select regression (linear, geometric)
  regression='geometric'
  
  ;select if cope mission (0,1)
  cope=1
  
  
  ;k for total (0,1)
  total=1

  ;path to ncl file
  if cope eq 0 then nclPath='/Volumes/sfaber1/research/nevzorov/121715/20151217.c1.nc'
  if cope eq 1 then nclPath='/Volumes/sfaber1/research/nevzorov/data/070913/20130709.c1.nc'



  ;-----run loadvar-----


  ;liquid reference voltage [V]
  vlwcref=loadvar('vlwcref', filename=nclPath)

  ;liquid collector voltage [V]
  vlwccol=loadvar('vlwccol', filename=nclPath)

  ;total reference voltage [V]
  vtwcref=loadvar('vtwcref', filename=nclPath)

  ;total collector voltage [V]
  vtwccol=loadvar('vtwccol', filename=nclPath)

  ;liquid reference current [A]
  ilwcref=loadvar('ilwcref', filename=nclPath)

  ;liquid collector current [A]
  ilwccol=loadvar('ilwccol', filename=nclPath)

  ;total reference current [A]
  itwcref=loadvar('itwcref', filename=nclPath)

  ;total collector current [A]
  itwccol=loadvar('itwccol', filename=nclPath)


  ;------------REDEFINE VARS FOR TOTAL-------------------
  if total eq 1 then begin
    vlwccol=vtwccol
    ilwccol=itwccol
  endif
  
  



  ;reverse flow static temperature [C]
  trf=loadvar('trf', filename=nclPath)

  ;true airspeed [m/s]
  tas=loadvar('tas', filename=nclPath)

  ;indicated airspeed [K]
  aias=loadvar('aias', filename=nclPath)

  ;altitude (radar) [m]
  altRad=loadvar('ralt3', filename=nclPath)

  ;time formatted
  timeForm=loadvar('TIME', filename=nclPath)

  ;time seconds since 2015-01-01 00:00:00 +0000
  time=loadvar('time', filename=nclPath)

  ;h20 mixing ratio from licor
  mix=loadvar('mr', filename=nclPath)

  ;pressure from rosemount sensor [mb]
  pmb=loadvar('pmb', filename=nclPath)

  ;temperature from rosemount sensor [C]
  tempRose=loadvar('trose', filename=nclPath)

  ;pressure derived altitude [m]
  altP=loadvar('z', filename=nclPath)

  aiasMs=aias*.514444



  if airspeedType eq 'true' then begin
    as=tas
  endif

  if airspeedType eq 'indicated' then begin
    as=aiasMs
  endif

  ;unit vector for regression line
  unitVector=dindgen(n_elements(time), start=0, increment=1)

  airspeeds=dindgen(101, start=110, increment=1)
  airspeeds=airspeeds*.514444

  pres900=dindgen(n_elements(airspeeds), start=906.686, increment=0.)
  pres600=dindgen(n_elements(airspeeds), start=618.583, increment=0.)
  pres400=dindgen(n_elements(airspeeds), start=409.319, increment=0.)


  ;----------calculations------------

  ;--find start/end time indexes--




  ;-----For 900mb 070913 case-----
  ;airspeed A
  aStartA=where(timeForm eq 120200)
  aEndA=where(timeForm eq 120435)

  ;airspeed B
  bStartA=where(timeForm eq 115833)
  bEndA=where(timeForm eq 120030)

  ;airspeed C
  cStartA=where(timeForm eq 115540)
  cEndA=where(timeForm eq 115800)

  ;airspeed D
  dStartA=where(timeForm eq 115228)
  dEndA=where(timeForm eq 115507)

  ;airspeed E
  eStartA=where(timeForm eq 114652)
  eEndA=where(timeForm eq 114920)







  ;-----For 600mb 070913 case------
  ;airspeed A
  aStartB=where(timeForm eq 113655)
  aEndB=where(timeForm eq 113859)

  ;airspeed B
  bStartB=where(timeForm eq 113438)
  bEndB=where(timeForm eq 113559)

  ;airspeed C
  cStartB=where(timeForm eq 113116)
  cEndB=where(timeForm eq 113259)

  ;airspeed D
  dStartB=where(timeForm eq 112837)
  dEndB=where(timeForm eq 113059)

  ;airspeed E
  eStartB=where(timeForm eq 112528)
  eEndB=where(timeForm eq 112659)






  ;-----For 400mb 070913 case 1047-1118------
  ;airspeed A
  aStartC=where(timeForm eq 105000)
  aEndC=where(timeForm eq 105120)

  ;airspeed B
  bStartC=where(timeForm eq 104740)
  bEndC=where(timeForm eq 104915)

  ;airspeed C
  cStartC=where(timeForm eq 105258)
  cEndC=where(timeForm eq 105455)

  ;airspeed D
  dStartC=where(timeForm eq 105530)
  dEndC=where(timeForm eq 105640)

  ;airspeed E
  eStartC=where(timeForm eq 110230)
  eEndC=where(timeForm eq 110400)





  if flightLevel eq 900 then begin
    aStart=aStartA
    aEnd=aEndA
    bStart=bStartA
    bEnd=bEndA
    cStart=cStartA
    cEnd=cEndA
    dStart=dStartA
    dEnd=dEndA
    eStart=eStartA
    eEnd=eEndA
  endif

  if flightLevel eq 600 then begin
    aStart=aStartB
    aEnd=aEndB
    bStart=bStartB
    bEnd=bEndB
    cStart=cStartB
    cEnd=cEndB
    dStart=dStartB
    dEnd=dEndB
    eStart=eStartB
    eEnd=eEndB
  endif

  if flightLevel eq 400 then begin
    aStart=aStartC
    aEnd=aEndC
    bStart=bStartC
    bEnd=bEndC
    cStart=cStartC
    cEnd=cEndC
    dStart=dStartC
    dEnd=dEndC
    eStart=eStartC
    eEnd=eEndC
  endif



  ;power calculations
  liqColPower=vlwccol*ilwccol
  liqRefPower=vlwcref*ilwcref
  liqK=liqColPower/liqRefPower

  totalColPower=vlwccol*ilwccol
  totalRefPower=vlwcref*ilwcref
  totalK=totalColPower/totalRefPower



  ;--define data ranges--

  ;airspeed A
  liqKA=liqk[aStart:aEnd]
  liqKAMean=mean(liqKA)
  totalKA=totalk[aStart:aEnd]
  totalKAMean=mean(totalKA)
  asA=as[aStart:aEnd]
  timeFormA=timeForm[aStart:aEnd]
  asAMean=mean(asA)
  pA=pmb[aStart:aEnd]
  pAMean=mean(pA)


  ;airspeed B
  liqKB=liqk[bStart:bEnd]
  liqKBMean=mean(liqKB)
  totalKB=totalk[bStart:bEnd]
  totalKBMean=mean(totalKB)
  asB=as[bStart:bEnd]
  timeFormB=timeForm[bStart:bEnd]
  asBMean=mean(asB)
  pB=pmb[bStart:bEnd]
  pBMean=mean(pB)

  ;airspeed C
  liqKC=liqk[cStart:cEnd]
  liqKCMean=mean(liqKC)
  totalKC=totalk[cStart:cEnd]
  totalKCMean=mean(totalKC)
  asC=as[cStart:cEnd]
  timeFormC=timeForm[cStart:cEnd]
  asCMean=mean(asC)
  pC=pmb[cStart:cEnd]
  pCMean=mean(pC)

  ;airspeed D
  liqKD=liqk[dStart:dEnd]
  liqKDMean=mean(liqKD)
  totalKD=totalk[dStart:dEnd]
  totalKDMean=mean(totalKD)
  asD=as[dStart:dEnd]
  timeFormD=timeForm[dStart:dEnd]
  asDMean=mean(asD)
  pD=pmb[dStart:dEnd]
  pDMean=mean(pD)

  ;airspeed E
  liqKE=liqk[eStart:eEnd]
  liqKEMean=mean(liqKE)
  totalKE=totalk[eStart:eEnd]
  totalKEMean=mean(totalKE)
  asE=as[eStart:eEnd]
  timeFormE=timeForm[eStart:eEnd]
  asEMean=mean(asE)
  pE=pmb[eStart:eEnd]
  pEMean=mean(pE)

  ;combined sampled liqK values
  liqKCon=[liqKA,liqKB,liqKC,liqKD,liqKE]
  totalKCon=[totalKA,totalKB,totalKC,totalKD,totalKE]
  asCon=[asA,asB,asC,asD,asE]
  pCon=[pA,pB,pC,pD,pE]

  liqKConMean=[liqKAMean,liqKBMean,liqKCMean,liqKDMean,liqKEMean]
  totalKConMean=[totalKAMean,totalKBMean,totalKCMean,totalKDMean,totalKEMean]
  asConMean=[asAMean,asBMean,asCMean,asDMean,asEMean]
  pConMean=[pAMean,pBMean,pCMean,pDMean,pEmean]
  pConMeanAll=mean(pConMean)



  if findRange eq 'true' then begin


    ;--CACLULATE X RANGE--
    xAllA=[as[aStartA:aEndA],as[bStartA:bEndA],as[cStartA:cEndA],as[dStartA:dEndA],as[eStartA:eEndA]]
    xAllB=[as[aStartB:aEndB],as[bStartB:bEndB],as[cStartB:cEndB],as[dStartB:dEndB],as[eStartB:eEndB]]
    xAllC=[as[aStartC:aEndC],as[bStartC:bEndC],as[cStartC:cEndC],as[dStartC:dEndC],as[eStartC:eEndC]]

    xRangeA=max(xAllA)-min(xAllA)
    xRangeB=max(xAllB)-min(xAllB)
    xRangeC=max(xAllC)-min(xAllC)

    xMaxAll=max([xAllA,xAllB,xAllC])
    xMinAll=min([xAllA,xAllB,xAllC])
    ;
    ;  xConRange=max(asCon)-min(asCon)
    ;  xMarg=(xRangeAll-xConRange)/2.

    xLeft=xMinAll-10.
    xRight=xMaxAll+10.



    ;--CACLULATE Y RANGE--
    liqColPowerA=[vlwccol[aStartA:aEndA]*ilwccol[aStartA:aEndA],vlwccol[bStartA:bEndA]*ilwccol[bStartA:bEndA],vlwccol[cStartA:cEndA]*ilwccol[cStartA:cEndA],vlwccol[dStartA:dEndA]*ilwccol[dStartA:dEndA],vlwccol[eStartA:eEndA]*ilwccol[eStartA:eEndA]]
    liqColPowerB=[vlwccol[aStartB:aEndB]*ilwccol[aStartB:aEndB],vlwccol[bStartB:bEndB]*ilwccol[bStartB:bEndB],vlwccol[cStartB:cEndB]*ilwccol[cStartB:cEndB],vlwccol[dStartB:dEndB]*ilwccol[dStartB:dEndB],vlwccol[eStartB:eEndB]*ilwccol[eStartB:eEndB]]
    liqColPowerC=[vlwccol[aStartC:aEndC]*ilwccol[aStartC:aEndC],vlwccol[bStartC:bEndC]*ilwccol[bStartC:bEndC],vlwccol[cStartC:cEndC]*ilwccol[cStartC:cEndC],vlwccol[dStartC:dEndC]*ilwccol[dStartC:dEndC],vlwccol[eStartC:eEndC]*ilwccol[eStartC:eEndC]]

    liqRefPowerA=[vlwcref[aStartA:aEndA]*ilwcref[aStartA:aEndA],vlwcref[bStartA:bEndA]*ilwcref[bStartA:bEndA],vlwcref[cStartA:cEndA]*ilwcref[cStartA:cEndA],vlwcref[dStartA:dEndA]*ilwcref[dStartA:dEndA],vlwcref[eStartA:eEndA]*ilwcref[eStartA:eEndA]]
    liqRefPowerB=[vlwcref[aStartB:aEndB]*ilwcref[aStartB:aEndB],vlwcref[bStartB:bEndB]*ilwcref[bStartB:bEndB],vlwcref[cStartB:cEndB]*ilwcref[cStartB:cEndB],vlwcref[dStartB:dEndB]*ilwcref[dStartB:dEndB],vlwcref[eStartB:eEndB]*ilwcref[eStartB:eEndB]]
    liqRefPowerC=[vlwcref[aStartC:aEndC]*ilwcref[aStartC:aEndC],vlwcref[bStartC:bEndC]*ilwcref[bStartC:bEndC],vlwcref[cStartC:cEndC]*ilwcref[cStartC:cEndC],vlwcref[dStartC:dEndC]*ilwcref[dStartC:dEndC],vlwcref[eStartC:eEndC]*ilwcref[eStartC:eEndC]]

    liqkAY=liqColPowerA/liqRefPowerA
    liqkBY=liqColPowerB/liqRefPowerB
    liqkCY=liqColPowerC/liqRefPowerC

    yRangeA=max(liqkAY)-min(liqkAY)
    yRangeB=max(liqkBY)-min(liqkBY)
    yRangeC=max(liqkCY)-min(liqkCY)

    yMaxAll=max([liqkAY,liqkBY,liqkCY])
    yMinAll=min([liqkAY,liqkBY,liqkCY])


    yLow=yMinAll-.02
    yHigh=yMaxAll+.02




  endif




  ;-----------gen plots-----------


      plot1=scatterplot(asA,liqKA,symbol='o',sym_size='.6',name=string(asAMean),sym_fill_color='black',dimensions=[1200,900])
      plot2=scatterplot(asB,liqKB,symbol='o',sym_size='.6',name=string(asBMean),sym_color='blue',sym_fill_color='blue',/overplot)
      plot3=scatterplot(asC,liqKC,symbol='o',sym_size='.6',name=string(asCMean),sym_color='dark slate grey',sym_fill_color='dark slate grey',/overplot)
      plot4=scatterplot(asD,liqKD,symbol='o',sym_size='.6',name=string(asDMean),sym_color='green',sym_fill_color='green',/overplot)
      plot5=scatterplot(asE,liqKE,symbol='o',sym_size='.6',name=string(asEMean),sym_color='light sea green',sym_fill_color='light sea green',/overplot)
      legend1=legend(target=[plot1,plot2,plot3,plot4,plot5],shadow=0)

      if total eq 0 then atitle=string('Liquid K vs ',airspeedType,' Airspeed -',pConMeanAll)
      if total eq 1 then atitle=string('Total K vs ',airspeedType,' Airspeed -',pConMeanAll)
      xtitle=string(airspeedType+' Airspeed [m/s]')
      plot1.title=atitle
      plot1.xtitle=xtitle

      if regression eq 'linear' then begin
        plot1Linfit=linfit(asCon,liqKCon,yfit=yfit)
        regLine=(plot1linfit[1])*unitVector+plot1LinFit[0]
        plot1b=plot(unitVector,regLine,'r',/overplot)

        text1=string(plot1Linfit)
        text1A=text(50,10,text1,/device)

        yFitErrorMean=mean(abs(liqKCon-yFit))
        text2=string('Mean Y Fit Error=',yFitErrorMean)
        text2a=text(250,10,text2,/device)
      endif


      if regression eq 'geometric' then begin

        geofitb=poly_fit(asCon,liqKCon,2)
        geoFit=comfit(asCon,liqKCon,[geofitb[0],.2,geofitb[2]],yfit=yfit,/geometric,itmax=4000,iter=its) ;400 true
        regLine=(geoFit[0])*unitVector^geoFit[1]+geoFit[2]
        ;regLine=(geoFit[0])+unitVector*(geoFit[1])+(geoFit[2])*unitVector^2.
        plot1b=plot(unitVector,regLine,'r',/overplot)
        print, its

        print,geoFit
      endif

      plot1.xrange=[xLeft,xRight]
      plot1.yrange=[yLow,yHigh]
      
      if total eq 1 then begin
        plot1.xrange=[55,115]
        plot1.yrange=[.5,1]
      endif

      plot1.ytitle='Liquid K'


end