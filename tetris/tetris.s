#define BORDG 50
#define BORDD 150
#define UNIT 4


#define BLEU 31
#define JAUNE 65523
#define VERT 992
#define ROUGE 64512
#define KEYBOARD_BEGIN 1073349796

#include <graph.sl>
#include <time.s>
#include <debut.s>
#include <ligne.sl>
#include <nouvelle.s>
#include <brique.s>
#include <collision.s>
#include <collicote.s>
#include <keyboard.s>

push 64 r7
call debut.debut
pop 64 r7



leti r0 1
leti r1 0
leti r2 0
leti r3 0
leti r4 0
leti r5 30; c'est la ou commence la jauge
leti r6 0 ;petite astuce pour creer une piece au premier tour



;on commence la partie en mettant une piece
	push 64 r7
	call nouvelle.nouvelle
	pop 64 r7
	push 64 r7
	call brique.brique
	pop 64 r7

	push 64 r0
	leti r0 1
	push 64 r7
	call time.time
	pop 64 r7
	pop 64 r0
	jump descente

descente:
;sert a gere la descente d'une piece, elle s'arrete en cas de collision

	push 64 r0
	push 64 r7
	call collision.collision
	pop 64 r7
	pop 64 r0

	cmpi r6 0
	jumpif nz atraiter
	leti r6 0 ;r6 est nul si et seulement s'il n'y a aucune collision

	;on l'efface
	push 64 r0 ;on sauvegarde donc la couleur avant de mettre du noir
	leti r0 0
	push 64 r7
	call brique.brique
	pop 64 r7
	pop 64 r0 ; on remet la bonne couleur

	;attention on introduit l'action du joueur ! si on decommente c'est l'echec

	push 64 r0
	push 64 r7
	call keyboard.waitkey
	pop 64 r7
	cmpi r0 -1
	jumpif z suite

	cmpi r0 79 ;pour aller a droite
	jumpif nz findroite
	add2i r1 1
	findroite:

	cmpi r0 80 ; pour aller a gauche
	jumpif nz fingauche
	sub2i r1 1
	fingauche:

	;cmpi r0 81 ;on tourne à droite


;79	0x04F	SDL_SCANCODE_RIGHT
;80	0x050	SDL_SCANCODE_LEFT
;81	0x051	SDL_SCANCODE_DOWN
;82	0x052	SDL_SCANCODE_U


	suite:
	pop 64 r0

	;si on est reste il faut descendre la piece
	sub2i r2 UNIT ;on descend la pièce
	push 64 r7
	call brique.brique ;on redessine la pièce en dessous
	pop 64 r7

	push 64 r0
	leti r0 1
	push 64 r7
	call time.time
	pop 64 r7
	pop 64 r0
	jump descente


atraiter: ;on a eu une collision

	;est ce la fin du jeu
	push 64 r0
	push 64 r7
	call ligne.lignevide
	pop 64 r7
	cmpi r0 0
	jumpif nz findepartie
	pop 64 r0

	;sinon la partie continue
	;on regarde si les lignes sont à jour
	push 64 r7
	call ligne.majligne
	pop 64 r7
	;on cree une nouvelle pièce
	push 64 r7
	call nouvelle.nouvelle
	pop 64 r7
	push 64 r7
	call brique.brique
	pop 64 r7
	jump descente





findepartie:
jump -13
