function cdpTransTime, flightDay

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

  cdpAveTransSps=loadvar('AVGTRNS_NRB', filename=nclPath)
  cdpDofRejSps=loadvar('REJDOF_NRB', filename=nclPath)
  cdpAveTransSpsAve=dindgen(n_elements(cdpAveTransSps[0,*]))
  cdpAveTransSpsAve[*]=!Values.d_NAN
  cdpDofRejSpsAve=dindgen(n_elements(cdpAveTransSps[0,*]))
  cdpDofRejSpsAve[*]=!Values.d_NAN
  
;  
;  for i=300,400 do begin
;    print,i,'->',max(sps[*,i]) 
;  endfor
  
  for i=342,n_elements(cdpAveTransSps[0,*])-1 do begin    
    cdpAveTransSpsFilt=cdpAveTransSps[*,i]
    nonNull=where(cdpAveTransSpsFilt gt 0.)
    cdpAveTransSpsFiltB=cdpAveTransSpsFilt[nonNull]
    cdpAveTransSpsAve[i]=mean(cdpAveTransSpsFiltB)

    cdpDofRejSpsFilt=cdpDofRejSps[*,i]
    nonNull=where(cdpDofRejSpsFilt gt 0.)
    cdpDofRejSpsFiltB=cdpDofRejSpsFilt[nonNull]
    cdpDofRejSpsAve[i]=mean(cdpDofRejSpsFiltB)
  endfor
  
  cdpAveTrans=cdpAveTransSpsAve
  cdpDofRej=cdpDofRejSpsAve

  return, [[cdpAveTrans],[cdpDofRej]]
end