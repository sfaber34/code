pro precipTrends

restore,'loopdata.sav'


x=where(cipmodconc0 gt 5. and trf gt -3 and lwc lt 1.1)

cipmodconc0=cipmodconc0[x]
cdpmassmean=cdpmassmean[x]
lwcfixede=lwcfixede[x]
trf=trf[x]
lwc=lwc[x]
pmb=pmb[x]

p1=scatterplot(pmb,cipmodconc0,dimensions=[1500,1200])



stop
end