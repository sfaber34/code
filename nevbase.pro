;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;CALCULATES NEVZOROV LIQUID WATER CONTENT, TOTAL WATER CONTENT
;
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function nevbase, flightDay, airspeedType, level

common t,t

;AIRSPEED TYPE/LEVEL OVERRIDES
airspeedType='indicated'
level='400'
calcTrans=1


;---------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------FILEPATHS---------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------------------------------------

  if flightDay eq '0709' then nclPath='../data/20130709.c1.nc'
  if flightDay eq '0710' then nclPath='../data/20130710.c1.nc'
  if flightDay eq '0725' then nclPath='../data/20130725.c1.nc'
  if flightDay eq '0727' then nclPath='../data/20130727.c1.nc'
  if flightDay eq '0728' then nclPath='../data/20130728.c1.nc'
  if flightDay eq '0729' then nclPath='../data/20130729.c1.nc'
  if flightDay eq '0807' then nclPath='../data/20130807.c1.nc'
  if flightDay eq '0814' then nclPath='../data/20130814.c1.nc'
  if flightDay eq '0815' then nclPath='../data/20130815.c1.nc'
  if flightDay eq '0802' then nclPath='../data/20130802.c1.nc'
  if flightDay eq '0803' then nclPath='../data/20130803.c1.nc'
  if flightDay eq '0304' then nclPath='../data/20160304.c1.nc'
  if flightDay eq '0307' then nclPath='../data/20160307.c1.nc'
  if flightDay eq '1217' then nclPath='../data/20151217.c1.nc'
  if flightDay eq '1112' then nclPath='../data/20151112.c1.nc'
  if flightDay eq '1124' then nclPath='../data/20151124.c1.nc'
  if flightDay eq '0806' then nclPath='../data/20130806.c1.nc'  
  if flightDay eq '0813' then nclPath='../data/20130813.c1.nc'
  if flightDay eq '0817' then nclPath='../data/20130817.c1.nc'
  if flightDay eq '0722' then nclPath='../data/20130722.c1.nc'
  if flightDay eq '0718' then nclPath='../data/20130718.c1.nc'
  if flightDay eq '0120' then nclPath='../data/20160120.c1.nc'
  if flightDay eq '0125' then nclPath='../data/20160125.c1.nc'
  if flightDay eq '0817a' then nclPath='../data/20130817a.c1.nc'
  if flightDay eq '0817b' then nclPath='../data/20130817b.c1.nc'


if strmatch(nclpath,'*2013*') eq 1 then cope=1
if strmatch(nclpath,'*2015*') eq 1 then cope=0
if strmatch(nclpath,'*2016*') eq 1 then cope=2



;--------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------LOAD VARIABLES---------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------

;nRows=n_elements(loadvar('time',filename=nclPath))
;
;
;inputVars=['vlwcref','vlwccol','vtwcref','vtwccol','ilwcref','ilwccol','itwcref','itwccol','trf','tas','aias','TIME','time','pmb','trose','z',$
;  'pvmlwc','pvmre_c','lwc100','cdpconc_1_NRB','cdplwc_1_NRB','cdpacc_1_NRB','cdpdbar_1_NRB','avpitch','avroll','ACDP_1_NRB','CONCF_IBL','PLWCF_IBL',$
;  'hivs','CONC0_mod_cip_IBR','CONC1_mod_cip_IBR','CONC2_mod_cip_IBR','nevlwc1',$
;  'nevlwc2','nevtwc','beta','avyawr','alpha','HOUR','MINUTE','SECOND']
;
;NCDF_get, nclPath,inputVars,ncdfFile,found=found,missing=missing,/quiet
;
;for i=0,n_elements(missing)-1 do begin
;  nanFill=replicate(!VALUES.F_NAN,nRows)
;  
;  fu=execute('missing[i]=',make_array(1))
;  fu=execute('missing[i]=replicate(!VALUES.F_NAN,nRows)')
;  
;endfor


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

;reverse flow static temperature [C]
trf=loadvar('trf', filename=nclPath)

;true airspeed [m/s]
tas=loadvar('tas', filename=nclPath)

;indicated airspeed [knot]
aias=loadvar('aias', filename=nclPath)

;time formatted
timeForm=loadvar('TIME', filename=nclPath)

;time seconds since 2015-01-01 00:00:00 +0000
time=loadvar('time', filename=nclPath)

;pressure from rosemount sensor [mb]
pmb=loadvar('pmb', filename=nclPath)

;temperature from rosemount sensor [C]
trose=loadvar('trose', filename=nclPath)

;pressure derived altitude [m]
z=loadvar('z', filename=nclPath)

;liquid water content from Gerber probe [g/m^3]
pvmlwc=loadvar('pvmlwc', filename=nclPath)

;liquid water content from Gerber probe [g/m^3]
pvmDEff=loadvar('pvmre_c', filename=nclPath)

;liquid water content from lwc100 probe [g/m^3]
lwc100=loadvar('lwc100', filename=nclPath)

;CDP concentration
cdpconc_1_NRB=loadvar('cdpconc_1_NRB', filename=nclPath)

;liquid water content from CDP [g/m^3]
cdplwc_1_NRB=loadvar('cdplwc_1_NRB', filename=nclPath)

;CDP accepted particles
cdpacc=loadvar('cdpacc_1_NRB', filename=nclPath)

;CDP droplet mean diamter [um]
cdpdbar_1_NRB=loadvar('cdpdbar_1_NRB', filename=nclPath)

;Pitch [degrees]
avpitch=loadvar('avpitch', filename=nclPath)

;roll [degrees]
avroll=loadvar('avroll', filename=nclPath)

