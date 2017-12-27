jump skipcollision
;determine s'il y a collison avec l'environnement pour une forme donnee
;entree point en haut a gauche de la forme, la forme et l'orientation
;sortie r6 est nul si et seulement s'il n'y a aucune collision

;il faut inclure estnoir !

collision:

push 64 r0
push 64 r1
push 64 r2
push 64 r5
sub2i r2 5 ; on testera toujours le pixel d'en dessous le carre, donc 4+1 pixels plus bas

;pour chaque forme et orientation il faut verifier les points de collision specifique


leti r5 0 ; r6 contiendra la somme des couleurs des points a tester, r6 =0 ssi pas de collision
cmpi r3 0
jumpif z i
cmpi r3 1
jumpif z l
cmpi r3 2
jumpif z o
cmpi r3 3
jumpif z t


i: ;cas d'une forme de droite
	;on determine son orientation
	cmpi r4 0
	jumpif z basei
	cmpi r4 1
	jumpif z roti

	roti:
		push 64 r7
		call graph.estnoir
		pop 64 r7
		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		jump end

	basei:
		sub2i r2 12
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		jump end


l: ; cas d'une forme de l
	;on determine son orientation
	cmpi r4 0
	jumpif z basel
	cmpi r4 1
	jumpif z rotdl
	cmpi r4 2
	jumpif z invl
	cmpi r4 3
	jumpif z rotgl

	basel:
		sub2i r2 8
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0

		add2i r2 8
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0


		jump end

	rotdl:
		sub2i r2 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0

		jump end

	invl:
		sub2i r2 8
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0

		jump end

	rotgl:
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		sub2i r2 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0

		jump end

o: ; cas d'une forme de carre
;cas unique


	add2i r1 4
	sub2i r2 4
	push 64 r7
	call graph.estnoir
	pop 64 r7

	add2 r5 r0
	sub2i r1 4
	push 64 r7
	call graph.estnoir
	pop 64 r7

	add2 r5 r0

	jump end

t: ; cas d'une forme de T
	cmpi r4 0
	jumpif z baset
	cmpi r4 1
	jumpif z rotdt
	cmpi r4 2
	jumpif z invt
	cmpi r4 3
	jumpif z rotgt

	baset:
		sub2i r2 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		jump end

	rotdt:
		sub2i r2 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		sub2i r2 4
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0

		jump end

	invt:
		push 64 r7
		call graph.estnoir
		pop 64 r7
		add2 r5 r0

		add2i r1 4
		sub2i r2 4
		push 64 r7
		call graph.estnoir
		pop 64 r7
		add2 r5 r0

		add2i r1 4 ; je ne sais pourquoi avec 4 ça bloque et je pense que c'est non critique
		add2i r2 4
		push 64 r7
		call graph.estnoir
		pop 64 r7
		add2 r5 r0



		jump end

	rotgt:
		sub2i r2 8
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0

		add2i r2 4
		add2i r1 4
		push 64 r7
		call graph.estnoir
		pop 64 r7

		add2 r5 r0
		jump end

end:

let r6 r5

pop 64 r5
pop 64 r2
pop 64 r1
pop 64 r0

return
skipcollision:
