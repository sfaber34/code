pro testKSurf

  paths=['/Users/spencerfaber/Documents/MATLAB/files/400surf.csv','/Users/spencerfaber/Documents/MATLAB/files/500surf.csv','/Users/spencerfaber/Documents/MATLAB/files/700surf.csv']

  x=[]
  y=[]
  z=[]
for i=0,n(paths) do begin
  data=read_csv(paths[i])
  x=[x,data.(0)]
  y=[y,data.(1)]
;  z=vertcat(z,data(1:end,3));
endfor

x=dindgen(501,start=300)
y=dindgen(501,start=50,increment=50./501.)
pmb=y
aias=x

coef=[-5.712,0.04076,0.006066,-7.483e-05,2.926e-05,-0.0002164,4.387e-08,-1.077e-08,-1.036e-07,1.196e-06]
kLiqSurf = (coef[0]) + coef[1]*pmb + coef[2]*aias + coef[3]*pmb^2. + coef[4]*pmb*aias + coef[5]*aias^2. + coef[6]*pmb^3. + coef[7]*pmb^2d*aias + coef[8]*pmb*aias^2d + coef[9]*aias^3d
stop
end