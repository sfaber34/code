pro vKorolev
  restore, 'saves/loopdatavKorolev.sav'
  s1=scatterplot(lwcnev,lwc,dimensions=[800,800],sym_filled=1,sym_size=.4,sym_transparency=80)
  s1.xrange=[0,2.5]
  s1.yrange=[0,2.5]
  s1.font_size=22
  p1=plot([0,2.5],[0,2.5],'--r',thick=3,/overplot,transparency=30)
  p1.xtitle="Korolev's LWC [g m!u-3!n]"
  p1.ytitle='LWC [g m!u-3!n]'
  stop
end  