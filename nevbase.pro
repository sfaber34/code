;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;CALCULATES NEVZOROV LIQUID WATER CONTENT, TOTAL WATER CONTENT
;
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function nevbase, flightDay, level

common t,t
common inds,inds

if inds.starti eq 0 then startsec=0
if inds.starti gt 0 then startsec=inds.starti

;-------MISC OPTIONS------
calcTrans=0 ;calculate cdp vars from raw files
cipmod=0 ;include Jason's cip calculations
noNev1=0 ; incude Korolev's second set of Nev calculations
useLarK=0
useDen=0
useFixedK=0

;---------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------FILEPATHS---------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------------------------------------
  cope=99
  
  ;COPE
  if flightDay eq '0709' then nclPath='../data/20130709.c25.nc'
  if flightDay eq '0710' then nclPath='../data/20130710.c25.nc'
  if flightDay eq '0725' then nclPath='../data/20130725.c25.nc'
  if flightDay eq '0727' then nclPath='../data/20130727.c25.nc'
  if flightDay eq '0728' then nclPath='../data/20130728.c25.nc'
  if flightDay eq '0729' then nclPath='../data/20130729.c25.nc'
  if flightDay eq '0807' then nclPath='../data/20130807.c25.nc'
  if flightDay eq '0814' then nclPath='../data/20130814.c25.nc'
  if flightDay eq '0815' then nclPath='../data/20130815.c25.nc'
  if flightDay eq '0802' then nclPath='../data/20130802.c25.nc'
  if flightDay eq '0803' then nclPath='../data/20130803.c25.nc'
  if flightDay eq '0806' then nclPath='../data/20130806.c25.nc'  
  if flightDay eq '0813' then nclPath='../data/20130813.c25.nc'
  if flightDay eq '0817' then nclPath='../data/20130817.c25.nc'
  if flightDay eq '0722' then nclPath='../data/20130722.c25.nc'
  if flightDay eq '0718' then nclPath='../data/20130718.c25.nc'
  if flightDay eq '0817a' then nclPath='../data/20130817a.c25.nc'
  if flightDay eq '0817b' then nclPath='../data/20130817b.c25.nc'
  
  ;LARAMIE
  if flightDay eq '1124' then nclPath='../data/20151124.c25.nc'
  if flightDay eq '1217' then nclPath='../data/20151217.c25.nc'
  if flightDay eq '1112' then nclPath='../data/20151112.c25.nc'
  if flightDay eq '0120' then nclPath='../data/20160120.c25.nc'
  if flightDay eq '0125' then nclPath='../data/20160125.c25.nc'
  if flightDay eq '0304' then nclPath='../data/20160304.c25.nc'
  if flightDay eq '0307' then nclPath='../data/20160307.c25.nc'
  
  ;PACMICE
  if flightDay eq '081816' then nclPath='../data/20160818.c25.nc' ;Cal flight
  if flightDay eq '082516' then nclPath='../data/20160825.c25.nc'
  if flightDay eq '082616' then nclPath='../data/20160826.c25.nc'
  if flightDay eq '090416' then nclPath='../data/20160904.c25.nc'
  if flightDay eq '090916' then nclPath='../data/20160909.c25.nc'
  if flightDay eq '091016' then nclPath='../data/20160910.c25.nc'  
  if flightDay eq '091316' then nclPath='../data/20160913.c25.nc'
  if flightDay eq '091616' then nclPath='../data/20160916.c25.nc'
  if flightDay eq '092316' then nclPath='../data/20160923.c25.nc'

  ;----DETECT CAMPAIGN-----
  if strmatch(nclpath,'*2013*') eq 1 then cope=1
  if strmatch(nclpath,'*2015*') eq 1 then cope=0
  if strmatch(nclpath,'*2016*') eq 1 then cope=2


;--------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------LOAD VARIABLES---------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------


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


;------------LWC COL/REF SIGNALS ARE BACKWARDS FOR A FEW LAR FLIGHTS---------------------

;      if mean(vlwccol) lt mean(vlwcref) then begin
;        vlwccolB=vlwccol
;        vlwcrefB=vlwcref
;        vlwccol=vlwcrefB
;        vlwcref=vlwccolB
;      endif
;      
;      if mean(ilwccol) lt mean(ilwcref) then begin
;        ilwccolB=ilwccol
;        ilwcrefB=ilwcref
;        ilwccol=ilwcrefB
;        ilwcref=ilwccolB
;      endif
;      
;      if mean(vtwccol) gt mean(vtwcref) then begin
;        vtwccolB=vtwccol
;        vtwcrefB=vtwcref
;        vtwccol=vtwcrefB
;        vtwcref=vtwccolB
;      endif
;      
;      if mean(itwcref) gt mean(itwccol) then begin
;        itwccolB=itwccol
;        itwcrefB=itwcref
;        itwccol=itwcrefB
;        itwcref=itwccolB
;      endif


if flightday eq '0304' or flightday eq '0307' then begin
  vlwccolB=vlwccol
  vlwcrefB=vlwcref
  vlwccol=vlwcrefB
  vlwcref=vlwccolB

  ilwccolB=ilwccol
  ilwcrefB=ilwcref
  ilwccol=ilwcrefB
  ilwcref=ilwccolB
  
  vtwccolB=vtwccol
  vtwcrefB=vtwcref
  vtwccol=vtwcrefB
  vtwcref=vtwccolB
  
  itwccolB=itwccol
  itwcrefB=itwcref
  itwccol=itwcrefB
  itwcref=itwccolB
endif


;------------------------------------------------------------------------


;reverse flow static temperature [C]
trf=loadvar('trf', filename=nclPath)

;true airspeed [m/s]
tas=loadvar('tas', filename=nclPath)

;indicated airspeed [knot]
aias=loadvar('aias', filename=nclPath)

;time seconds since 2015-01-01 00:00:00 +0000
time=loadvar('time', filename=nclPath)

;pressure from rosemount sensor [mb]
pmb=loadvar('ps_hads_a', filename=nclPath)
nPoints1Pre=n1(pmb)/5. ;get number of points from pmb

;temperature from rosemount sensor [C]
trose=loadvar('trose', filename=nclPath)

;pressure derived altitude [m]
z=loadvar('z', filename=nclPath)

;liquid water content from lwc100 probe [g/m^3]
lwc100=loadvar('lwc100', filename=nclPath)

;CDP concentration [cm-3]
cdpconc_1_NRB=loadvar('cdpconc_1_NRB', filename=nclPath)

;liquid water content from CDP [g/m^3]
cdplwc_1_NRB=loadvar('cdplwc_1_NRB', filename=nclPath)

;CDP accepted particles
cdpacc=loadvar('cdpacc_1_NRB', filename=nclPath)

;CDP droplet mean diamter [um]
cdpdbar_1_NRB=loadvar('cdpdbar_1_NRB', filename=nclPath)

;CDP diameter per bin
cdpdbins=loadvar('ACDP_1_NRB', filename=nclPath)

;CDP diameter per bin
cdpdbinsTest=loadvar('ACDP_1_NRB', filename=nclPath)

;Pitch [degrees]
avpitch=loadvar('avpitch', filename=nclPath)

;roll [degrees]
avroll=loadvar('avroll', filename=nclPath)

;2DP concentration [liter-1]

if flightDay eq '091016' or flightDay eq '091316' or flightDay eq '0304' or flightDay eq '1124' or flightDay eq '1217' or flightDay eq '0120' or flightDay eq '0125' or flightDay eq '0307' then begin
  twodp=dindgen(n1(pmb))*!values.d_nan
endif else begin
  twodp=loadvar('twodp', filename=nclPath)
endelse

if cope eq 1 then begin
  ;FSSP total concentration
  fsspConc=loadvar('CONCF_IBL', filename=nclPath)

  ;FSSP LWC
  fsspLwc=loadvar('PLWCF_IBL', filename=nclPath)
endif else begin
  fsspConc=replicate(!values.d_nan,n1(vlwcref))
  fsspLwc=replicate(!values.d_nan,n1(vlwcref))
endelse


;Vertical Speed [m/s]
if cope eq 1 then hivs=loadvar('hivs', filename=nclPath)
if cope ne 1 then hivs=!VALUES.F_NAN


if flightday eq '0814' eq 1 then cipmod=0


;CIP MOD0 CONC [/liter]
if cope eq 1 and cipmod eq 1 then begin
  cipmodconc0=loadvar('CONC0_mod_cip_IBR', filename=nclPath)
endif else begin
  cipmodconc0=replicate(!VALUES.F_NAN,nPoints1Pre)
endelse
print,'-----------', flightDay, '-----------'

;CIP MOD1 CONC [/liter]
if cope eq 1 and cipmod eq 1 then begin
  cipmodconc1=loadvar('CONC1_mod_cip_IBR', filename=nclPath)
endif else begin
  cipmodconc1=replicate(!VALUES.F_NAN,nPoints1Pre)
endelse

;CIP MOD2 CONC [/liter]
if cope eq 1 and cipmod eq 1 then begin
  cipmodconc2=loadvar('CONC2_mod_cip_IBR', filename=nclPath)
endif else begin
  cipmodconc2=replicate(!VALUES.F_NAN,nPoints1Pre)
endelse

;nevzorov sensor temperature [C]
nevTemp=double(loadvar('VLWCCOL_RAW', filename=nclPath, attr='temperature'))

;nevzorov sensor area [cm2]
if cope eq 1 then begin
  aLiq=.317
  aTot=.502
endif else begin
  aLiq=loadvar('vlwccol', filename=nclPath, attr='SampleArea')
  aTot=loadvar('vtwccol', filename=nclPath, attr='SampleArea')
endelse


;nevzorov sensor resistances
rLwcCol=loadvar('VLWCCOL_RAW', filename=nclPath, attr='resistance')
rLwcRef=loadvar('VLWCREF_RAW', filename=nclPath, attr='resistance')
rTwcCol=loadvar('VTWCCOL_RAW', filename=nclPath, attr='resistance')
rTwcRef=loadvar('VTWCREF_RAW', filename=nclPath, attr='resistance')


;liquid water content from Nevzorov probe [g/m^3]
if cope eq 1 and nonev1 eq 1 then begin
  lwcNev1=loadvar('nevlwc1', filename=nclPath)
endif else begin
  lwcNev1=replicate(!VALUES.F_NAN,nPoints1Pre)
endelse  

