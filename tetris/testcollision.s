#include <graph.sl>
#include <collision.s>
#include <ligne.sl>
#include <brique.s>

#define BORDG 50
#define BORDD 150
#define UNIT 4



;.fill 65535 0 6 150 0
leti r0 31

leti r2 111

leti r1 5
leti r3 0
leti r4 0
leti r6 0

descente:
;sert a gere la descente d'une piece, elle s'arrete en cas de collision

	push 64 r0
	push 64 r7
	call collision.collision
	pop 64 r7
	pop 64 r0

	cmpi r6 0
	jumpif nz fin
	leti r6 0 ;r6 est nul si et seulement s'il n'y a aucune collision

	;on l'efface
	push 64 r0 ;on sauvegarde donc la couleur avant de mettre du noir
	leti r0 0
	push 64 r7
	call brique.brique
	pop 64 r7
	pop 64 r0 ; on remet la bonne couleur



	;si on est reste il faut descendre la piece
	sub2i r2 UNIT ;on descend la pièce
	push 64 r7
	call brique.brique ;on redessine la pièce en dessous
	pop 64 r7

	jump descente

fin:
jump -13