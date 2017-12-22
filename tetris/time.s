jump skiptime
;attend une duree r0
time:
	push 64 r1
	push 64 r2
	push 64 r3

; Lire la date à partir de laquelle on attend
	leti r2 0x3FFA0464
	setctr a0 r2
	readze a0 64 r1
; Jusqu'à quand on attend
	add2 r1 r0
boucle:
; Quel est le temps actuel
	setctr a0 r2
	readze a0 64 r3
; Comparaison du temps actuel avec la date jusqu'à laquelle on attend
	cmp r1 r3
	jumpif sgt boucle
	


pop 64 r1
pop 64 r2
pop 64 r3
return


skiptime:
