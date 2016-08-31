pro loop

level=400
suffix='082516400'

savename='loopdata'+suffix+'.sav'


common inds,inds
inds={starti:double(0)}

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
    coleliq=[]
    coletot=[]
    cdpDBarB=[]
    cipmodconc0=[]
    cipmodconc1=[]
    cipmodconc2=[]
    lwc100=[]
    lwcErrColE=[]
    lwcNev1=[]
    lwcNev2=[]
    expHeatLiq=[]
    fsspConc=[]
    fsspLwc=[]
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
    lwcNpc=[]
    flightSec=[]
    vlwccol=[]
    ilwccol=[]
    vlwcref=[]
    ilwcref=[]
    vtwccol=[]
    itwccol=[]
    vtwcref=[]
    itwcref=[]
    smoothSignalLiq=[]
    aias=[]
    iwc=[]
    cdpTransRej=[]
    cdpAdcOver=[]
    twcClearAiri=[]
    pliqnpc=[]
    lwcClearAirI=[]
    alpha=[]
    correctionLiq=[]
    threshLiq=[]
    smLiq=[]
    smLiqX=[]
    avroll=[]
    avpitch=[]
    betaAng=[]
    avyaw=[]
    twodp=[]
    lwcUB=[]
    cdpLwcB=[]
    
    startSec=0
    
    nPoints=146852d


    ;flight=['0710','0718','0725','0727','0728','0729','0802','0803','0806','0807','0814','0815','0817a','0817b']
    flight=['1124','1217','0120','0125','0307']
    flight='082516'
    ;flight=['0710','0718','0725','0727','0728','0729','0802','0803','0806','0807','0814','0815']
    ;flight='081816'
   
   cdpBinN=make_array(28,nPoints)
   cdpBinN[*,*]=!values.d_nan
    
    r=0
    for i=0, n_elements(flight)-1 do begin

      if i eq 0 then inds.starti=0
      
      d=nevBase(flight[i],level)
      
      
      o=0
      for m=r,n_elements(d.(1))+r-2 do begin
        cdpBinN[*,m]=d.cdpdbins[*,o]
        o++
      endfor
      

      cdpBinSecSum=[cdpBinSecSum,reform(total(d.cdpdbins,1))]
      lwc=[lwc,d.lwc]
      pmb=[pmb,d.pmb]
      cdplwc=[cdplwc,d.cdplwc]
      twc=[twc,d.twc]
      trf=[trf,d.trf]
      
      clearairTot=[clearairTot,d.clearairTot]
      dEff=[dEff,d.dEff]
      vvd=[vvd,d.vvd]
      vmd=[vmd,d.vmd]
      cdpconc=[cdpconc,d.cdpconc]
      cdpacc=[cdpacc,d.cdpacc]
      coleliq=[coleliq,d.coleliq]
      coletot=[coletot,d.coletot]
      cdpDBarB=[cdpDBarB,d.cdpDBarB]
      cipmodconc0=[cipmodconc0,d.cipmodconc0]
      cipmodconc1=[cipmodconc1,d.cipmodconc1]
      cipmodconc2=[cipmodconc2,d.cipmodconc2]
      lwc100=[lwc100,d.lwc100]
      lwcNev1=[lwcNev1,d.lwcNev1]
      lwcNev2=[lwcNev2,d.lwcNev2]
      expHeatLiq=[expHeatLiq,d.expHeatLiq]
      fsspConc=[fsspConc,d.fsspConc]
      fsspLwc=[fsspLwc,d.fsspLwc]
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
      
      
      cdpTransEst=[cdpTransEst,d.cdpTransEst]
      lwcNpc=[lwcNpc,d.lwcNpc]
      flightSec=[flightSec,d.flightSec]
      clearairLiq=[clearairLiq,d.clearairLiq]
      vlwccol=[vlwccol,d.vlwccol]
      ilwccol=[ilwccol,d.ilwccol]
      vlwcref=[vlwcref,d.vlwcref]
      ilwcref=[ilwcref,d.ilwcref]
      vtwccol=[vtwccol,d.vtwccol]
      itwccol=[itwccol,d.itwccol]
      vtwcref=[vtwcref,d.vtwcref]
      itwcref=[itwcref,d.itwcref]
      smoothSignalLiq=[smoothSignalLiq,d.smoothSignalLiq]
      aias=[aias,d.aias]
      iwc=[iwc,d.iwc]
      cdpTransRej=[cdpTransRej,d.cdpTransRej]
      cdpAdcOver=[cdpAdcOver,d.cdpAdcOver]
      pliqnpc=[pliqnpc,d.pliqnpc]
      lwcClearAirI=[lwcClearAirI,d.lwcClearAirI]
      alpha=[alpha,d.alpha]
      correctionLiq=[correctionLiq,d.correctionLiq]
      threshLiq=[threshLiq,d.threshLiq]
      twcClearAiri=[twcClearAiri,d.twcClearAiri]
      smLiq=[smLiq,d.smLiq]
      smLiqX=[smLiqX,d.smLiqX]
      avroll=[avroll,d.avroll]
      avpitch=[avpitch,d.avpitch]
      betaAng=[betaAng,d.betaAng]
      avyaw=[avyaw,d.avyaw]
      twodp=[twodp,d.twodp]
      lwcUB=[lwcUB,d.lwcUB]
      cdpLwcB=[cdpLwcB,d.cdpLwcB]
      
      
      r=r+n_elements(d.(1))
      inds.starti=inds.starti+n1(d.(1)) 
      startSec=startSec+n1(pmb)
    endfor
    
    cdpBinNB=make_array(28,n_elements(pmb))
    t=0
    for u=0,n_elements(cdpBinNB[0,*])-1 do begin
      if n_elements(where(finite(cdpBinN[*,u] gt 1))) gt 0 then begin
        cdpBinNB[*,t]=cdpBinN[*,u]
        t++
      endif
    endfor
    
    cdpBinN=cdpBinNB
    
    color=d.color
    

    save,filename='saves/'+savename,lwc,twc,cdpdbar,trf,colETot,pmb,cdplwc,clearairLiq,clearairTot,colELiq,aias,cdpAdcOver,threshliq,$
      cdpconc,cdpacc,cdpDBarB,dEff,vvd,vmd,ilwccol,vlwcref,twcClearAiri,$
      cipmodconc0,cipmodconc1,cipmodconc2,lwc100,color,ilwcref,alpha,smLiqX,$
      lwcNev2,expHeatLiq,fsspConc,lwcNev1,fsspLwc,pliqnpc,smLiq,$
      cdpTrans,cdpDofRej,tas,cdpBinSecSum,cdpBinN,cdpBinVar,smoothSignalLiq,$
      cdpBinSkew,cdpBinKert,cdpBinBimod,cdpBinMAD,cdpBinSD,cdpLwcB,$
      cdpTrans,cdpTransEst,lwcNpc,flightSec,vlwccol,iwc,cdpTransRej,lwcClearAirI,$
      itwccol,vtwccol,itwcref,vtwcref,avroll,avpitch,betaAng,avyaw,twodp,lwcUB
   
end