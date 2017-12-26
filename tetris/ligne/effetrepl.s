jump effetreplskip
; ça va effacer et remplacer par la ligne du dessus la ligne d'ordonnee r2
effetrepl:

push 64 r0
push 64 r1
push 64 r2
push 64 r3
push 64 r4

;d'abord on efface
leti r0 0
leti r1 BORDG
;r2 est bien initialise
leti r3 BORDD
sub21 r3 1 ;pour ne pas empieter sur le bord
let r4 r2
sub2i r4 4
push 64 r2
push 64 r7
call graph.fill
pop 64 r7
pop 64 r2



; puis on recopie
leti r1 BORDG

	bouclex:
	cmpi r1 BORDD
	jumpif z finbouclex ; on a interet a avoir BORDD congru a BORDG modulo 4, sinon boucle infinie
	sub2i r2 1 ;on remonte juste d'un pour piquer la couleur d'au dessus
	push 64 r7
	call graph.estnoir
	pop 64 r7
	add2i r2 1
	push 64 r7
	.carreauto
	pop 64 r7
	add2i r1 4
	jump bouclex
	finbouclex:


pop 64 r4
pop 64 r3
pop 64 r2
pop 64 r1
pop 64 r0

return

effetreplskip:
