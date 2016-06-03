pro vmdLwcRel
restore,'loopdata.sav'


;liqOnly=where(trf gt -3. and lwc lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05 and vmd lt 40. and cdpconc lt 600.)
L=where(lwc gt 0.02)
L2=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.01 and twc gt 0.01 and cdpconc lt 120. and finite(vmd) eq 1)
L3=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.01 and twc gt 0.01 and cdpconc gt 120. and cdpconc lt 220. and finite(vmd) eq 1)
L4=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.01 and twc gt 0.01 and cdpconc gt 220. and cdpconc lt 320. and finite(vmd) eq 1)
L5=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.01 and twc gt 0.01 and cdpconc gt 320. and cdpconc lt 420. and finite(vmd) eq 1)
;liqOnly=where(lwc gt 0.05 and lwc lt 1.2 and cdpconc lt 200.)

min=0.
max=2.5


;p1=scatterplot(lwcnev1[L],lwcnev2[l],dimensions=[920,1000],symbol='.',margin=50,/device)
;p4=plot([0,2.5],[0,2.5],/overplot,'red')
;
;p1.xrange=[0,2.5]
;p1.yrange=[0,2.5]
;p2.xrange=[0,2.5]
;p2.yrange=[0,2.5]


p1=scatterplot(vmd[L2],lwc[l2]-twc[L2],dimensions=[1600,1200],symbol='.',margin=50,/device)
p40=plot([0,50],[0,0],/overplot,'red')
p2=scatterplot(vmd[L3],lwc[l3]-twc[L3],/overplot,symbol='.',sym_color='blue')
p3=scatterplot(vmd[L4],lwc[l4]-twc[L4],/overplot,symbol='.',sym_color='red')
p4=scatterplot(vmd[L5],lwc[l5]-twc[L5],/overplot,symbol='.',sym_color='green')
f1=poly_fit(vmd[L2],lwc[l2]-twc[L2],2,yfit=yfit)

xbounds=dindgen(500,start=0,increment=.1)
p2=plot(xbounds,f1[0]+f1[1]*xbounds+f1[2]*xbounds^2.,/overplot,'g')

;p2=scatterplot(vmd[L2],lwc[l2]-lwcnev2[L2],/overplot,sym_color='red',symbol='.')


;p2=scatterplot(vmd[L2],lwc[L2]-twc[L2],/overplot,sym_color='red',SYM_TRANSPARENCY=20)

f1=ladfit(vmd[L2],lwc[L2]-twc[L2])



l1=yfit
p2=plot(xbounds,l1,/overplot,'r')



stop
end