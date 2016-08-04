pro presCorExample
  restore, 'saves/loopdatalar700PresCor.sav'
  
  s1=scatterplot(pmb,lwcnpc,margin=[100,50,50,30],/device,dimension=[1000,800],sym_filled=1,sym_size=.4,sym_transparency=60,font_size=22,layout=[1,2,1])
  s1.yrange=[-.02,.06]
  s2=scatterplot(pmb[lwcclearairi],lwcnpc[lwcclearairi],sym_filled=1,sym_size=.4,sym_transparency=60,sym_color='blue',/overplot)
  
  s1=scatterplot(pmb,lwc,margin=[100,50,50,30],/device,dimension=[1000,800],sym_filled=1,sym_size=.4,sym_transparency=60,font_size=22,layout=[1,2,2],/current)
  s1.yrange=[-.02,.06]
  s2=scatterplot(pmb[lwcclearairi],lwc[lwcclearairi],sym_filled=1,sym_size=.4,sym_transparency=60,sym_color='blue',/overplot)

end