;liquid water content from Nevzorov probe [g/m^3]
if cope eq 1 and nonev1 eq 1 then begin
   lwcNev2=loadvar('nevlwc2', filename=nclPath)
endif else begin   
  lwcNev2=replicate(!VALUES.F_NAN,nPoints1Pre)
endelse

;Total water content from Nevzorov probe [g/m^3]
if cope eq 1 and nonev1 eq 1 then begin
  twcNev=loadvar('nevtwc', filename=nclPath)
endif else begin  
  twcNev=replicate(!VALUES.F_NAN,nPoints1Pre)
endelse

;Sideslip Angle [deg]
betaB=loadvar('beta', filename=nclPath)
betaB=betaB*!radeg

;Yaw [deg]
avyawr=loadvar('avyawr', filename=nclPath)*!RADEG

;Attack Angle [rad]
alpha=loadvar('alpha', filename=nclPath)

;Flight Time [sec]
timeFlight=dindgen(nPoints1Pre,start=0,increment=1)
hour=loadvar('HOUR', filename=nclPath)
min=loadvar('MINUTE', filename=nclPath)
sec=loadvar('SECOND', filename=nclPath)

;CDP average transit times [us]
if calcTrans eq 1 then begin
  cdpTransB=cdpTransTime(flightDay)
  
  cdpTrans=cdpTransB[*,0]*25d-3
  cdpDofRej=cdpTransB[*,1] 
  cdpTransRej=cdpTransB[*,2]
  cdpAdcOver=cdpTransB[*,3]
endif else begin
  cdpTrans=replicate(!VALUES.F_NAN,nPoints1Pre)
  cdpDofRej=replicate(!VALUES.F_NAN,nPoints1Pre)
  cdpTransRej=replicate(!VALUES.F_NAN,nPoints1Pre)
  cdpAdcOver=replicate(!VALUES.F_NAN,nPoints1Pre)
endelse


;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------FILTER 25 HZ DATA------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vlwcref=filter25(vlwcref)
vlwccol=filter25(vlwccol)
vtwcref=filter25(vtwcref)
vtwccol=filter25(vtwccol)
ilwcref=filter25(ilwcref)
print,'->data filtered 25%'
itwccol=filter25(itwccol)
itwcref=filter25(itwcref)
ilwccol=filter25(ilwccol)
trf=filter25(trf)
aias=filter25(aias)
print,'->data filtered 50%'
pmb=filter25(pmb)
trose=filter25(trose)
z=filter25(z)
lwc100=filter25(lwc100)
avpitch=filter25(avpitch)
print,'->data filtered 75%'
avroll=filter25(avroll)
betaB=filter25(betaB)
avyawr=filter25(avyawr)
alpha=filter25(alpha)
tas=filter25(tas)



;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------FILTER 10 HZ DATA------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


twodp=filter10(twodp)



;REDIST CDP BINS TO 2D ARRAY
i=double(0)
j=double(0)
int=double(5)

cdpdbinsB=make_array(n1(cdpdbins[*,0,0]),n1(cdpdbins[0,*,0])*n1(cdpdbins[0,0,*]))*0
for j=0, n(cdpdbins[0,0,*]) do begin
  cdpdbinsB[*,i]=cdpdbins[*,0,j]
  cdpdbinsB[*,i+1]=cdpdbins[*,1,j]
  cdpdbinsB[*,i+2]=cdpdbins[*,2,j]
  cdpdbinsB[*,i+3]=cdpdbins[*,3,j]
  cdpdbinsB[*,i+4]=cdpdbins[*,4,j]

  i=i+int
endfor

cdplwc_1_NRBB=[]
for i=0,n(cdplwc_1_NRB[0,*]) do begin
  cdplwc_1_NRBB=[temporary(cdplwc_1_NRBB),cdplwc_1_NRB[*,i]]
endfor



;----DETECT NEV POWER ON------
vsig=where(vlwccol gt 2.5)
vsig=vsig[30:n_elements(vsig)-30]
aStart=min(vsig)
aEnd=max(vsig)
ind5=vsig[0:*:5]
aStart5=aStart
aEnd5=aEnd/5

;--------------------FILTER VARIABLES TO FLIGHT TIME BOUNDS (BASED ON NEVZOROV POWER UP/DOWN)--------------------
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
pmb=pmb[aStart:aEnd]
trose=trose[aStart:aEnd]
z=z[aStart:aEnd]
lwc100=lwc100[aStart:aEnd]
cdpconc_1_NRB=cdpconc_1_NRB[aStart:aEnd]
cdpacc=cdpacc[aStart:aEnd]
cdpdbar_1_NRB=cdpdbar_1_NRB[aStart:aEnd]
avpitch=avpitch[aStart:aEnd]
avroll=avroll[aStart:aEnd]
avyawr=avyawr[aStart:aEnd]
alpha=alpha[aStart:aEnd]
betaB=betaB[aStart:aEnd]
twodp=twodp[aStart:aEnd]
cdplwc_1_NRB=cdplwc_1_NRBB[aStart:aEnd]
fsspConc=fsspConc[aStart:aEnd]
fsspLwc=fsspLwc[aStart:aEnd]
cdpdbins=cdpdbinsB[*,aStart:aEnd]


nPoints1=n1(pmb)
nPoints=nPoints1-1.

print,'->data filtered'



