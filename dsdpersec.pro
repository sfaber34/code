pro dsdPerSec

  restore,'loopdata.sav'


  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  liq=1
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------


  ;liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and vmd lt 40.)
  liqOnly=where(lwc gt 0.02 and trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1))



  if liq eq 1 then begin
    lwc=lwc[liqonly]
    twc=twc[liqonly]
    cdpdbar=cdpdbar[liqonly]
    cdpconc=cdpconc[liqonly]
    dEff=dEff[liqonly]
    vvd=vvd[liqonly]
    vmd=vmd[liqonly]
    cdplwc=cdplwc[liqonly]
    trf=trf[liqonly]
    lwcVarE=lwcVarE[liqonly]
    twcVarE=twcVarE[liqonly]
    cipmodconc0=cipmodconc0[liqonly]
    cipmodconc1=cipmodconc1[liqonly]
    cipmodconc2=cipmodconc2[liqonly]
    coleliq=coleliq[liqonly]
    coletot=coletot[liqonly]
    lwcErrColE=lwcErrColE[liqonly]
    cdptrans=cdptrans[liqonly]
    cdpacc=cdpacc[liqonly]
    cdpbinbimod=cdpbinbimod[liqonly]
  endif


  ;--------------------------------------SET OPTIONS---------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  xstart=2
  xinc=3
  var=cdpbinn
  start=0
  ;----------------------------------------------------------------------------------------------------------------------------------------------
  ;----------------------------------------------------------------------------------------------------------------------------------------------

  cgcleanup
  w1=window(dimensions=[1900,1200],/device)
  
  lim=dindgen(20,start=0,increment=1)
  count=0
  for i=start,n_elements(pmb)-1 do begin
    if count lt 20 then begin
      if n_elements(where(cdpbinn[*,i]) gt 2) gt 5 and cdpbinkert[i] gt lim[count] then begin
        h1=cdpbinn[*,i]
        print,'----------------'
        print,i
        print,moment(h1),cdpbinbimod[i]
        p1=barplot(dindgen(n_elements(h1),start=xstart,increment=1),h1,histogram=1,layout=[4,5,count+1],margin=50,/device,/current)
        p1.xminor=0
        p1.xrange=[0,28]
        count++
        print,''
      endif
    endif else begin
      return
    endelse
    
  endfor
  


  p1.font_size=22
stop
end




pro dsdT
  restore,'loopdata.sav'
  p1=plot(smooth(cdpacc,500),dimensions=[1600,1200],layout=[1,2,1])
  p2=plot(smooth(cdpacc,100),'grey',layout=[1,2,2],/current)

end  