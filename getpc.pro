; Pillar Ia: 20.615''  width, 126 '' length
; Pillar II: 20.615''  width, 126 '' length
; Pillar III: 13.2''  width, 59.5323 '' length
; Pelican: 22.5'' width, 191'' length

pro getpc
d = 520.0 ; pelican
width = acrsectopc(25., d)
length = acrsectopc(212., d)
print, width, length

d = 1.9e3 ; eagle
width = acrsectopc(20.615, d)
length = acrsectopc(126., d)
print, width, length

width = acrsectopc(13.2, d)
length = acrsectopc(59.53, d)
print, width, length

width = acrsectopc(7.0, d)
length = acrsectopc(56.6, d)
print, width, length

print, -0.8/acrsectopc(160.,520.) ;Pelican
print, -(21.5-21.0) /acrsectopc(30.,1.9e3) ;Eagle Pillar III
print, (22.5 - 20.6) /acrsectopc(100.,1.9e3) ;Eagle Pillar II
print, 10./acrsectopc(104.,1.9e3) ;Eagle Pillar I
print, 3./acrsectopc(20.,1.9e3) ;Eagle Pillar I



;print, acrsectopc(4.6,520) 
;print, acrsectopc(10.0,1.9e3) 


end
