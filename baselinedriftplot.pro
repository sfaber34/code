pro baselineDriftPlot

restore,'saves/loopdata400.sav'


p1=lp(flightsec,lwc)
p2=lp(flightsec,lwcNoPresCor,/op)
p2.color='blue'
p2.xrange=[2.122d4,2.132d4]
p2.yrange=[-.05,.3]
p2.xtickname=['0','60','120','180','240','300']
p2.xtitle='Time sec'
p2.ytitle='LWC g m!u-3!n'
p1.name='Corrected LWC'
p2.name='LWC - No Pressure Correction'

xs=dindgen(381)
s1=scatterplot(flightsec[clearairliq],lwc[clearairliq],sym_thick=2,sym_filled=1,/overplot,name='Clear Air Points')
s2=scatterplot(flightsec[clearairliq],lwcnoprescor[clearairliq],sym_thick=2,sym_filled=1,sym_color='blue',/overplot)

l1=legend(target=[p2,p1,s1],font_size=22,shadow=0)

stop
end