cdpTrans=cdpTrans[aStart:aEnd]
cdpDofRej=cdpDofRej[aStart:aEnd]
;cdpTransRej=cdpTransRej[aStart:aEnd]
cdpAdcOver=cdpAdcOver[aStart:aEnd]
;cdpdbinsC=make_array(28,aEnd-aStart+1.)
;cdpdbinsC[*,*]=cdpdbinsB[*,aStart:aEnd]



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
aias=aias*.514444

;SCALE CDP TRANSITS TO MEAN TAS
cdpTransEst=.0002/tas



;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------K AIRSPEED DEPENDANCE PARAMETERIZATION---------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if cope eq 1 then begin
  kLiq=(1.03672)*(0.965516)^aias+(1.11339)
  kTot=(1.13654)*(0.989413)^aias+(0.309623)
endif



if cope eq 2 or cope eq 0 then begin  
  ;----POLY2 FITS-----;
  kLiq700=(6.251e-06)*aias^2. + (-0.002757)*aias + (1.851)
  kLiq600=(-3.409e-06)*aias^2. + (-0.001221)*aias + (1.808)
  kLiq500=(-7.119e-05)*aias^2. + (0.01001)*aias + (1.339)
  kLiq400=(2.381e-05)*aias^2. + (-0.005848)*aias + (2.011)

  
  
  case level of
    '700':begin
      coLiq=[6.251e-06,-0.002757,1.851]
      coTot=[15.72,-0.8012,0.3106]
    end
    '600':begin
      coLiq=[-3.409e-06,-0.001221,1.808]
      coTot=[664.9,-1.894,0.6623]
    end
    '500':begin
      coLiq=[-7.119e-05,0.01001,1.339]
      coTot=[-1.102e-06,2.626,0.9771]
    end
    '400':begin
      coLiq=[2.381e-05,-0.005848,2.011]
      coTot=[3.798,-0.3249,-0.005089]
    end
  endcase

  kLiq=coLiq[0]*aias^2. + coLiq[1]*aias + coLiq[2]
  kTot=coTot[0]*aias^2. + coTot[1]*aias + coTot[2]
endif

if useLarK eq 1 then begin
  ;----POLY2 FITS-----;

  kLiq700=(1.046e-05)*aias^2. + (-0.004067)*aias + (2.002)
  kLiq600=(7.592e-06)*aias^2. + (-0.003641)*aias + (1.984)
  kLiq500=(4.429e-05)*aias^2. + (-0.0104)*aias + (2.282)
  kLiq400=(1.584e-05)*aias^2. + (-0.006102)*aias + (2.119) 
  
  
  case level of
    '700':begin
      coLiq=[1.046e-05,-0.004067,2.002]
      coTot=[15.72,-0.8012,0.3106]
    end
    '600':begin
      coLiq=[7.592e-06,-0.003641,1.984]
      coTot=[664.9,-1.894,0.6623]
    end
    '500':begin
      coLiq=[4.429e-05,-0.0104,2.282]
      coTot=[-1.102e-06,2.626,0.9771]
    end
    '400':begin
      coLiq=[1.584e-05,-0.006102,2.119]
      coTot=[3.798,-0.3249,-0.005089]
    end
  endcase

  kLiq=coLiq[0]*aias^2. + coLiq[1]*aias + coLiq[2]
  kTot=coTot[0]*aias^2. + coTot[1]*aias + coTot[2]
endif


kTot=5.565e-05*aias^2. + (-0.01345)*aias + 1.545


;------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------CLEARAIR POINT DETECTION---------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------------------------------------------

nPointsFilt=n(vlwccol)
nPointsFilt1=n(vlwccol)+1d

correctionLiq=dindgen(nPointsFilt1,increment=0)
smoothSignalLiq=dindgen(nPointsFilt1,increment=0)

correctionTot=dindgen(nPointsFilt1,increment=0)
smoothSignalTot=dindgen(nPointsFilt1,increment=0)

rawSignalLiq=(vlwccol/vlwcref)
rawSignalTot=(vtwccol/vtwcref)


correctionLiqB=[]
correctionLiqBX=[]
int=50
for i=0,nPointsFilt do begin
  if nPointsFilt-i gt 50 then begin
    correctionLiqB=[correctionLiqB,min(rawSignalLiq[i:i+int])]
    correctionLiqBX=[correctionLiqBX,where(rawSignalLiq[i:i+int] eq min(rawSignalLiq[i:i+int]))+i]
  endif else begin
    correctionLiqB=[correctionLiqB,min(rawSignalLiq[i:n(correctionLiq)])]
    correctionLiqBX=[correctionLiqBX,where(rawSignalLiq[i:n(correctionLiq)] eq min(rawSignalLiq[i:n(correctionLiq)]))+i]
  endelse
  i=i+int
endfor

smLiq=ts_smooth(correctionLiqB,5)

for i=0,n(correctionLiqB)-1 do begin
  smoothfit=linfit([correctionLiqBX[i],correctionLiqBX[i+1]],[smLiq[i],smLiq[i+1]]) 
  for j=correctionLiqBX[i],correctionLiqBX[i+1] do begin
    smoothSignalLiq[j]=rawSignalLiq[j]-(smoothfit[0]+smoothfit[1]*(j))
  endfor
endfor



