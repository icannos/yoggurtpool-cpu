jump skipcollicote
; renvoie si on peut tourner la piece ou pas, en gardant le point en a gauche comme reference
; on regarde donc si les points plus a droite sont colores on non
; on met dans r5 le sens de rotation
;il faut push r0 avant !
collicote:

push 64 r1
add2i r1 5 ;
push 64 r5
leti r5 0 ; r5 contiendra la somme des couleurs des points a tester, r5 =0 ssi pas de collision

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
		jump end

	basei:
		add2i r1 12
		call estnoir
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
		add2i r1 8
		call estnoir
		add2 r5 r0

		jump end
		
	rotdl:

		jump end

	invl:
		add2i r1 8
		call estnoir
		add2 r5 r0

		jump end

	rotgl:

		jump end

o: ; cas d'une forme de carre
;cas unique

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

		jump end

	rotdt:
		add2i r1 8
		call estnoir
		add2 r5 r0

		jump end

	invt:

		jump end

	rotgt:
		add2i r1 8
		call estnoir
		add2 r5 r0

		jump end


end:
let r0 r5
pop 64 r5
pop 64 r2

return

skipcollicote:
