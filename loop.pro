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
    tas=[]
    cdpBinSecSum=[]
    cdpBinN=[]
    cdpBinVar=[]
    cdpBinSkew=[]
    cdpBinKert=[]
    counts=[]
    cdpBinBimod=[]
    cdpBinMAD=[]
    cdpBinSD=[]
    colELiqUP=[]
    colELiqU=[]
    cdpTransEst=[]
    lwcNoPresCor=[]
    aiasms=[]
    
    nPoints=146852d

    flight=['0710','0718','0725','0727','0728','0729','0802','0803','0806','0807','0814','0815','0817a','0817b']
    ;flight=['1124','1217','0120','0125','0304','0307']


;    for i=0, n_elements(flight)-1 do begin
;      d=nevBase(flight[i],'indicated','400')
;      counts=[counts,n_elements(d.(1))]
;    endfor
;    
   cdpBinN=make_array(28,nPoints)
   cdpBinN[*,*]=!values.d_nan
    
    r=0
    for i=0, n_elements(flight)-1 do begin


      d=nevBase(flight[i],'indicated','400')
      
      cdpBinSecSumB=make_array(n_elements(d.(1)),start=0,increment=0)
      cdpBinNB=make_array(28,n_elements(d.(1)),start=0,increment=0)
      for j=0,n_elements(d.(1))-1 do begin
        cdpBinSecSumB[j]=total(d.cdpdbins[*,0,j])+200
        
      endfor
      
      o=0
      for m=r,n_elements(d.(1))+r-2 do begin
        cdpBinN[*,m]=d.cdpdbins[*,0,o]
        o++
      endfor
      
      cdpBinSecSum=[cdpBinSecSum,cdpBinSecSumB]
      lwc=[lwc,d.lwc]
      as=[as,d.as]
      pmb=[pmb,d.pmb]
      cdplwc=[cdplwc,d.cdplwc]
      twc=[twc,d.twc]
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
      tas=[tas,d.tas]
      cdpdbar=[cdpdbar,d.cdpdbar]
      cdpBinVar=[cdpBinVar,d.cdpBinVar]
      cdpBinSkew=[cdpBinSkew,d.cdpBinSkew]
      cdpBinKert=[cdpBinKert,d.cdpBinKert]
      cdpBinBimod=[cdpBinBimod,d.cdpBinBimod]
      cdpBinMAD=[cdpBinMAD,d.cdpBinMAD]
      cdpBinSD=[cdpBinSD,d.cdpBinSD]
      colELiqUP=[colELiqUP,d.colELiqUP]
      colELiqU=[colELiqU,d.colELiqU]
      cdpTransEst=[cdpTransEst,d.cdpTransEst]
      lwcNoPresCor=[lwcNoPresCor,d.lwcNoPresCor]
      aiasms=[aiasms,d.aiasms]
      
      r=r+n_elements(d.(1))
    endfor
    
    cdpBinNB=make_array(28,n_elements(pmb))
    t=0
    for u=0,n_elements(cdpBinN[0,*])-1 do begin
      if n_elements(where(finite(cdpBinN[*,u] gt 1))) gt 0 then begin
        cdpBinNB[*,t]=cdpBinN[*,u]
        t++
      endif
    endfor
    
    cdpBinN=cdpBinNB
    
    color=d.color
    
   
    save,filename='loopdata.sav',lwc,twc,cdpdbar,trf,twcVarE,colETot,$
      as,pmb,cdplwc,clearairLiq,clearairTot,signalLiq,colELiq,$
      signalTot,cdpconc,cdpacc,lwcVarE,dBarB,dEff,vvd,vmd,lwcErrColE,$
      coletot2,colEtot3,cipmodconc0,cipmodconc1,cipmodconc2,lwc100,color,$
      lwcNev2,pvmlwc,expHeatLiq,lwcVarH,twcVarH,fsspConc,lwcNev1,fsspLwc,$
      pvmDEff,cdpTrans,cdpDofRej,tas,cdpBinSecSum,cdpBinN,cdpBinVar,$
      cdpBinSkew,cdpBinKert,cdpBinBimod,cdpBinMAD,cdpBinSD,colELiqUP,colELiqU,$
      cdpTrans,cdpTransEst,aiasms,lwcnoprescor,/verbose
   
end