pro lwcVoltStats
restore,'loopdata.sav'
cgcleanup

var=stddev(vlwccol[clearairliq])*2.5+mean(vlwccol[clearairliq])

p1=plot(flightsec,vlwccol,margin=50,/device,dimensions=[1600,1200])
;p2=plot(flightsec,smoothsignalliq+.5,margin=10,/overplot,'r')
p2=plot([flightsec[0],flightsec[max(flightsec)]],[var,var],/overplot,'r')

s1=scatterplot(flightsec[clearairliq],vlwccol[clearairliq],sym_size=.25,sym_filled=1,sym_transparency=10,sym_color='blue',/overplot)
;s2=scatterplot(flightsec[clearairliq],smoothsignalliq[clearairliq]+.5,sym_size=.25,sym_filled=1,sym_transparency=10,sym_color='blue',/overplot)

p3=plot(flightsec,lwc,margin=50,/device,dimensions=[1600,1200])
s3=scatterplot(flightsec[clearairliq],lwc[clearairliq],sym_size=.25,sym_filled=1,sym_transparency=10,sym_color='blue',/overplot)



binsz=.01

h1=histogram(smoothsignalliq,binsize=binsz)
p1=barplot(dindgen(n1(h1))*binsz,h1,histogram=1,dimensions=[1600,1200],margin=[110,70,30,20],/device)
p1.xrange=[0,.2]
stop
end