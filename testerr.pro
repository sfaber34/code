pro testErr
  restore,'loopdata.sav'

  f=where(lwc gt .05)

  p1=scatterplot(vmd[f],lwcErrColE[f]/lwc[f],dimensions=[1600,1200])
  p2=scatterplot(vmd[f],1.-coleliq[f],sym_color='red',/overplot)

end