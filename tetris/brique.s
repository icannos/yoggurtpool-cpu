leti r0 65535
leti r1 5
leti r2 127
leti r3 3
leti r4 1
call brique
jump -13


jump skipbrique:
brique:
#include <graph.sl>
;on determine quelle forme on trace
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
		.carreauto
		add2i r1 4
		.carreauto 
		add2i r1 4
		.carreauto
		add2i r1 4
		.carreauto

		return

	basei:
		.carreauto
		sub2i r2 4
		.carreauto 
		sub2i r2 4
		.carreauto
		sub2i r2 4
		.carreauto

		return

	
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
		.carreauto
		sub2i r2 4
		.carreauto 
		sub2i r2 4
		.carreauto
		add2i r2 8
		add2i r1 4
		.carreauto

		return
		
	rotdl:
		.carreauto
		sub2i r2 4
		.carreauto 
		add2i r1 4
		.carreauto
		add2i r1 4
		.carreauto

		return

	invl:
		add2i r1 4
		.carreauto
		sub2i r2 4
		.carreauto
		sub2i r2 4
		.carreauto
		sub2i r1 4
		.carreauto

		return

	rotgl:
		.carreauto
		add2i r1 4
		.carreauto
		add2i r1 4
		.carreauto
		sub2i r2 4
		.carreauto

		return

o: ; cas d'une forme de carre
;cas unique

	.carreauto
	add2i r1 4
	.carreauto
	sub2i r2 4
	.carreauto
	sub2i r1 4
	.carreauto

	return

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
		add2i r1 4
		.carreauto
		sub2i r2 4
		.carreauto
		sub2i r1 4
		.carreauto
		add2i r1 8
		.carreauto
		return

	rotdt:
		add2i r1 4
		.carreauto
		sub2i r2 4
		.carreauto
		sub2i r1 4
		.carreauto
		add2i r1 4
		sub2i r2 4
		.carreauto

		return
	invt:
		.carreauto
		add2i r1 4
		.carreauto
		add2i r1 4
		.carreauto
		sub2i r1 4
		sub2i r2 4
		.carreauto

		return

	rotgt:
		.carreauto
		sub2i r2 4
		.carreauto
		add2i r1 4
		.carreauto
		sub2i r1 4
		sub2i r2 4
		.carreauto

		return



skipbrique:

