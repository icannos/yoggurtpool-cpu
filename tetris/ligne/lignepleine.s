jump skiplignepleine:
; verifie si une ligne d'ordonnee y dans r2 est pleine
;il faut push r0 avant d'appeler la fonction, car r0 = 1 ssi ligne non remplie

lignepleine:

push 64 r1
leti r1 BORDG
add2i r1 2 ;r1 est donc dans le premier carre de la grille
leti r0 0

boucle:
cmpi r1 BORDD
jumpif gt boucleend
	push 64 r7
	call graph.estnoir ; a chaque fois il faut que estnoir renvoie un r0 non nul pour que toute la ligne soit remplie
	pop 64 r7
	cmpi r0 0
	jumpif z nonremplie
	add2i r1 4
	leti r0 0
	jump boucle


nonremplie:
leti r0 1

boucleend:

pop 64 r1


return

skiplignepleine:
