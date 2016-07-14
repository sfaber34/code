function filter25, varC
  varB=smooth(varC,5)
  
  varFilt=[]
  
  for i=0,n(varC[0,*]) do begin
    varFilt=[temporary(varFilt),varB[0,i],varB[6,i],varB[11,i],varB[16,i],varB[21,i]]
  endfor

return,varFilt
end