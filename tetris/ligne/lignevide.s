jump skiplignevide:
; verifie si la ligne du haut est vide
;il faut push r0 avant d'appeler la fonction, car r0 = 0 ssi ligne non vide

lignevide:

push 64 r1
leti r1 BORDG
add2i r1 2 ;r1 est donc dans le premier carre de la grille

boucle:
cmpi r1 BORDD
jumpif gt boucleend
	call graph.estnoir
	cmpi r0 0
	jumpif nz nonvide
	add2i r1 4
	jump boucle
	

nonvide:
leti r0 1
boucleend: 

pop 64 r1


return

skiplignevide:
