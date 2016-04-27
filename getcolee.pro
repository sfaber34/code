pro getColeE

img=read_png('/Volumes/sfaber1/Research/nevzorov/graphics/coleECharttwc.png')

cgcleanup

;imageRGB = img[0:2, *,*]
;tv,imagergb,true=1


color=['blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red',$
  'blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red','blue','red']


blackx=dindgen(n_elements(img[0,*,0]))
blacky=[]

for i=0,n_elements(img[0,*,0])-1 do begin
  b=where(img[0,i,*] lt 200)
  bm=round(mean(b))
  blacky=[blacky,bm]

endfor


blackx=blackx*(150./2883.)

blacky=blacky/2901.




print,max(blackx)



y1gt=where(blacky[0:200] gt 0.)

x1=blackx[y1gt]
y1=blacky[y1gt]

p1=scatterplot(x1,y1,dimensions=[1600,1200],symbol='.')

fit1=poly_fit(x1,y1,6,yfit)
p2=plot(x1,yfit,color=color[0],/overplot)

y2gt=where(blacky[201:500] gt 0.)

x2=blackx[201.+y2gt]
y2=blacky[201.+y2gt]

p3=scatterplot(x2,y2,dimensions=[1600,1200],symbol='.')

fit2=poly_fit(x2,y2,4,yfit2)
p4=plot(x2,yfit2,color=color[1],/overplot)


y3gt=where(blacky[501:1922] gt 0.)

x3=blackx[501.+y3gt]
y3=blacky[501.+y3gt]

p4=scatterplot(x3,y3,dimensions=[1600,1200],symbol='.')

fit3=poly_fit(x3,y3,6,yfit3)
p5=plot(x3,yfit3,color=color[0],/overplot)



y4gt=where(blacky[1923:2883] gt 0.)

x4=blackx[1923.+y4gt]
y4=blacky[1923.+y4gt]

p5=scatterplot(x4,y4,dimensions=[1600,1200],symbol='.')

fit4=poly_fit(x4,y4,4,yfit4)
p6=plot(x4,yfit4,color=color[1],/overplot)





p20=scatterplot(blackx,blacky,dimensions=[1600,1200])
p2=plot(x1,yfit,color=color[0],/overplot)
p2=plot(x2,yfit2,color=color[1],/overplot)
p2=plot(x3,yfit3,color=color[0],/overplot)
p2=plot(x4,yfit4,color=color[1],/overplot)


stop


end