correctionTotB=[]
correctionTotBX=[]
int=50
for i=0,nPointsFilt do begin
  if nPointsFilt-i gt 50 then begin
    correctionTotB=[correctionTotB,min(rawSignalTot[i:i+int])]
    correctionTotBX=[correctionTotBX,where(rawSignalTot[i:i+int] eq min(rawSignalTot[i:i+int]))+i]
  endif else begin
    correctionTotB=[correctionTotB,min(rawSignalTot[i:n(correctionTot)])]
    correctionTotBX=[correctionTotBX,where(rawSignalTot[i:n(correctionTot)] eq min(rawSignalTot[i:n(correctionTot)]))+i]
  endelse
  i=i+int
endfor

smTot=ts_smooth(correctionTotB,5)

for i=0,n(correctionTotB)-1 do begin
  smoothfit=linfit([correctionTotBX[i],correctionTotBX[i+1]],[smTot[i],smTot[i+1]])
  for j=correctionTotBX[i],correctionTotBX[i+1] do begin
    smoothSignalTot[j]=rawSignalTot[j]-(smoothfit[0]+smoothfit[1]*(j))
  endfor
endfor

threshLiq=q1(smoothSignalLiq[where(smoothSignalLiq gt 0)])
threshTot=q1(smoothSignalTot[where(smoothSignalTot gt 0)])

clearairLiq=where(smoothSignalLiq lt threshliq)
clearairTot=where(smoothSignalTot lt threshTot)

selSigLiq=rawSignalLiq[clearairLiq]
clearairLiqSort=clearairLiq[sort(selSigLiq)]
clearairLiq=clearairLiqSort[0:n1(clearairLiq)*.95]

selSigTot=rawSignalTot[clearairTot]
clearairTotSort=clearairTot[sort(selSigTot)]
clearairTot=clearairTotSort[0:n1(clearairTot)*.95]



;-------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------MOMENT CALCULATIONS---------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------

diff=make_array(nPoints1)
if n_elements(cdpdbins[*,0]) eq 28 then diam=[0.,2.5,3.5,4.5,5.5,6.5,7.5,9.,11.,13.,15.,17.,19.,21.,23.,25.,27.,29.,31.,33.,35.,37.,39.,41.,43.,45.,47.,49.]
if n_elements(cdpdbins[*,0]) eq 27 then diam=[0.,2.5,3.5,4.5,5.5,6.5,7.5,8.5,10.5,14.,17.,19.,21.,23.,25.,27.,29.,31.,33.,35.,37.,39.,41.,43.,45.,47.,49.]
diamRedist=diam-2. ;Diam mod for cdpLwcB

dEff=[]
vmd=[]
vvd=[]
cdpDBarB=[]
cdpLwcB=[]
cdpBinVar=[]
cdpBinSkew=[]
cdpBinKert=[]
cdpBinBimod=[]
cdpBinMAD=[]
cdpBinSD=[]
s=0


for m=double(0), n(cdpdbins[0,*]) do begin
  xa=[]
  xb=[]
  xc=[]
  xe=[]
  dropMass=[]
  meanDiff=[]
  for j=double(0),n(cdpdbins[*,0]) do begin
    xe=[xe,(diam[j])*(cdpdbins[j,m])]
    xa=[xa,(diam[j])^2.*(cdpdbins[j,m])]
    xb=[xb,(diam[j])^3.*(cdpdbins[j,m])]
    xc=[xc,(diam[j])^4.*(cdpdbins[j,m])]
    dropmass=[dropmass,((4./3.)*!pi*((diamRedist[j]*1d-6)/2.)^3.*1d6)*(cdpdbins[j,m])]
  endfor  
  
  dEffB=total(xb)/total(xa)
  if finite(dEffB) eq 1 then dEff=[dEff,dEffB] else dEff=[dEff,0]
  ;if finite(dEffB) eq 1 then stop
  
  cdpDBarBB=total(xe)/total(cdpdbins[*,m])
  if finite(cdpDBarBB) eq 1 then cdpDBarB=[cdpDBarB,cdpDBarBB] else cdpDBarB=[cdpDBarB,0]
  
  vvdB=(total(xb)/total(cdpdbins[*,m]))^(1./3.)
  if finite(vvdB) eq 1 then vvd=[vvd,vvdB] else vvd=[vvd,0]
  
  vmdB=total(xc)/total(xb)
  if finite(vmdB) eq 1 then vmd=[vmd,vmdB] else vmd=[vmd,0]
  
  sVol=.3d-6*(tas[m]*(1./5.))
  cdpLwcBB=total(dropmass)/sVol
  if finite(cdpLwcBB) eq 1 then cdpLwcB=[cdpLwcB,cdpLwcBB] else cdpLwcB=[cdpLwcB,0]
  

  gtZInd=where(cdpdbins[*,m] gt 0)
  binRedist=[]
  for y=0,n_elements(gtZInd)-1 do begin
    if min(gtZInd) gt 0d then begin
      binRedist=[binRedist,replicate(diam[gtZInd[y]],cdpdbins[gtZInd[y],m])]
    endif else begin
      binRedist=!values.d_nan
    endelse
    
  endfor
  
  ;-----CALC CDP DSD STATS-----
  diffs=binRedist-CdpDBarB[m]
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

print,'->CDP Data Calced'


;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------COLLECTION EFFECIENCY PARAMETERIZATION---------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;--------------------LIQUID COLLECTION EFFECIENCY--------------------
colEliq=dindgen(nPoints1,start=1,increment=0)
for d=0,nPoints do begin
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


;--------------------TOTAL COLLECTION EFFECIENCY--------------------
colETot=dindgen(nPoints1,start=1,increment=0)
for c=0,nPoints do begin
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



;coef=[1.882,-8.271e-05,-0.001867] ;400,600,700
;kLiqSurf = (coef[0]) + coef[1]*pmb + coef[2]*aias



coef=[1.859,0.0002357,-0.00331,-3.853e-07,1.346e-06,4.08e-06];400,600,700
;coef=[1.491,0.00112,-0.001329,-1.116e-06,2.319e-06,-1.22e-05] ;500,600,700
;coef=[2.136,-0.001427,-1.054e-05,1.181e-06,2.395e-06,-2.037e-05] ;400,500,600
if useLarK eq 1 then coef=[2.238,-0.0003147,-0.007652,9.983e-08,2.815e-06,2.037e-05 ] ;For LAR

den=pmb*1d2/(287.*(trf+273.15))
kLiqSurf = (coef[0]) + coef[1]*pmb + coef[2]*aias + coef[3]*pmb^2. + coef[4]*pmb*aias + coef[5]*aias^2.
if useLarK eq 1 then begin
  
  coef=[2.13,-0.0003407,-0.004702,8.686e-08,3.34e-06 ] ;For LAR
  kLiqSurf = (coef[0]) + coef[1]*pmb + coef[2]*aias + coef[3]*pmb^2. + coef[4]*pmb*aias
endif


coefTwc=[1.425,-0.0001851,-0.005842,-1.343e-08,-2.728e-06,1.842e-05];400,600,700
kTotSurf = (coefTwc[0]) + coefTwc[1]*pmb + coefTwc[2]*aias + coefTwc[3]*pmb^2. + coefTwc[4]*pmb*aias + coefTwc[5]*aias^2.



;--------------------POWER CALCULATIONS--------------------
pLiq=vlwccol*ilwccol-kLiq*vlwcref*ilwcref
pLiqNpc=pLiq
lwcNpc=pLiq/(1d*tas*aLiq*expHeatLiq)

pLiq700=vlwccol*ilwccol-kLiq700*vlwcref*ilwcref
pLiq600=vlwccol*ilwccol-kLiq600*vlwcref*ilwcref
pLiq500=vlwccol*ilwccol-kLiq500*vlwcref*ilwcref
pLiq400=vlwccol*ilwccol-kLiq400*vlwcref*ilwcref

lwc700=pLiq700/(1d*tas*aLiq*expHeatLiq)
lwc600=pLiq600/(1d*tas*aLiq*expHeatLiq)
lwc500=pLiq500/(1d*tas*aLiq*expHeatLiq)
lwc400=pLiq400/(1d*tas*aLiq*expHeatLiq)


pLiqSurf=vlwccol*ilwccol-kLiqSurf*vlwcref*ilwcref



pTot=vtwccol*itwccol-kTot*vtwcref*itwcref
pTotNpc=pTot
twcNpc=pTot/(1d*tas*aTot*expHeatIce)

pTotSurf=vtwccol*itwccol-kTotSurf*vtwcref*itwcref

;--------------------POWER PRESSURE CORRECTION--------------------

linPresCorLiq=ladfit(pmb[clearairLiq],pLiqSurf[clearairLiq])
pLiq=pLiqSurf - ( linPresCorLiq[1]*pmb + linPresCorLiq[0] )

if useDen eq 1 then begin
  linPresCorLiq=ladfit(den[clearairLiq],pLiqNpc[clearairLiq])
  pLiq=pLiqNpc - ( linPresCorLiq[1]*den + linPresCorLiq[0] )
endif

linPresCorTot=ladfit(pmb[clearairTot],pTotNpc[clearairTot])
pTot=pTotNpc - ( linPresCorTot[1]*pmb + linPresCorTot[0] )


;--------------------FINAL CALCULATIONS--------------------

;LWC
lwc=pLiq/(1.*tas*aLiq*expHeatLiq)

lwcSurf=pLiqSurf/(1.*tas*aLiq*expHeatLiq)


;TWC
twc=pTot/(1.*tas*aTot*expHeatIce)

twcSurf=pTotSurf/(1.*tas*aTot*expHeatIce)

iwc=twc-lwc


;--------------------ERROR CALCULATIONS--------------------

;-----------------LWC-----------------

;----------CONTRIBUTIONS---------
lwcColEUncU=(1./colEliq)
lwcRandFluct=3d-3/2.
lwcUB=lwc*lwcColEUncU+lwcRandFluct
lwcLb=lwc-3d-3/2.

;----------CALCULATIONS---------



;--------------------FINAL BASELINE FILTERING--------------------

lwcClearAirI=clearairLiq+startsec
twcClearAirI=clearairTot+startsec


flightSec=dindgen(n1(lwc),start=startsec,increment=1)


;--------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------PASS VARIABLES---------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------

color=['black','firebrick','navy','dark green','magenta','coral','indian red','dodger blue','orange','olive drab','medium violet red']