;CDP diameter per bin
cdpdbins=loadvar('ACDP_1_NRB', filename=nclPath)

;FSSP total concentration
fsspConc=loadvar('CONCF_IBL', filename=nclPath)

;FSSP LWC
fsspLwc=loadvar('PLWCF_IBL', filename=nclPath)

;Vertical Speed [m/s]
if cope eq 1 then hivs=loadvar('hivs', filename=nclPath)
if cope ne 1 then hivs=!VALUES.F_NAN

cipmod=1
if flightday eq '0814' eq 1 then cipmod=0

;CIP MOD0 CONC [/liter]
if cope eq 1 and cipmod eq 1 then begin
  cipmodconc0=loadvar('CONC0_mod_cip_IBR', filename=nclPath)
endif else begin
  cipmodconc0=replicate(!VALUES.F_NAN,n_elements(pmb))
endelse
print,'-----------', flightDay, '-----------'

;CIP MOD1 CONC [/liter]
if cope eq 1 and cipmod eq 1 then begin
  cipmodconc1=loadvar('CONC1_mod_cip_IBR', filename=nclPath)
endif else begin
  cipmodconc1=replicate(!VALUES.F_NAN,n_elements(pmb))
endelse

;CIP MOD2 CONC [/liter]
if cope eq 1 and cipmod eq 1 then begin
  cipmodconc2=loadvar('CONC2_mod_cip_IBR', filename=nclPath)
endif else begin
  cipmodconc2=replicate(!VALUES.F_NAN,n_elements(pmb))
endelse

;nevzorov sensor temperature [C]
nevTemp=double(loadvar('VLWCCOL_RAW', filename=nclPath, attr='temperature'))

;nevzorov sensor area [cm2]
if cope eq 1 then begin
  aLiq=.317
  aTot=.502
endif else begin
  aLiq=loadvar('VLWCCOL_RAW', filename=nclPath, attr='SampleArea')
  aTot=loadvar('VTWCCOL_RAW', filename=nclPath, attr='SampleArea')
endelse


noNev1=1

;liquid water content from Nevzorov probe [g/m^3]
if cope eq 1 and nonev1 eq 1 then begin
  lwcNev1=loadvar('nevlwc1', filename=nclPath)
endif else begin
  lwcNev1=replicate(!VALUES.F_NAN,n_elements(pmb))
endelse  

;liquid water content from Nevzorov probe [g/m^3]
if cope eq 1 and nonev1 eq 1 then begin
   lwcNev2=loadvar('nevlwc2', filename=nclPath)
endif else begin   
  lwcNev2=replicate(!VALUES.F_NAN,n_elements(pmb))
endelse

;Total water content from Nevzorov probe [g/m^3]
if cope eq 1 and nonev1 eq 1 then begin
  twcNev=loadvar('nevtwc', filename=nclPath)
endif else begin  
  twcNev=replicate(!VALUES.F_NAN,n_elements(pmb))
endelse

;Sideslip Angle [deg]
betaB=loadvar('beta', filename=nclPath)

;Yaw [deg]
avyawr=loadvar('avyawr', filename=nclPath)

;Attack Angle [rad]
alpha=loadvar('alpha', filename=nclPath)

;Flight Time [sec]
timeFlight=dindgen(n_elements(pmb),start=0,increment=1)
hour=loadvar('HOUR', filename=nclPath)
min=loadvar('MINUTE', filename=nclPath)
sec=loadvar('SECOND', filename=nclPath)

;CDP average transit times [us]
if cope eq 1 and calcTrans eq 1 then begin
  cdpTransB=cdpTransTime(flightDay)
  cdpTrans=cdpTransB[*,0]*25d-3
endif else begin
  cdpTrans=replicate(!VALUES.F_NAN,n_elements(pmb))
endelse

;CDP interarival times [us]
if cope eq 1 and calcTrans eq 1 then begin
  cdpDofRejB=cdpTransTime(flightDay)
  cdpDofRej=cdpDofRejB[*,1]
endif else begin
  cdpDofRej=replicate(!VALUES.F_NAN,n_elements(pmb))
endelse

;=loadvar('REJDOF_NRB', filename=nclPath) 



;--------------------SET TIMES FOR AXIS--------------------

hourst=string(hour)
hourstsp=strsplit(hourst,'.',/extract)
minst=string(min)
minstsp=strsplit(minst,'.',/extract)
secst=string(sec)
secstsp=strsplit(secst,'.',/extract)

hourstspb=SINDGEN(n_elements(hourst))
minstspb=SINDGEN(n_elements(hourst))
secstspb=SINDGEN(n_elements(hourst))

for i=0,n_elements(hourst)-1 do begin
  hourstspb[i]=hourstsp[i,0]
  minstspb[i]=minstsp[i,0]
  secstspb[i]=secstsp[i,0]
endfor
hourstspb=strtrim(hourstspb,1)
minstspb=strtrim(minstspb,1)
secstspb=strtrim(secstspb,1)

timePretty=hourstspb+':'+minstspb+':'+secstspb

t={hour:hour,min:min,sec:sec,timeForm:timeForm}

vsig=where(vlwccol gt 4.)
vsig=vsig[30:n_elements(vsig)-1]
aStart=min(vsig)+40
aEnd=max(vsig)-40


;--------------------SET FLIGHT STRINGS--------------------

if flightDay eq '0807' then flightString='08-07-13'
if flightDay eq '0806' then flightString='08-06-13'
if flightDay eq '0814' then flightString='08-14-13'
if flightDay eq '0710' then flightString='07-10-13'
if flightDay eq '0725' then flightString='07-25-13'
if flightDay eq '0727' then flightString='07-27-13'
if flightDay eq '0728' then flightString='07-28-13'
if flightDay eq '0729' then flightString='07-29-13'
if flightDay eq '0815' then flightString='08-15-13'
if flightDay eq '0803' then flightString='08-03-13'
if flightDay eq '0304' then flightString='03-04-16'
if flightDay eq '0307' then flightString='03-07-16'
if flightDay eq '1217' then flightString='12-17-15'
if flightDay eq '1124' then flightString='11-24-15'  
if flightDay eq '0821' then flightString='08-21-13'
if flightDay eq '0802' then flightString='08-02-13'
if flightDay eq '0722' then flightString='07-22-13'
if flightDay eq '0718' then flightString='07-18-13'
if flightDay eq '0813' then flightString='08-13-13'
if flightDay eq '0722' then flightString='07-21-13'
if flightDay eq '0718' then flightString='07-18-13'
if flightDay eq '0120' then flightString='01-20-15'
if flightDay eq '0125' then flightString='01-25-15'
if flightDay eq '0817a' then flightString='08-17-13'
if flightDay eq '0817b' then flightString='08-17-13'


;--------------------FILTER VARIABLES TO FLIGHT TIME BOUNDS--------------------

vlwcref=vlwcref[aStart:aEnd]
vlwccol=vlwccol[aStart:aEnd]
vtwcref=vtwcref[aStart:aEnd]
vtwccol=vtwccol[aStart:aEnd]
ilwcref=ilwcref[aStart:aEnd]
itwccol=itwccol[aStart:aEnd]
itwcref=itwcref[aStart:aEnd]
ilwccol=ilwccol[aStart:aEnd]
trf=trf[aStart:aEnd]
tas=tas[aStart:aEnd]
aias=aias[aStart:aEnd]
timeForm=timeForm[aStart:aEnd]
time=time[aStart:aEnd]
pmb=pmb[aStart:aEnd]
trose=trose[aStart:aEnd]
z=z[aStart:aEnd]
pvmlwc=pvmlwc[aStart:aEnd]
pvmDEff=pvmDEff[aStart:aEnd]
lwc100=lwc100[aStart:aEnd]
cdpconc_1_NRB=cdpconc_1_NRB[aStart:aEnd]
cdpacc=cdpacc[aStart:aEnd]
cdpdbar_1_NRB=cdpdbar_1_NRB[aStart:aEnd]
avpitch=avpitch[aStart:aEnd]
avroll=avroll[aStart:aEnd]
avyawr=avyawr[aStart:aEnd]
alpha=alpha[aStart:aEnd]
cdplwc_1_NRB=cdplwc_1_NRB[aStart:aEnd]
timeFlight=timeFlight[aStart:aEnd]
cdpdbins=cdpdbins[*,*,aStart:aEnd]
fsspConc=fsspConc[aStart:aEnd]
fsspLwc=fsspLwc[aStart:aEnd]
cdpTrans=cdpTrans[aStart:aEnd]
cdpDofRej=cdpDofRej[aStart:aEnd]

;SET COPE ONLY VARIABLES
if cope eq 1 then begin
  lwcNev1=lwcNev1[aStart:aEnd]
  lwcNev2=lwcNev2[aStart:aEnd]
  twcNev=twcNev[aStart:aEnd]
  hivs=hivs[aStart:aEnd]
  vtwcref=vlwcref 
  itwcref=ilwcref
endif

;CONVERT INDICATED AIRSPEED TO M/S
aiasMs=aias*.514444

if airspeedType eq 'true' then begin
  as=tas
endif

if airspeedType eq 'indicated' then begin
  as=aiasMs
endif

;SCALE CDP TRANSITS TO MEAN TAS
cdpTransScaled=cdpTrans*(tas/95.927322)

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------K AIRSPEED DEPENDANCE PARAMETERIZATION---------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if cope eq 1 then begin
  if (airspeedType eq 'indicated') and (level eq '900') then kLiq=(2.47292)*aiasms^(-0.273777)+(0.399143) ;900 indicated
  if (airspeedType eq 'indicated') and (level eq '600') then kLiq=(3.73599)*aiasms^(-0.0628865)+(-1.67763) ;600 indicated
  if (airspeedType eq 'indicated') and (level eq '400') then kLiq=(36.0089)*aiasms^(-1.26173)+(1.03362) ;400 indicated

  if (airspeedType eq 'indicated') and (level eq '900') then kTot=(10.8603)*aiasms^(-0.675924)+(0.167331) ;900 indicated
  if (airspeedType eq 'indicated') and (level eq '600') then kTot=(3.39234)*aiasms^(-0.182697)+(-0.737908) ;600 indicated
  if (airspeedType eq 'indicated') and (level eq '400') then kTot=(224.264)*aiasms^(-1.73025)+(0.725502) ;400 indicated
  
  if (airspeedType eq 'true') and (level eq '900') then kLiq=(8.56136)*tas^(-0.0292547)+(-6.37413) ;900 true
  if (airspeedType eq 'true') and (level eq '600') then kLiq=(3.91644)*tas^(-0.0685396)+(-1.70073) ;600 true
  if (airspeedType eq 'true') and (level eq '400') then kLiq=(1280.56)*tas^(-2.00624)+(1.08139) ;400 true  

  if (airspeedType eq 'true') and (level eq '900') then kTot=(35.0933)*tas^(-1.00354)+(0.318860) ;900 true
  if (airspeedType eq 'true') and (level eq '600') then kTot=(3.83487)*tas^(-0.238794)+(-0.496087) ;600 true
  if (airspeedType eq 'true') and (level eq '400') then kTot=(9874.83)*tas^(-2.45898)+(0.753854) ;400 true
