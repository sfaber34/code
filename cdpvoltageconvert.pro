pro cdpVoltageConvert

;-------------------------------------
rawVal=2422
;-------------------------------------

v=5*(rawVal/4095d)
c=( (alog(5d/v - 1)) / 3750d + 1/298d)^(-1d) - 273d
print,c
end