d={pmb:pmb, time:time, avroll:avroll, avpitch:avpitch, twodp:twodp,$
  pLiq:pLiq,lwcNev1:lwcNev1, twcNev:twcNev, lwcNpc:lwcNpc,$
  clearairLiq:clearairLiq,timeFlight:timeFlight,pLiqSurf:pLiqSurf,$
  kLiq:kLiq,threshLiq:threshLiq, clearairTot:clearairTot,beta:betaB,$
  aias:aias, tas:tas,vlwcref:vlwcref, ilwcref:ilwcref, twcNpc:twcNpc,$
  vlwccol:vlwccol, ilwccol:ilwccol, cdpconc:cdpconc_1_NRB, trf:trf,trose:trose, threshTot:threshTot,$
  lwc100:lwc100, cdpdbar:cdpdbar_1_NRB,lwcnev2:lwcnev2,cdpDofRej:cdpDofRej,$
  avyaw:avyawr,cdplwc:cdplwc_1_NRB,pLiqNpc:pLiqNpc,twcClearAirI:twcClearAirI,$
  rawSignalLiq:rawSignalLiq, smoothSignalLiq:smoothSignalLiq, cdpacc:cdpacc,flightSec:flightSec,$
  rawSignalTot:rawSignalTot, smoothSignalTot:smoothSignalTot, pTot:pTot,pTotNpc:pTotNpc,$
  vtwccol:vtwccol,itwccol:itwccol,vtwcref:vtwcref,itwcref:itwcref,aTot:aTot,expHeatIce:expHeatIce,$
  cdpdbins:cdpdbins,lwc:lwc,expHeatLiq:expHeatLiq,smLiq:smLiq,smLiqX:correctionLiqBX,$
  dEff:dEff,vvd:vvd,vmd:vmd,coleliq:coleliq,lwcLb:lwcLb,twcSurf:twcSurf,$
  twc:twc,colETot:colETot,cdpDBarB:cdpDBarB,rLwcCol:rLwcCol,rLwcRef:rLwcRef,rTwcCol:rTwcCol,$
  cipmodconc0:cipmodconc0,cipmodconc1:cipmodconc1,fsspConc:fsspConc,cdpTrans:cdpTrans,$
  cipmodconc2:cipmodconc2,color:color,fsspLwc:fsspLwc,rTwcRef:rTwcRef,$
  cdpBinVar:cdpBinVar,cdpBinSkew:cdpBinSkew,cdpBinKert:cdpBinKert,$
  cdpBinBimod:cdpBinBimod,cdpBinMAD:cdpBinMAD,cdpBinSD:cdpBinSD,$
  cdpTransEst:cdpTransEst,iwc:iwc,lwcUB:lwcUB,lwcSurf:lwcSurf,den:den,$
  cdpTransRej:cdpTransRej,cdpAdcOver:cdpAdcOver,cdpLwcB:cdpLwcB,$
  lwcClearAirI:lwcClearAirI,alpha:alpha,correctionLiq:correctionLiq,$
  lwc700:lwc700,lwc600:lwc600,lwc500:lwc500,lwc400:lwc400}

return,d

end





;---------------------------------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------FILTER 25HZ DATA -> 5HZ------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------------------------------------------

function filter25, varC
  varLin=make_array(n1(varC[*,0])*n1(varC[0,*]))*!values.d_nan
  k=double(0)
  for i=0,n(varC[0,*]) do begin
    for j=0,n(varC[*,0]) do begin
      varLin[k]=varC[j,i]
      k++
    endfor
  endfor

  varB=smooth(varLin,5)

  varFilt=varb[0:*:5]

  return,varFilt
end





;---------------------------------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------FILTER 10HZ DATA -> 5HZ------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------------------------------------------

function filter10, varC
  varLin=[]
  for i=0,n(varC[0,*]) do begin
    varLin=[varLin,varc[*,i]]
  endfor
  
  varB=smooth(varLin,2)

  varFilt=varb[0:*:2]

  return,varFilt
end