endif



if cope eq 2 or cope eq 0 then begin
  if (airspeedType eq 'indicated') and (level eq '700') then kLiq=(-0.0126704)*tas^(0.698457)+(2.01460)
  if (airspeedType eq 'indicated') and (level eq '600') then kLiq=(-0.00956550)*tas^(0.753178)+(2.00092)
  if (airspeedType eq 'indicated') and (level eq '500') then kLiq=(-0.135222)*tas^(0.375551)+(2.43805)
  if (airspeedType eq 'indicated') and (level eq '400') then kLiq=(-0.0810470)*tas^(0.436789)+(2.28769)
  
  if (airspeedType eq 'indicated') and (level eq '700') then kTot=(-0.0258749)*aiasms^(0.711242)+(1.37937)
  if (airspeedType eq 'indicated') and (level eq '600') then kTot=(-0.104706)*aiasms^(0.468563)+(1.64276)
  if (airspeedType eq 'indicated') and (level eq '500') then kTot=(-0.0249307)*aiasms^(0.698422)+(1.39464)
  if (airspeedType eq 'indicated') and (level eq '400') then kTot=(-0.0700741)*aiasms^(0.512351)+(1.56121)
endif



;------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------CLEARAIR POINT DETECTION---------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------------------------------------------

correctionLiq=dindgen(n_elements(pmb),increment=0)
smoothSignalLiq=dindgen(n_elements(pmb),increment=0)

correctionTot=dindgen(n_elements(pmb),increment=0)
smoothSignalTot=dindgen(n_elements(pmb),increment=0)

rawSignalLiq=(vlwccol)
rawSignalTot=(vtwccol)

int=10
for i=0,n_elements(pmb)-(int+1) do begin
  correctionLiq[i:i+int]=min(rawSignalLiq[i:i+int])
  i=i+int
endfor


for i=0,n_elements(pmb)-(int+1) do begin
  smoothSignalLiq[i:i+int]=rawSignalLiq[i:i+int]-correctionLiq[i:i+int]
  i=i+int
endfor

intb=20
for i=0,n_elements(pmb)-(intb+1) do begin
  correctionTot[i:i+intb]=min(rawSignalTot[i:i+intb])
  i=i+int
endfor

for i=0,n_elements(pmb)-(intb+1) do begin
  smoothSignalTot[i:i+intb]=rawSignalTot[i:i+intb]-correctionTot[i:i+intb]
  i=i+int
endfor

diffLiq=smoothSignalLiq
uLiq2=sort(rawSignalLiq)
uLiq3=reverse(uLiq2)
uLiq=diffLiq[uLiq3]
u1Liq=uLiq[0]
u2Liq=uLiq[50]

x1Liq=min([u1Liq,u2Liq])
x2Liq=max([u1Liq,u2Liq])
if cope eq 0 or cope eq 2 then threshLiq=.007*mean(rawSignalLiq[0:50])
if cope eq 1 then threshLiq=.007*mean(rawSignalLiq[0:50])

diffTot=smoothSignalTot
threshtot=0.
uTot2=sort(diffTot)
uTot3=reverse(uTot2)
uTot=diffTot[uTot3]
u1Tot=uTot[0]
u2Tot=uTot[50]

x1Tot=min([u1Tot,u2Tot])
x2Tot=max([u1Tot,u2Tot])
if cope eq 0 or cope eq 2 then threshTot=.085*mean(uTot[0:50])
if (cope eq 0 or cope eq 2) and threshTot lt .003 then threshTot=.004

if cope eq 1 then threshTot=0.0025*mean(uTot[0:50])


clearairLiqi=findgen(n_elements(pmb),start=0.,increment=0.)
clearairToti=findgen(n_elements(pmb),start=0.,increment=0.)
    
for i=0,n_elements(pmb)-1 do begin
  if abs(diffLiq[i]) le threshLiq and shift(abs(diffLiq[i]),1) le threshLiq and $
    shift(abs(diffLiq[i]),-1) le threshLiq and shift(abs(diffLiq[i]),2) le threshLiq and $
    shift(abs(diffLiq[i]),-2) le threshLiq then clearairLiqi[i]=1

  
  if abs(diffTot[i]) le threshTot and abs(shift(diffTot[i],1)) le threshTot and $
     abs(shift(diffTot[i],-1)) le threshTot and abs(shift(diffTot[i],2)) le threshTot and $
     abs(shift(diffTot[i],-2)) le threshTot then clearairToti[i]=1
endfor    
    
clearairLiq=where(clearairLiqi eq 1)
clearairTot=where(clearairToti eq 1)

signalLiq=where(clearairLiqi eq 0)
signalTot=where(clearairToti eq 0)


clearairTotsort=sort(vtwccol[clearairTot])
clearairTotsortsorted=clearairTot[clearairTotsort]
clearairTotsortsorted=clearairTotsortsorted[n_elements(clearairTotsortsorted)*.01:n_elements(clearairTotsortsorted)*.99]



;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------MISC. POINT DETECTION---------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------------------------------------------------

aSpan = n_elements(pmb) - 1
BetaI=dindgen(n_elements(pmb),start=0,increment=0)
baselineIB=dindgen(n_elements(pmb),start=0,increment=0)
baselineRollI=dindgen(n_elements(pmb),start=0,increment=0)
baselineYawI=dindgen(n_elements(pmb),start=0,increment=0)
baselinePitchI=dindgen(n_elements(pmb),start=0,increment=0)
baselineI=dindgen(n_elements(pmb),start=0,increment=0)

for i=0, aSpan do begin
  if (abs(avRoll[i]) lt 5) then begin
    baselineRollI[i]=1
  endif
  if (avpitch[i] lt (mean(avpitch) + 2) and avpitch[i] gt (mean(avpitch) - 2)) then begin ;0871013
    baselinePitchI[i]=1
  endif
  if (betaB[i] lt -.014 and betaB[i] gt -.026) then begin
    BetaI[i]=1
  endif
  if (abs(avyawr[i]) lt .003) then begin
    baselineYawI[i]=1
  endif
  if (baselineI[i] eq 1) and (baselineRollI[i] eq 1) and (baselinePitchI[i] eq 1) and (baselineYawI[i]=1) then begin
    baselineIB[i]=1
  endif
endfor

levelclearairLiq=where(baselineIB eq 1)



;-------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------MOMENT CALCULATIONS---------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------

dEff=make_array(n_elements(pmb))
vvd=make_array(n_elements(pmb))
vmd=make_array(n_elements(pmb))
diff=make_array(n_elements(pmb))
if n_elements(cdpdbins[*,0,0]) eq 28 then diam=[1.5,2.5,3.5,4.5,5.5,6.5,7.5,9.,11.,13.,15.,17.,19.,21.,23.,25.,27.,29.,31.,33.,35.,37.,39.,41.,43.,45.,47.,49.]
if n_elements(cdpdbins[*,0,0]) eq 27 then diam=[1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,10.5,14.,17.,19.,21.,23.,25.,27.,29.,31.,33.,35.,37.,39.,41.,43.,45.,47.,49.]


dEff=[]
vmd=[]
vvd=[]
dBarB=[]
cdpBinVar=[]
cdpBinSkew=[]
cdpBinKert=[]
cdpBinBimod=[]
cdpBinMAD=[]
cdpBinSD=[]
s=0
for m=0, n_elements(pmb)-1 do begin
  xa=[]
  xb=[]
  xc=[]
  xe=[]
  meanDiff=[]
  for j=0,n_elements(cdpdbins[*,0,0])-1 do begin
    xe=[xe,(diam[j])*(cdpdbins[j,0,m])]
    xa=[xa,(diam[j])^2.*(cdpdbins[j,0,m])]
    xb=[xb,(diam[j])^3.*(cdpdbins[j,0,m])]
    xc=[xc,(diam[j])^4.*(cdpdbins[j,0,m])]
  endfor  
  dEff=[dEff,total(xb)/total(xa)]
  dBarB=[dBarB,total(xe)/total(cdpdbins[*,0,m])]
  vvd=[vvd,(total(xb)/total(cdpdbins[*,0,m]))^(1./3.)]
  vmd=[vmd,total(xc)/total(xb)]

  gtZInd=where(cdpdbins[*,0,m] gt 0)
  binRedist=[]
  for y=0,n_elements(gtZInd)-1 do begin
    if min(gtZInd) gt 0d then begin
      binRedist=[binRedist,replicate(diam[gtZInd[y]],cdpdbins[gtZInd[y],0,m])]
    endif else begin
      binRedist=!values.d_nan
    endelse
    
  endfor
  
  diffs=binRedist-dBarB[m]
  
  varianceB=total((diffs)^2d)/(n_elements(binRedist)-1d)
  meanAbsDeviation=total(abs(diffs))/(n_elements(binRedist))
  skewnessB=total((diffs/sqrt(varianceB))^3d)/(n_elements(binRedist))
  kurtosisB=total((diffs/sqrt(varianceB))^4d)/(n_elements(binRedist))-3d
  cdpBinVar=[cdpBinVar,varianceB]
  cdpBinSD=[cdpBinSD,sqrt(varianceB)]
  cdpBinSkew=[cdpBinSkew,skewnessB]
  cdpBinKert=[cdpBinKert,kurtosisB]
  cdpBinBimod=[cdpBinBimod,((skewnessB)^(2d)+1d)/kurtosisB]
  cdpBinMAD=[cdpBinMAD,meanAbsDeviation]  
endfor





;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------COLLECTION EFFECIENCY PARAMETERIZATION---------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;--------------------LIQUID COLLECTION EFFECIENCY--------------------
colEliq=dindgen(n_elements(pmb),start=1,increment=0)
for d=0,n_elements(pmb)-1 do begin
  if vmd[d] ge 0.884495 and vmd[d] lt 4.78668056 then begin
    colEliq[d]=0.76534878613892943-1.9525313756894320*vmd[d]+2.3079791209893301*vmd[d]^2.-1.1748496234649792*vmd[d]^3.+0.31405602625454776*vmd[d]^4.-0.042947818677930627*vmd[d]^5.+0.0023657753736188170*vmd[d]^6.
  endif
  if vmd[d] ge 4.78668056 and vmd[d] lt 17.0 then begin
    colEliq[d]=0.053872488439083099+0.38012190535664558*vmd[d]-0.073273373767733574*vmd[d]^2.+0.0082262509968131781*vmd[d]^3.-0.00056395785577478819*vmd[d]^4.+2.3254772713698912e-05*vmd[d]^5.-5.2972488973068721e-07*vmd[d]^6.+5.1198482675651746e-09*vmd[d]^7.
  endif
  if vmd[d] ge 17.0 and vmd[d] lt 25. then begin
    colEliq[d]=0.91221589+0.0087850597*vmd[d]-0.00025973702*vmd[d]^2.
  endif
  if vmd[d] ge 25. then begin
    x1=((vmd[d]-20.)/90)^2.
    x2=2.^(1./.26)-1.
    colEliq[d]=.98/(1.+x1*x2)^.26
  endif
endfor


colEliq3=dindgen(n_elements(pmb),start=1,increment=0)
for d=0,n_elements(pmb)-1 do begin
  if vmd[d] le 15 then colEliq3[d]=(-0.236989)+0.503008*vmd[d]-0.0878596*$
    vmd[d]^2.+0.00801374*vmd[d]^3.-0.000397548*vmd[d]^4.+1.01460e-05*vmd[d]^5.-1.04243e-07*vmd[d]^6.
  if vmd[d] gt 13 and vmd[d] le 25 then colEliq3[d]=.9697
  if vmd[d] gt 25 then begin
    x1=((vmd[d]-20.)/90)^2.
    x2=2.^(1./.26)-1.
    colEliq3[d]=.98/(1.+x1*x2)^.26
  endif
endfor

;--------------------TOTAL COLLECTION EFFECIENCY--------------------
colETot=dindgen(n_elements(pmb),start=1,increment=0)
for c=0,n_elements(pmb)-1 do begin
  if vmd[c] le 10.41 then begin
    colETot[c]=0.0089810744193528080-0.0095860685032675974*vmd[c]+0.018453599910571938*vmd[c]^2.-0.00080000274192570942*vmd[c]^3.-0.00019379821253551199*vmd[c]^4.+2.3409862748735577e-05*vmd[c]^5.-7.7800221198742747e-07*vmd[c]^6.
  endif
  if vmd[c] gt 10.41 and vmd[c] le 26.014 then begin
    colETot[c]=-0.31618167337728664+0.14578708937187912*vmd[c]-0.0070996433610162057*vmd[c]^2.+0.00016759853006931280*vmd[c]^3.-1.5651587643716880e-06*vmd[c]^4.
  endif
  if vmd[c] gt 26.014 and vmd[c] le 100.000 then begin
    colETot[c]=0.37017905572429299+0.045383498189039528*vmd[c]-0.0014994405482866568*vmd[c]^2.+2.7550006166165986e-05*vmd[c]^3.-2.8942966512346402e-07*vmd[c]^4.+1.6276378647650525e-09*vmd[c]^5.-3.8021012390993675e-12*vmd[c]^6.
  endif
  if vmd[c] gt 100.000 and vmd[c] le 150. then begin
    colETot[c]=0.76903533935546875+0.0065395329147577286*vmd[c]-7.0993726694723591e-05*vmd[c]^2.+3.4560855510790134e-07*vmd[c]^3.-6.3046545761835660e-10*vmd[c]^4.
  endif
  if vmd[c] gt 150. then begin
    colETot[c]=1.
  endif
endfor

colETot2=dindgen(n_elements(pmb),start=1,increment=0)
for r=0,n_elements(pmb)-1 do begin
  if vmd[r] le 10.05 then colETot2[r]=(-0.0187892454)+0.2023209*vmd[r]-0.01937650*$
    vmd[r]^2.+0.00090900815025*vmd[r]^3.-2.0036900614417430e-05*vmd[r]^4.+1.6638675680649695e-07*vmd[r]^5.
  if vmd[r] gt 10.05 and vmd[r] le 33 then colETot2[r]=0.43729845*vmd[r]^(0.19240421)+0.11114933
  if vmd[r] gt 33 then colETot2[r]=0.0010409079*vmd[r]+0.93375003
endfor

colETot3=dindgen(n_elements(pmb),start=1,increment=0)
for c=0,n_elements(pmb)-1 do begin
  if vmd[c] le 50. then begin
    colETot3[c]=-0.0576565+0.0324626*vmd[c]+0.0105399*vmd[c]^2.-0.00118195*vmd[c]^3.+5.50338e-05*vmd[c]^4.$
      -1.32812e-06*vmd[c]^5.+1.63224e-08*vmd[c]^6.-8.08554e-11*vmd[c]^7.
  endif    
  if vmd[c] gt 50. and vmd[c] le 150. then begin
     colETot3[c]=0.907000+0.00164001*vmd[c]-9.20008e-06*vmd[c]^2.+1.60003e-08*vmd[c]^3.  
  endif
  if vmd[c] gt 150. then colETot3[c]=1.
endfor




;------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------LWC/TWC/IWC CALCULATIONS---------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------------------------------------------

;--------------------CONSTANTS--------------------
;sensor surface area conversion [cm^2] -> [m^2]
aLiq=aLiq*1d-4
aTot=aTot*1d-4

;EXPENDED HEAT

;latent heat of vaporization, liquid water at nev sensor temperature [J/Kg]
lw=2.5008d6-(4218.0d - 1870.4d)*(nevTemp)


expHeatLiq=(nevTemp-trf)*4.218+lw*1d-3
expHeatIce=expHeatLiq


;--------------------POWER CALCULATIONS--------------------
pLiq=vlwccol*ilwccol-kLiq*vlwcref*ilwcref
pLiqNoPresCor=pLiq
lwcNoPresCor=pLiq/(colELiq*tas*aLiq*2589.)

pTot=vtwccol*itwccol-kTot*vtwcref*itwcref
pTotNoPresCor=pTot
twcNoPresCor=pTot/(colETot*tas*aTot*2589.)



;--------------------POWER PRESSURE CORRECTION--------------------

linPresCorLiq=linfit(pmb[clearairLiq],pLiqNoPresCor[clearairLiq])
pLiq=pLiqNoPresCor - ( linPresCorLiq[1]*pmb + linPresCorLiq[0] )

linPresCorTot=linfit(pmb[clearairTot],pTotNoPresCor[clearairTot])
pTot=pTotNoPresCor - ( linPresCorTot[1]*pmb + linPresCorTot[0] )


;--------------------FINAL CALCULATIONS--------------------

;LWC
lwc=pLiq/(1.*tas*aLiq*2589.)
lwcVarH=pLiq/(1.*tas*aLiq*expHeatLiq)
lwcVarE=pLiq/(colELiq*tas*aLiq*2589.)

;TWC
twc=pTot/(1.*tas*aTot*2589.)
twcVarH=pTot/(1.*tas*aTot*expHeatIce)
twcVarE=pTot/(colETot*tas*aTot*2589.)



lwcErrColE=lwcVarE-lwc
twcErrColE=twcVarE-twc

iwc=twc-lwc


;--------------------UNCERTAINTY--------------------

colELiqUP=1.-colEliq
colELiqU=abs(lwc)*colELiqUP


;--------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------PASS VARIABLES---------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------

color=['black','firebrick','navy','dark green','magenta','coral','indian red','dodger blue','orange','olive drab','medium violet red']

d={as:as, pmb:pmb, time:time, timeForm:timeForm, avroll:avroll, avpitch:avpitch, $
  pLiq:pLiq, lwcVarE:lwcVarE, lwcNev1:lwcNev1, twcNev:twcNev, lwcNoPresCor:lwcNoPresCor, twcVarE:twcVarE,$
  clearairLiq:clearairLiq, levelclearairLiq:levelclearairLiq,timeFlight:timeFlight,$
  flightString:flightString, kLiq:kLiq,threshLiq:threshLiq, clearairTot:clearairTot,$
  aiasMs:aiasMs, tas:tas,vlwcref:vlwcref, ilwcref:ilwcref, twcNoPresCor:twcNoPresCor,$
  vlwccol:vlwccol, ilwccol:ilwccol, cdpconc:cdpconc_1_NRB, trf:trf, threshTot:threshTot,$
  lwc100:lwc100, cdpdbar:cdpdbar_1_NRB,lwcnev2:lwcnev2, timePretty:timePretty,cdpDofRej:cdpDofRej,$
  avyaw:avyawr,pvmlwc:pvmlwc,cdplwc:cdplwc_1_NRB,pLiqNoPresCor:pLiqNoPresCor,$
  rawSignalLiq:rawSignalLiq, smoothSignalLiq:smoothSignalLiq, cdpacc:cdpacc,$
  rawSignalTot:rawSignalTot, smoothSignalTot:smoothSignalTot, pTot:pTot,pTotNoPresCor:pTotNoPresCor,$
  vtwccol:vtwccol,itwccol:itwccol,vtwcref:vtwcref,itwcref:itwcref,aTot:aTot,expHeatIce:expHeatIce,$
  signalTot:signalTot,signalLiq:signalLiq,cdpdbins:cdpdbins,lwc:lwc,expHeatLiq:expHeatLiq,$
  dEff:dEff,vvd:vvd,vmd:vmd,coleliq:coleliq,lwcVarH:lwcVarH,twcVarH:twcVarH,$
  twc:twc,colETot:colETot,dBarB:dBarB,colEtot2:colEtot2,coletot3:coletot3,$
  cipmodconc0:cipmodconc0,cipmodconc1:cipmodconc1,fsspConc:fsspConc,cdpTrans:cdpTrans,$
  cipmodconc2:cipmodconc2,color:color,lwcErrColE:lwcErrColE,fsspLwc:fsspLwc,$
  pvmDEff:pvmDEff,cdpBinVar:cdpBinVar,cdpBinSkew:cdpBinSkew,cdpBinKert:cdpBinKert,$
  cdpBinBimod:cdpBinBimod,cdpBinMAD:cdpBinMAD,cdpBinSD:cdpBinSD,colELiqU:colELiqU,$
  colELiqUP:colELiqUP,cdpTransScaled:cdpTransScaled}

return,d

end








;---------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------MISC. FUNCTIONS---------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------------------------------------------

function convertTime,hh,mm,ss
  common t,t
  timeindex=where(t.hour eq hh and t.min eq mm and t.sec eq ss)
  return,timeindex
end



pro info
  print,''
  print,''
  print,'-------------COPE-----------------'
  print,'LEVELS COPE = 400, 600, 900'
  print,'DAYS COPE = 0710, 0725, 0727, 0728, 0729, 0803, 0807, 0814, 0815, ||0709||'
  print,''
  print,''
  print,'-----------LARAMIE----------------'
  print,'LEVELS LARAMIE = 400, 500, 600, 700'
  print,'DAYS LARAMIE = 0307, ||0304||'
  print,''
  print,'-------------COMMANDS-----------------'
  print,'SUPERSCRIPT = !U *** !N'
  print,''
  print,''
  print,'fu = min((VAR[*] - 450), i, /absolute)'
  print,''
  print,''
  print,'endif else begin'
  print,'.............'
  print,'endelse'
  print,''
  print,''
  print,',margin=[110,70,30,20],/device'
end

