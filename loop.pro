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

    endfor
    
    color=d.color
    
    
    

;    lwc=lwc
;    as=as
;    pmb=pmb
;    cdplwc=cdplwc
;    twc=twc
;    cdpdbar=cdpdbar
;    trf=trf
;    signalLiq=signalLiq
;    signalTot=signalTot
;    clearairLiq=clearairLiq
;    clearairTot=clearairTot
;    dEff=dEff
;    vvd=vvd
;    vmd=vmd
;    cdpconc=cdpconc
;    cdpacc=cdpacc
;    lwcVarE=lwcVarE
;    coleliq=coleliq
;    coletot=coletot
;    twcVarE=twcVarE
;    dBarB=dBarB
;    colEtot2=coleTot2
;    colEtot3=colEtot3
;    cipmodconc0=cipmodconc0
;    cipmodconc1=cipmodconc1
;    cipmodconc2=cipmodconc2
;    lwc100=lwc100
;    lwcErrColE=lwcErrColE
    



    save,filename='loopdata.sav',lwc,twc,cdpdbar,trf,twcVarE,colETot,$
      as,pmb,cdplwc,clearairLiq,clearairTot,signalLiq,colELiq,$
      signalTot,cdpconc,cdpacc,lwcVarE,dBarB,dEff,vvd,vmd,lwcErrColE,$
      coletot2,colEtot3,cipmodconc0,cipmodconc1,cipmodconc2,lwc100,color,$
      
;      lwcLO1,twcLO1,cdpdbarLO1,trfLO1,twcVarELO1,colETotLO1,$
;      asLO1,pmbLO1,cdplwcLO1,clearairLiqLO1,clearairTotLO1,signalLiqLO1,colELiqLO1,$
;      signalTotLO1,cdpconcLO1,cdpaccLO1,lwcVarELO1,dBarBLO1,dEffLO1,vvdLO1,vmdLO1,lwcErrColELO1,$
;      coletot2LO1,colEtot3LO1,cipmodconc0LO1,cipmodconc1LO1,cipmodconc2LO1,lwc100LO1,$
;      
;      lwcLO2,twcLO2,cdpdbarLO2,trfLO2,twcVarELO2,colETotLO2,$
;      asLO2,pmbLO2,cdplwcLO2,clearairLiqLO2,clearairTotLO2,signalLiqLO2,colELiqLO2,$
;      signalTotLO2,cdpconcLO2,cdpaccLO2,lwcVarELO2,dBarBLO2,dEffLO2,vvdLO2,vmdLO2,lwcErrColELO2,$
;      coletot2LO2,colEtot3LO2,cipmodconc0LO2,cipmodconc1LO2,cipmodconc2LO2,lwc100LO2,$
      
      /verbose
      




end