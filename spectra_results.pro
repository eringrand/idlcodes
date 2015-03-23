FUNCTION MYGAUSS, X, P
  RETURN, P[0] + GAUSS1(X, P[1:3], /peak)
END

pro spectra_results, mol, t1, t2, t3, r1, r2, r3, start1, start2, start3, numF, showplot=showplot

if mol eq 'HCN' OR mol eq 'n2hp' then pi1 = replicate({fixed:0, limited:[0,0], limits:[0.D,0.D]},4)
pi2 = replicate({fixed:0, limited:[0,0], limits:[0.D,0.D]},4)
if mol eq 'HCN' OR mol eq 'n2hp' then pi3 = replicate({fixed:0, limited:[0,0], limits:[0.D,0.D]},4)
;pi1(0).fixed=1
;if mol eq 'HCN' then pi2(0).fixed=1
;if mol eq 'HCN' then pi3(0).fixed=1

err = 0.15
if numF eq '1' OR numF eq '2' OR numF eq '3' then err = 0.4
rerr1 = FLTARR(N_ELEMENTS(t1)) + err
rerr2 = FLTARR(N_ELEMENTS(t2)) + err
rerr3 = FLTARR(N_ELEMENTS(t3)) + err

if mol eq 'HCN' OR mol eq 'n2hp' then result1 = MPFITFUN('MYGAUSS', t1, r1, rerr1, start1, parinfo=pi1, PERROR=err1, maxiter=10000,/quiet)
result2 = MPFITFUN('MYGAUSS', t2, r2, rerr2, start2, parinfo=pi2, PERROR=err2, maxiter=10000, /quiet)
if mol eq 'HCN' OR mol eq 'n2hp' then result3 = MPFITFUN('MYGAUSS', t3, r3, rerr3, start3, parinfo=pi3, PERROR=err3, maxiter=10000, /quiet)

t = [t1,t2,t3]
r = [r1,r2,r3]
if keyword_set(showplot) then begin
cgplot, t, r
if mol eq 'HCN' OR mol eq 'n2hp' then cgplot, t1, result1(0) + gauss1(t1, result1(1:3),/peak), color='red', thick=5, /overplot
cgplot, t2, result2(0) + gauss1(t2, result2(1:3),/peak), color='blue', thick=5, /overplot
if mol eq 'HCN' OR mol eq 'n2hp' then cgplot, t3, result3(0) + gauss1(t3, result3(1:3),/peak), color='green', thick=5, /overplot
endif

if mol eq 'HCN' OR mol eq 'n2hp' then peak1 = result1[3] - result1[0]
peak2 = result2[3] - result2[0]
if mol eq 'HCN' OR mol eq 'n2hp' then peak3 = result3[3] - result3[0]

if mol eq 'HCN' OR mol eq 'n2hp' then errPeak1 = sqrt(err1[3]^2 + err1[0]^2) 
errPeak2 = sqrt(err2[3]^2 + err2[0]^2)
if mol eq 'HCN' OR mol eq 'n2hp' then errPeak3 = sqrt(err3[3]^2 + err3[0]^2)

c = (2.*sqrt(2.*alog(2.))) 
if mol eq 'HCN' OR mol eq 'n2hp' then FWHM1= result1[2] * c
FWHM2= result2[2] * c
if mol eq 'HCN' OR mol eq 'n2hp' then FWHM3= result3[2] * c
if mol eq 'HCN' OR mol eq 'n2hp' then errFWHM1= err1[2] * c
errFWHM2= err2[2] * c
if mol eq 'HCN' OR mol eq 'n2hp' then errFWHM3= err3[2] * c

if mol eq 'HCN' OR mol eq 'n2hp' then ratioLEFT = peak1 / peak2 ; smallest of the three lines 
if mol eq 'HCN' OR mol eq 'n2hp' then ratioRIGHT = peak3 / peak2 ; middle 

if mol eq 'HCN' OR mol eq 'n2hp' then errRatioLeft = sqrt((errPeak1/peak1)^2 + (errPeak2/peak2)^2) * ratioLEFT
if mol eq 'HCN' OR mol eq 'n2hp' then errRatioRight = sqrt((errPeak3/peak3)^2 + (errPeak2/peak2)^2) * ratioRIGHT
if mol eq 'HCN' then print, 'HCN RATIOS ', numF, '1.0 $', cgNumber_Formatter(ratioRIGHT), '\pm',cgNumber_Formatter(errRatioRIGHT), '$ $', cgNumber_Formatter(ratioLEFT), '\pm',cgNumber_Formatter(errRatioLEFT), '$ \\'

if mol eq 'HCN' OR mol eq 'n2hp' then print, 'PEAK '+mol, numF, peak1, peak2, peak3
if mol eq 'HCN' OR mol eq 'n2hp' then print, 'PEAK '+mol, numF, errPeak1, errPeak2, errPeak3
if mol eq 'HCN' OR mol eq 'n2hp' then print, 'FWHM '+mol, numF, FWHM1, FWHM2, FWHM3
if mol eq 'HCN' OR mol eq 'n2hp' then print, 'FWHM '+mol, numF, errFWHM1, errFWHM2, errFWHM3

decp=2
dec = 3
if numF ne '1' OR '2' OR '3' then numR = 'Pelican'
if numF eq '1' then numR = 'Pillar I'
if numF eq '2' then numR = 'Pillar II'
if numF eq '3' then numR = 'Pillar III'
print, numR,  ' & ', mol, ' & $', cgNumber_Formatter(peak2,Decimals=decp), ' \pm ', cgNumber_Formatter(errPeak2,Decimals=decp),  '$ & $',  cgNumber_Formatter(FWHM2,Decimals=dec), ' \pm ', cgNumber_Formatter(errFWHM2,Decimals=dec) , '$ \\'

;print, result1
;print, result2
;print, result3

end