function loadvar,varname,ncid=ncid,filename=filename,cal=cal, double_prec=double_prec, $
  scale = scale, offset = offset, coef = coef, adcoef=adcoef, span=span, attr = attr, help=help

  ;+
  ;
  ;
  ;  $Id: loadvar.pro,v 1.1.1.1 2005/05/03 17:48:13 french Exp $
  ;  MODIFIED 2015/03/26:  added ability to read and return variable attributes 'Span' and 'AdditionalCoefficients'
  ;
  ;
  ; A generic function to load a variable from a netCDF file,
  ;
  ; The function will also look for standard variable attributes (scale_factor &
  ;   add_offset) and non-standard attributes (cal_coef) and apply them if
  ; they exist.
  ;
  ; Added in 2015, if user provides a string for the keyword 'attr', then function
  ;   will search if that variable attrib exists, and if it does return the value of
  ;   that attribute rather than the value of the variable. If the attrib does not exist
  ;   it returns -1
  ;
  ; The function is written to be backwards compatible with old version of
  ; of ARL aircraft data which contain calibration coefficients written
  ; with 'cal_pwr' and 'coefn' where n is 0 or 1
  ;
  ; The function returns the values for varname
  ;
  ; One can either pass the NAME of a CLOSED netCDF file through the 'filename'
  ; keyword, or the netCDF FILE ID of an OPEN netCDF file through the 'ncid'
  ; keyword. If using 'filename', the file will be closed by loadvar.
  ; If using 'ncid', the file will remain open.
  ;
  ;
  if KEYWORD_SET(help) then begin
    print,''
    print,'Result = loadvar(varname, [ncid=ncid | filename=filename])'
    print,''
    print,'ARGUMENTS'
    print,'varname  : name of netCDF variable'
    print,'ncid   : netCDF file ID of OPEN netCDF file'
    print,'filename : name (& path) of CLOSED netCDF file'
    print,' NOTE: call requires either ncid or filename KEYWORD'
    print,''
    print,'KEYWORDS'
    print,'attr    : set this keyword to the name of a variable attribute'
    print,'   if set and the attribute exists function returns value of attribute'
    print,'   if set and the attribute doesnot exist function returns -1'
    print,' '
    print,'cal    : set this keyword to apply calibration coefficients'
    print,'   if they exist (ignored if they do not exist)'
    print,'double_prec: if set, result is returned as double precision'
    print,'   otherwise returned as float'
    print,'scale    : name of variable that will contain, upon exit, value'
    print,'   of scale factor'
    print,'offset   : name of variable that will contain, upon exit, value'
    print,'   of add_offset'
    print,'coef   : name of variable that will contain, upon exit, value(s)'
    print,'   of calibration coefficient(s)'
    RETURN, -1
  endif
  ;-

  IF NOT isa(ncid) THEN $
    close_file = 1

  IF KEYWORD_SET(filename) THEN $
    ncid = NCDF_OPEN(filename)


  IF NOT isa(ncid) THEN BEGIN
    PRINT, "loadvar: no filename or valid file ID given"
    RETURN,-1
  ENDIF

  IF (KEYWORD_SET(double_prec)) THEN dbl = 1 ELSE dbl = 0

  varid = NCDF_VARID(ncid, varname)


  vardata = NCDF_VARINQ(ncid, varid)


  scale = 1. & offset = 0.
  FOR i = 1, vardata.natts DO BEGIN
    attname = NCDF_ATTNAME(ncid, varid, i-1)
    ; print,attname
    IF (attname eq 'add_offset') THEN BEGIN
      NCDF_ATTGET, ncid, varid, 'add_offset', offset
      IF (dbl) THEN offset = double(offset)
    ENDIF
    IF (attname eq 'scale_factor') THEN BEGIN
      NCDF_ATTGET, ncid, varid, 'scale_factor', scale
      IF (dbl) THEN scale = double(scale)
    ENDIF
    IF ( (KEYWORD_SET(cal)) AND (attname EQ 'cal_coef') ) THEN BEGIN
      NCDF_ATTGET, ncid, varid, 'cal_coef', cal_coef
      IF (dbl) THEN cal_coef = double(cal_coef)
    ENDIF

    ;the following is for special attributes contained in some netcdf variables in UWKA files

    IF (  (attname EQ 'AdditionalCoefficients') ) THEN $
      NCDF_ATTGET, ncid, varid, 'AdditionalCoefficients', adcoef
    IF (  (attname EQ 'Span') ) THEN $
      NCDF_ATTGET, ncid, varid, 'Span', span

    ; the following is to be back compatible with old ncr files
    IF ( (KEYWORD_SET(cal)) AND (attname EQ 'cal_pwr') ) THEN $
      NCDF_ATTGET, ncid, varid, 'cal_pwr', cal_pwr
    IF ( (KEYWORD_SET(cal)) AND (attname EQ 'coef_0') ) THEN BEGIN
      NCDF_ATTGET, ncid, varid, 'coef_0', coef_0
      IF (dbl) THEN coef_0 = double(coef_0)
    ENDIF
    IF ( (KEYWORD_SET(cal)) AND (attname EQ 'coef_1') ) THEN BEGIN
      NCDF_ATTGET, ncid, varid, 'coef_1', coef_1
      IF (dbl) THEN coef_1 = double(coef_1)
    ENDIF

  ENDFOR


  ;check to see if keyword 'attr' is present -- if it is, get the attribute and return it
  ;if the keyword is not present, then continue getting the variable data and return that

  IF isa(attr) THEN BEGIN
    NCDF_ATTGET, ncid, varid, attr, temp
    RETURN, temp
  ENDIF ELSE BEGIN
    NCDF_VARGET, ncid, varid, temp_u
  ENDELSE

  temp = temp_u*scale + offset

  ; the following is to be back compatible with old ncr files
  IF isa(cal_pwr) THEN BEGIN
    cal_coef = FLTARR(2)
    cal_coef[0] = coef_0
    cal_coef[1] = coef_1
  ENDIF

  engin = 0
  IF ( KEYWORD_SET(cal) AND (N_ELEMENTS(cal_coef) gt 0) ) THEN BEGIN
    coef = cal_coef
    FOR i = 0, N_ELEMENTS(cal_coef)-1 DO $
      engin = cal_coef[i]*(temp^i)+engin
    temp = engin
  ENDIF

  IF isa(close_file) THEN $
    NCDF_CLOSE, ncid

  RETURN, temp

end




