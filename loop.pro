pro loop



    lwc=[]
    as=[]
    pmb=[]
    cdplwc=[]
    twc=[]
    lwcx=[]
    cdplwcx=[]
    twcx=[]
    colETotTest=[]
    cdpdbar=[]
    twcnocolecor=[]
    trf=[]
    signalLiq=[]
    signalTot=[]
    clearairLiq=[]
    clearairTot=[]
    cdpThirdM=[]
    cdpconc=[]
    ltdiff=[]
    tldiff=[]
    dbar3m=[]
    cdpacc=[]
    deff=[]
    othervar=[]
    cdpDEff=[]
    cdpVolMean=[]
    cdpMassMean=[]
    lwcVarE=[]
    coleliq=[]
    coletot=[]
    twcVarE=[]
    cdpdbar2=[]
    twcVarE2=[]
    colEtot2=[]
    colEtot3=[]
    lwcVarEolde=[]
    colELiq3=[]
    lwcolde=[]
    cipmodconc0=[]
    cipmodconc1=[]
    cipmodconc2=[]
    lwc100=[]

    


    flight=['0710','0718','0725','0727','0728','0729','0802','0803','0806','0807','0814','0815','0817a','0817b']
    ;flight=['1124','1217','0120','0125','0304','0307']


    for i=0, n_elements(flight)-1 do begin


      g= nevBase(flight[i],'indicated','400')

      print,flight[i]

      
      lwc=[lwc,g.lwc]
      as=[as,g.as]
      pmb=[pmb,g.pmb]
      cdplwc=[cdplwc,g.cdplwc]
      twc=[twc,g.twc]
      cdpdbar=[cdpdbar,g.cdpdbar]
      trf=[trf,g.trf]
      signalLiq=[signalLiq,g.signalLiq]
      signalTot=[signalTot,g.signalTot]
      clearairLiq=[clearairLiq,g.clearairLiq]
      clearairTot=[clearairTot,g.clearairTot]
      cdpDEff=[cdpDEff,g.cdpDEff]
      cdpVolMean=[cdpVolMean,g.cdpVolMean]
      cdpMassMean=[cdpMassMean,g.cdpMassMean]
      cdpconc=[cdpconc,g.cdpconc]
      cdpacc=[cdpacc,g.cdpacc]
      lwcVarE=[lwcVarE,g.lwcVarE]
      coleliq=[coleliq,g.coleliq]
      coletot=[coletot,g.coletot]
      twcVarE=[twcVarE,g.twcVarE]
      cdpdbar2=[cdpdbar2,g.cdpdbar2]
      twcVarE2=[twcVarE2,g.twcVarE2]
      colEtot2=[coleTot2,g.coletot2]
      colEtot3=[colEtot3,g.colEtot3]
      lwcVarEolde=[lwcVarEolde,g.lwcVarEolde]
      colELiq3=[colELiq3,g.colELiq3]
      cipmodconc0=[cipmodconc0,g.cipmodconc0]
      cipmodconc1=[cipmodconc1,g.cipmodconc1]
      cipmodconc2=[cipmodconc2,g.cipmodconc2]
      lwc100=[lwc100,g.lwc100]

      color=g.color
      
      
    endfor
    
    
    
    stop
    
    

    ;liqOnly=where(trf gt -3. and lwc gt .02 and lwc lt .8 and cdpacc gt 10.)
    ;liqOnly=where(trf gt -3. and lwc lt .8 and cdpdbar gt 2.)


    x=dindgen(n_elements(cipmodconc0))
    p1=scatterplot(x,cipmodconc0,dimensions=[1400,1200])
    p2=scatterplot(x,cipmodconc1,sym_color='blue',/overplot)
    p3=scatterplot(x,cipmodconc2,sym_color='red',/overplot)



    save,filename='loopdata.sav',lwc,twc,cdpdbar,trf,twcVarE,colETot,$
      as,pmb,cdplwc,clearairLiq,clearairTot,signalLiq,colELiq,$
      signalTot,cdpconc,ltdiff,tldiff,dbar3m,cdpacc,lwcVarE,cdpdbar2,$
      dBarBI,cdpSecondM,cdpThirdM,cdpFourthM,cdpDEff,cdpVolMean,cdpMassMean,$
      twcVarE2,coletot2,colEtot3,lwcVarEolde,colELiq3,lwcolde,$
      cipmodconc0,cipmodconc1,cipmodconc2,lwc100,color,/verbose




end