pro vmdLwcRel
restore,'loopdata.sav'

liq=0

;liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and vmd lt 40. and cdpconc lt 600.)
L=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.03 and twc gt 0.03)
L2=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.03 and twc gt 0.03 and cdpconc lt 110.)
;liqOnly=where(lwc gt 0.05 and lwc lt 1.2 and cdpconc lt 200.)


if liq eq 1 then begin
  lwcVarE=lwcVarE[liqonly]
  twcVarE=twcVarE[liqonly]
  cdpdbar=cdpdbar[liqonly]
  cdpconc=cdpconc[liqonly]
  dEff=dEff[liqonly]
  vvd=vvd[liqonly]
  vmd=vmd[liqonly]
  cdplwc=cdplwc[liqonly]
  trf=trf[liqonly]
  lwc=lwc[liqonly]
  twc=twc[liqonly]

  cipmodconc0=cipmodconc0[liqonly]
  cipmodconc1=cipmodconc1[liqonly]
  cipmodconc2=cipmodconc2[liqonly]
  lwc100=lwc100[liqonly]
endif

p1=scatterplot(vmd[L],lwc[L]-twc[L],dimensions=[1200,1600])
p1=scatterplot(vmd[L2],lwc[L2]-twc[L2],/overplot,sym_color='red',SYM_TRANSPARENCY=20)

f1=ladfit(vmd[L2],lwc[L2]-twc[L2])
xbounds=dindgen(50,start=0,increment=1)
l1=yfit
p2=plot(xbounds,l1,/overplot,'r')



stop
end