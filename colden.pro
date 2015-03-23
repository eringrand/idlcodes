function acrsectocm, arcsec, dis
d = dis
a = arcsec
sizepc = (d*arcsec) / 206265.
size = sizepc / 3.24077929e-19
return, size
end

function coldenratio, size, den, cd
h2cd = size*den
ratio = cd / h2cd 
print, ratio
return, h2cd
end

pro colden
pelsize = acrsectocm(25., 520.) ; Pelican
eagsize = acrsectocm(13.2, 1.9e3) ; Eagle 2

pelden = 10.^[4.8, 5.5, 5.3]
pelcd =  10.^[12.8, 12.4, 12.1]
eagden =  10.^[5.0, 6.0, 5.5] 
eagcd = 10.^[12.8, 12.4, 12.1]

pelh2cd = coldenratio(pelsize,pelden,pelCD)
print, pelh2cd
eagh2cd = coldenratio(eagsize,eagden,eagCD)
print, eagh2cd

end
