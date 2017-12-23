jump skiplignepleine:
; verifie si une ligne d'ordonnee y dans r2 est pleine
;il faut push r0 avant d'appeler la fonction, car r0 = 0 ssi ligne non remplie

lignepleine:

push 64 r1
leti r1 BORDG
add2i r1 2 ;r1 est donc dans le premier carre de la grille

boucle:
cmpi r1 BORDD
jumpif gt boucleend
	call estnoir
	cmpi r0 0
	jumpif z nonremplie
	add2i r1 4
	jump boucle
	

nonremplie:

boucleend: 
leti r0 1
pop 64 r1


return

skiplignepleine:
