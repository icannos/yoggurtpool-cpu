jump effetreplskip
; ça va effacer et remplacer par la ligne du dessus la ligne d'ordonnee r2
effetrepl:

push 64 r0
push 64 r1
push 64 r2
push 64 r3
push 64 r4




; on recopie
leti r1 BORDG

	bouclex:
	cmpi r1 BORDD
	jumpif z finbouclex ; on a interet a avoir BORDD congru a BORDG modulo 4, sinon boucle infinie
	add2i r2 1 ;on remonte pour piquer la couleur d'au dessus
	push 64 r7
	call graph.estnoir
	pop 64 r7
	sub2i r2 1
	push 64 r7
	sub2i r1 2
	.carreauto
	add2i r1 2
	pop 64 r7
	add2i r1 4
	jump bouclex
	finbouclex:

;enlever la ligne d'au dessus
leti r0 0
leti r1 BORDG
leti r3 BORDD
add2i r2 1
let r4 r2
add2i r4 4
push 64 r7
call graph.fill
pop 64 r7


pop 64 r4
pop 64 r3
pop 64 r2
pop 64 r1
pop 64 r0

return

effetreplskip:
