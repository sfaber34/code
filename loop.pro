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
    dEff=[]
    vvd=[]
    vmd=[]
    lwcVarE=[]
    coleliq=[]
    coletot=[]
    twcVarE=[]
    dBarB=[]
    colEtot2=[]
    colEtot3=[]
    cipmodconc0=[]
    cipmodconc1=[]
    cipmodconc2=[]
    lwc100=[]
    lwcErrColE=[]
    lwcNev1=[]
    lwcNev2=[]
    pvmlwc=[]
    expHeatLiq=[]
    lwcVarH=[]
    twcVarH=[]
    fsspConc=[]
    fsspLwc=[]
    pvmDEff=[]
    cdpTrans=[]
    cdpDofRej=[]
    


    flight=['0710','0718','0725','0727','0728','0729','0802','0803','0806','0807','0814','0815','0817a','0817b']
    ;flight=['1124','1217','0120','0125','0304','0307']


    for i=0, n_elements(flight)-1 do begin


      d=nevBase(flight[i],'indicated','400')

      
      lwc=[lwc,d.lwc]
      as=[as,d.as]
      pmb=[pmb,d.pmb]
      cdplwc=[cdplwc,d.cdplwc]
      twc=[twc,d.twc]
      cdpdbar=[cdpdbar,d.cdpdbar]
      trf=[trf,d.trf]
      signalLiq=[signalLiq,d.signalLiq]
      signalTot=[signalTot,d.signalTot]
      clearairLiq=[clearairLiq,d.clearairLiq]
      clearairTot=[clearairTot,d.clearairTot]
      dEff=[dEff,d.dEff]
      vvd=[vvd,d.vvd]
      vmd=[vmd,d.vmd]
      cdpconc=[cdpconc,d.cdpconc]
      cdpacc=[cdpacc,d.cdpacc]
      lwcVarE=[lwcVarE,d.lwcVarE]
      coleliq=[coleliq,d.coleliq]
      coletot=[coletot,d.coletot]
      twcVarE=[twcVarE,d.twcVarE]
      dBarB=[dBarB,d.dBarB]
      colEtot2=[coleTot2,d.coletot2]
      colEtot3=[colEtot3,d.colEtot3]
      cipmodconc0=[cipmodconc0,d.cipmodconc0]
      cipmodconc1=[cipmodconc1,d.cipmodconc1]
      cipmodconc2=[cipmodconc2,d.cipmodconc2]
      lwc100=[lwc100,d.lwc100]
      lwcErrColE=[lwcErrColE,d.lwcErrColE]
      lwcNev1=[lwcNev1,d.lwcNev1]
      lwcNev2=[lwcNev2,d.lwcNev2]
      pvmlwc=[pvmlwc,d.pvmlwc]
      expHeatLiq=[expHeatLiq,d.expHeatLiq]
      lwcVarH=[lwcVarH,d.lwcVarH]
      twcVarH=[twcVarH,d.twcVarH]
      fsspConc=[fsspConc,d.fsspConc]
      fsspLwc=[fsspLwc,d.fsspLwc]
      pvmDEff=[pvmDEff,d.pvmDEff]
      cdpTrans=[cdpTrans,d.cdpTrans]
      cdpDofRej=[cdpDofRej,d.cdpDofRej]
    endfor
    
    color=d.color
    
    

    save,filename='loopdata.sav',lwc,twc,cdpdbar,trf,twcVarE,colETot,$
      as,pmb,cdplwc,clearairLiq,clearairTot,signalLiq,colELiq,$
      signalTot,cdpconc,cdpacc,lwcVarE,dBarB,dEff,vvd,vmd,lwcErrColE,$
      coletot2,colEtot3,cipmodconc0,cipmodconc1,cipmodconc2,lwc100,color,$
      lwcNev2,pvmlwc,expHeatLiq,lwcVarH,twcVarH,fsspConc,lwcNev1,fsspLwc,$
      pvmDEff,cdpTrans,cdpDofRej,/verbose
   
end