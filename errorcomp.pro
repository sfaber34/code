pro errorComp

  day=['','0710','0725','0727','0728','0729','0803','0807','0814','0815','']
  error900=[0.013775430653852869,    0.0099819696661646723,     0.021448555214754021,     0.028499303325611278,     0.032352047594234969,     0.034886942977207729,     0.029984582803160516,     0.029151169154550256,     0.033180666048507036]
  error600=[0.0089552956688427731,    0.0042507891712714003,     0.013181095619820532,     0.017277914083414142,     0.021189710625173535,     0.023597214693341598,     0.018917616750158656,     0.018283259986278555,     0.022101813414426429]
  error400=[0.016520486430498263,     0.016481420409525802,     0.010339676943927819,     0.010925152605610562,     0.011159943629303804,     0.010701586825125830,    0.0099214093945688576,    0.0070435612900862157,     0.010186531240735149]
  holder=dindgen(n_elements(error900))
  
  ytickvals=[]
  
  plot1=scatterplot(holder,error900,dimensions=[1200,900], name='900 mb K')
  plot2=scatterplot(holder,error600,sym_color='blue',/overplot, name='600 mb K')
  plot3=scatterplot(holder,error400,sym_color='red',/overplot, name='400 mb K')
  plot1.xrange=[-1,9]
  plot1.xtickname=day
  plot1.title='Mean LWC Error per Flight Day'
  plot1.ytitle='Absolute Mean LWC Error [g/m^3]
  plot1.xtitle='Flight Day'
  
  leg1=legend(target=[plot1,plot2,plot3], shadow=0)
  return

end