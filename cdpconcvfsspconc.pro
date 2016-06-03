pro cdpConcVFsspConc
  restore,'loopdata.sav'


  ;liqOnly=where(trf gt -3. and lwcvare lt 1.2 and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwcvare gt 0.05 and twcvare gt 0.05 and vmd lt 40. and cdpconc lt 600.)
  L=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and vmd lt 10. and finite(vmd) eq 1)
  L2=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and vmd gt 10. and vmd lt 20. and finite(vmd) eq 1)
  L3=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and vmd gt 20. and vmd lt 30. and finite(vmd) eq 1)
  L4=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and vmd gt 30. and vmd lt 40. and finite(vmd) eq 1)
  L5=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and vmd gt 40. and vmd lt 50. and finite(vmd) eq 1)


  min=0.
  max=500
  
  p1=scatterplot(cdpconc[l],fsspconc[l],dimensions=[960,960],symbol='.',margin=50,/device)
  p1.XRANGE=[min,max]
  p1.yRANGE=[min,max]
  p40=plot([min,max],[min,max],/overplot,'green',thick=2)
  p2=scatterplot(cdpconc[l2],fsspconc[l2],/overplot,symbol='.',sym_color='blue')
  p3=scatterplot(cdpconc[l3],fsspconc[l3],/overplot,symbol='.',sym_color='red')
  p4=scatterplot(cdpconc[l4],fsspconc[l4],/overplot,symbol='.',sym_color='purple')
  p5=scatterplot(cdpconc[l5],fsspconc[l5],/overplot,symbol='.',sym_color='orange')
  


  p1=scatterplot(cdpconc[L2],lwcvare[l2]-twcvare[L2],dimensions=[1600,1200],symbol='.',margin=50,/device)
  p40=plot([0,2000],[0,0],/overplot,'red')
  p2=scatterplot(cdpconc[L3],lwcvare[l3]-twcvare[L3],/overplot,symbol='.',sym_color='blue')
  p3=scatterplot(cdpconc[L4],lwcvare[l4]-twcvare[L4],/overplot,symbol='.',sym_color='red')
  p4=scatterplot(cdpconc[L5],lwcvare[l5]-twcvare[L5],/overplot,symbol='.',sym_color='green')
  p5=scatterplot(cdpconc[L6],lwcvare[l6]-twcvare[L6],/overplot,symbol='.',sym_color='orange')
  f1=poly_fit(cdpconc[L2],lwcvare[l2]-twcvare[L2],2,yfit=yfit)

  xbounds=dindgen(500,start=0,increment=.1)
  p2=plot(xbounds,f1[0]+f1[1]*xbounds+f1[2]*xbounds^2.,/overplot,'g')

  ;p2=scatterplot(vmd[L2],lwcvare[l2]-twcvare[L2],/overplot,sym_color='red',symbol='.')


  ;p2=scatterplot(vmd[L2],lwcvare[L2]-twcvare[L2],/overplot,sym_color='red',SYM_TRANSPARENCY=20)

  f1=ladfit(vmd[L2],lwcvare[L2]-twcvare[L2])



  l1=yfit
  p2=plot(xbounds,l1,/overplot,'r')



  stop
end