function cdpTransTime, flightDay

  ;COPE
  if flightDay eq '0709' then nclPath='/Volumes/externalHD/copeRaw/20130709_raw.nc'
  if flightDay eq '0710' then nclPath='/Volumes/externalHD/copeRaw/20130710_raw.nc'
  if flightDay eq '0725' then nclPath='/Volumes/externalHD/copeRaw/20130725_raw.nc'
  if flightDay eq '0727' then nclPath='/Volumes/externalHD/copeRaw/20130727_raw.nc'
  if flightDay eq '0728' then nclPath='/Volumes/externalHD/copeRaw/20130728_raw.nc'
  if flightDay eq '0729' then nclPath='/Volumes/externalHD/copeRaw/20130729_raw.nc'
  if flightDay eq '0807' then nclPath='/Volumes/externalHD/copeRaw/20130807_raw.nc'
  if flightDay eq '0814' then nclPath='/Volumes/externalHD/copeRaw/20130814_raw.nc'
  if flightDay eq '0815' then nclPath='/Volumes/externalHD/copeRaw/20130815_raw.nc'
  if flightDay eq '0802' then nclPath='/Volumes/externalHD/copeRaw/20130802_raw.nc'
  if flightDay eq '0803' then nclPath='/Volumes/externalHD/copeRaw/20130803_raw.nc'
  if flightDay eq '0304' then nclPath='/Volumes/externalHD/copeRaw/20160304_raw.nc'
  if flightDay eq '0307' then nclPath='/Volumes/externalHD/copeRaw/20160307_raw.nc'
  if flightDay eq '1217' then nclPath='/Volumes/externalHD/copeRaw/20151217_raw.nc'
  if flightDay eq '1112' then nclPath='/Volumes/externalHD/copeRaw/20151112_raw.nc'
  if flightDay eq '1124' then nclPath='/Volumes/externalHD/copeRaw/20151124_raw.nc'
  if flightDay eq '0806' then nclPath='/Volumes/externalHD/copeRaw/20130806_raw.nc'
  if flightDay eq '0813' then nclPath='/Volumes/externalHD/copeRaw/20130813_raw.nc'
  if flightDay eq '0817' then nclPath='/Volumes/externalHD/copeRaw/20130817_raw.nc'
  if flightDay eq '0722' then nclPath='/Volumes/externalHD/copeRaw/20130722_raw.nc'
  if flightDay eq '0718' then nclPath='/Volumes/externalHD/copeRaw/20130718_raw.nc'
  if flightDay eq '0120' then nclPath='/Volumes/externalHD/copeRaw/20160120_raw.nc'
  if flightDay eq '0125' then nclPath='/Volumes/externalHD/copeRaw/20160125_raw.nc'
  if flightDay eq '0817a' then nclPath='/Volumes/externalHD/copeRaw/20130817a_raw.nc'
  if flightDay eq '0817b' then nclPath='/Volumes/externalHD/copeRaw/20130817b_raw.nc'

  ;LARAMIE
  if flightDay eq '0120' then nclPath='/Volumes/externalHD/copeRaw/20160120_raw.nc'
  if flightDay eq '0125' then nclPath='/Volumes/externalHD/copeRaw/20160125_raw.nc'
  if flightDay eq '0304' then nclPath='/Volumes/externalHD/copeRaw/20160304_raw.nc'
  if flightDay eq '0307' then nclPath='/Volumes/externalHD/copeRaw/20160307_raw.nc'
  if flightDay eq '1217' then nclPath='/Volumes/externalHD/copeRaw/20151217_raw.nc'
  if flightDay eq '1112' then nclPath='/Volumes/externalHD/copeRaw/20151112_raw.nc'
  if flightDay eq '1124' then nclPath='/Volumes/externalHD/copeRaw/20151124_raw.nc'
  
  ;PACMICE
  if flightDay eq '081816' then nclPath='/Volumes/externalHD/copeRaw/20160818_raw.nc'
  if flightDay eq '082516' then nclPath='/Volumes/externalHD/copeRaw/20160825_raw.nc'
  if flightDay eq '082616' then nclPath='/Volumes/externalHD/copeRaw/20160826_raw.nc'
  if flightDay eq '090416' then nclPath='/Volumes/externalHD/copeRaw/20160904_raw.nc'  
  if flightDay eq '090916' then nclPath='/Volumes/externalHD/copeRaw/20160909_raw.nc'
  if flightDay eq '091016' then nclPath='/Volumes/externalHD/copeRaw/20160910_raw.nc'
  if flightDay eq '091316' then nclPath='/Volumes/externalHD/copeRaw/20160913_raw.nc'
  if flightDay eq '091616' then nclPath='/Volumes/externalHD/copeRaw/20160916_raw.nc'
  if flightDay eq '092316' then nclPath='/Volumes/externalHD/copeRaw/20160923_raw.nc'
  
  cdpAveTransSps=loadvar('AVGTRNS_NRB', filename=nclPath)
  ;cdpTransRejSps=loadvar('REJAT_NRB', filename=nclPath)
  cdpDofRejSps=loadvar('REJDOF_NRB', filename=nclPath) 
  cdpAdcOverSps=loadvar('OVFLW_NRB', filename=nclPath) 
  cdpAveTrans=[]
  cdpDofRej=[]
  cdpAdcOver=[]
  
  for i=double(0),n(cdpAveTransSps[0,*]) do begin
    cdpAveTrans=[cdpAveTrans,cdpAveTransSps[0,i],cdpAveTransSps[1,i],cdpAveTransSps[2,i],cdpAveTransSps[3,i],cdpAveTransSps[4,i]]
    cdpDofRej=[cdpDofRej,cdpDofRejSps[0,i],cdpDofRejSps[1,i],cdpDofRejSps[2,i],cdpDofRejSps[3,i],cdpDofRejSps[4,i]]
    cdpAdcOver=[cdpAdcOver,cdpAdcOverSps[0,i],cdpAdcOverSps[1,i],cdpAdcOverSps[2,i],cdpAdcOverSps[3,i],cdpAdcOverSps[4,i]]
  endfor


  ;return, [[cdpAveTrans],[cdpDofRej],[cdpTransRej],[cdpAdcOver]]
  return, [[cdpAveTrans],[cdpDofRej],[dindgen(n1(cdpDofRej))*0],[cdpAdcOver]]
end



function filtliqLB,lwc,twodp,trf
  inds=where(trf gt -3 and twodp lt .5 and lwc gt .0075)
  return,inds
end

function filtliqLTB,lwc,twc,twodp,trf
  inds=where(trf gt -3 and twodp lt 0.25 and lwc gt .0075 and twc gt .0075)
  return,inds
end



