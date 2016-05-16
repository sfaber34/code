pro lwcVlwc100
cgcleanup
restore,'loopdata.sav'

liqOnly=where(trf gt -3. and (cipmodconc0 lt .5 and finite(cipmodconc0) eq 1) and lwc gt 0.05 and twc gt 0.05)

p1=scatterplot(lwc100[liqOnly],(lwc100[liqOnly]-lwc[liqOnly])/lwc100[liqOnly],dimensions=[1600,1200],symbol='.')
p2=scatterplot(lwc100[liqOnly],(lwc100[liqOnly]-cdplwc[liqOnly])/lwc100[liqOnly],symbol='.',sym_color='red',/overplot)

p1.yrange=[-2,2]
end