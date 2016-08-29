pro presCorExample
  restore, 'saves/loopdataprescorex.sav'
  
;  sig=vlwccol/vlwcref
;  
;  p1=plot(flightsec,sig,dimension=[1000,800])
;  
;  
;  
;  
  s1=scatterplot(pmb,lwcnpc,margin=[100,90,50,30],/device,dimension=[1000,800],sym_filled=1,sym_size=.4,sym_transparency=60,font_size=22,layout=[1,2,1])
  s1.yrange=[-.015,.025]
  s1.xrange=[620,920]
  s2=scatterplot(pmb[lwcclearairi],lwcnpc[lwcclearairi],sym_filled=1,sym_size=.4,sym_transparency=60,sym_color='blue',/overplot)
  zero1=plot(s1.xrange,[0,0],'--r',transparency=20,/overplot,thick=2)
  
  s3=scatterplot(pmb,lwc,margin=[100,90,50,30],/device,dimension=[1000,800],sym_filled=1,sym_size=.4,sym_transparency=60,font_size=22,layout=[1,2,2],/current)
  s3.yrange=s1.yrange
  s3.xrange=s1.xrange
  s4=scatterplot(pmb[lwcclearairi],lwc[lwcclearairi],sym_filled=1,sym_size=.4,sym_transparency=60,sym_color='blue',/overplot)
  zero2=plot(s1.xrange,[0,0],'--r',transparency=20,/overplot,thick=2)
stop
end