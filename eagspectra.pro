; Function to fit gaussian functions to
; Eagle HCN multiple lines as well as help deterime FWHM of other lines 
; to see what the ratios between lines are

pro eagspectra, mol, showplot=showplot
FOR numF=1,3 do begin
   num = STRCOMPRESS(string(numF),/REMOVE_ALL)
   file='../MirImages/eagspectra'+num+mol+'.dat'
   openr,lun,file,/GET_LUN
   readcol, file, plane, v, sum, mean, npoints, /SILENT
   free_lUN, lun
   n = n_elements(v) - 2 
   v=v[0:n]
   mean=mean[0:n]
   if keyword_set(showplot) then cgplot, v[0:n],mean[0:n]

if ( numF eq 1 ) then begin 
	n1 = where(v le 20.5)	
	n2 = where(v gt 20.5 AND v le 28)
	n3  = where(v gt 28)
        start1 = [0.0D, 17., 1. , 3.] 
	start2 =  [0.D, 25., 1., 15.]
        start3 =  [0.D, 29., 1., 5.]
        if mol eq 'n2hp' then start1 =  [0.0, 17., 1., 4.]
        if mol eq 'n2hp' then start2 =  [0.0, 25., 1., 7.]
	if mol eq 'n2hp' then start3 =  [0.0, 30., 1., 6.]
	if mol eq '12co' then start2 =  [0.0, 25., 5., 80.]
endif 

if ( numF eq 2 ) then begin 
	n1 = where(v le 18)
        n2 = where(v gt 18 AND v le 25.5)
        n3  = where(v gt 25.5)
	start1 =  [0.0, 15.0, 1., 10.]
	start2 =  [0.0, 23.0, 1., 40.]
	start3 =  [0.0, 26.0, 1., 10.]
        if mol eq '12co' then start2 =  [0.0, 23., 5., 55.]
	if mol eq 'n2hp' then start1 =  [0.0, 14., 1., 3.]
	if mol eq 'n2hp' then start2 =  [0.0, 22., 1., 5.] 
	if mol eq 'n2hp' then start3 =  [0.0, 28., 1., 5.]
endif 

if ( numF eq 3 ) then begin 
	n1 = where(v le 17)
        n2 = where(v gt 17 AND v le 24)
	n3  = where(v gt 24)
	start1 =  [0.0, 14., 1., 10.]
	start2 =  [0.0, 21., 1., 50.]
	start3 =  [0.0, 26., 1., 10.]
        if mol eq 'n2hp' then start1 =  [0.0, 10., 1., 1.]
	if mol eq 'n2hp' then start3 =  [0.0, 21., 1., 2.]
	if mol eq 'n2hp' then start3 =  [0.0, 26., 1., 2.]
	if mol eq '12co' then start2 =  [0.0, 21., 5., 38.]
endif 

t1=v[n1]
r1 = mean[n1]
t2 = v[n2]
r2 = mean[n2]
t3 = v[n3]
r3 = mean[n3]

if mol ne 'HCN' AND mol ne 'n2hp' then begin
t1 = v[0]
r1 = mean[0]
t2 = v[1:n-1]
r2 = mean[1:n-1]
t3 = v[n]
r3 = mean[n]
endif


if keyword_set(showplot) then begin
cgplot, v[0:n],mean[0:n]
cgplot, t1, r1, color='red', /overplot
cgplot, t2, r2, color='green', /overplot
cgplot, t3, r3, color='blue', /overplot
endif


if  keyword_set(showplot)  then begin 
   spectra_results, mol, t1, t2, t3, r1, r2, r3, start1, start2, start3, numF, /showplot
endif else begin
   spectra_results, mol, t1, t2, t3, r1, r2, r3, start1, start2, start3, numf
endelse

ENDFOR

end
