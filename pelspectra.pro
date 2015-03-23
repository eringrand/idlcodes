FUNCTION MYGAUSS, X, P
  RETURN, P[0] + GAUSS1(X, P[1:3], /peak)
END

; Function to fit gaussian functions to
; Eagle HCN multiple lines as well as help deterime FWHM of other lines 
; to see what the ratios between lines are

pro pelspectra, mol, showplot=showplot
   file='../../Pelican/MirImages/pelspectra'+mol+'.dat'
   openr,lun,file,/GET_LUN
   readcol, file, plane, v, sum, mean, npoints, /SILENT
   free_lUN, lun
   n = n_elements(v) - 2 
   v=v[0:n]
   mean=mean[0:n]
   if keyword_set(showplot) then cgplot, v[0:n],mean[0:n]

t1 = v[0:24]
r1 = mean[0:24]
t2 = v[25:45]
r2 = mean[25:45]
t3 = v[46:n]
r3 = mean[46:n]
start1 =  [0.0, -7., 1, .3]
start2 =  [0.0, 0., 1., 2.]
start3 =  [0.0, 5., 1., 0.6]
if mol eq '12co' then start2 =  [0.0, 0., 1., 30.]

if mol ne 'HCN' then begin
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

if keyword_set(showplot)  then begin 
   spectra_results, mol, t1, t2, t3, r1, r2, r3, start1, start2, start3, 'Pelican', /showplot
   endif else begin
   spectra_results, mol, t1, t2, t3, r1, r2, r3, start1, start2, start3, 'Pelican'
endelse

end
