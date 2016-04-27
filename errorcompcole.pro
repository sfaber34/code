pro errorCompCole

  restore,'colesavefile.sav'
  
  var=colevarlwc
  
  holder=dindgen(n_elements(var))
  
  var=(1.-var)*100.

  ytickvals=[]
  
  plot1=scatterplot(holder,var,dimensions=[1600,1200], name='900 mb K')
  ;plot1=scatterplot(holder,FIXEDLWCERROR,/overplot,sym_color='blue', name='900 mb K')
  ;plot2=scatterplot(holder,FIXEDTWCERROR,sym_color='red',/overplot, name='600 mb K')

  plot1.yrange=[-100,100]
  plot1.xtickname=day
  plot1.title='Mean LWC Error per Flight Day'
  plot1.ytitle='Absolute Mean LWC Error [g/m^3]
  plot1.xtitle='Flight Day'

  leg1=legend(target=[plot1,plot2,plot3], shadow=0)
  return

end