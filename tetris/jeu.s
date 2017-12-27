#define BORDG 50
#define BORDD 150
#define UNIT 4


#define BLEU 31
#define JAUNE 65523
#define VERT 992
#define ROUGE 64512

#include <graph.sl>
#include <time.s>
#include <debut.s>
#include <ligne.sl>
#include <nouvelle.s>
#include <brique.s>
#include <collision.s>
#include <collicote.s>

;push 64 r7
;call debut.debut
;pop 64 r7

;r0 va garder la couleur de la piece mais sert souvent de booleen
;r1 va garder l'abscisse de gauche de la pièce
;r2 va garder l'ordonnee du haut de la pièce
;r3 va garder sa forme
;r4 va garder son orientation
;r5 va garder le score
;r6 sert de drapeau pour demander une nouvelle piece


leti r0 1
leti r1 0
leti r2 0
leti r3 0
leti r4 0
leti r5 30; c'est la ou commence la jauge
leti r6 1 ;petite astuce pour creer une piece au premier tour

partie:

;regarde si on est arrive en haut
push 64 r0
push 64 r7
call ligne.lignevide
pop 64 r7
cmpi r0 0
jumpif nz findepartie
pop 64 r0


;on regarde si on a besoin d'une nouvelle piece
	cmpi r6 0
	jumpif z continue ;si on a une collision la piece precedente ne bouge plus on en prend une nouvelle
	;gestion de la grille car des lignes pourraient etre pleines
	push 64 r7
	call ligne.majligne
	pop 64 r7
	;creation d'une nouvelle piece
	push 64 r7
	call nouvelle.nouvelle
	pop 64 r7
	push 64 r7
	call brique.brique
	pop 64 r7
	leti r6 0 ; on remet le drapeau en attente

push 64 r0
leti r0 3
push 64 r7
call time.time
pop 64 r7
pop 64 r0

continue:
;gestion de la piece

;on l'efface
push 64 r0 ;on sauvegarde donc la couleur avant de mettre du noir
leti r0 0
push 64 r7
call brique.brique
pop 64 r7
pop 64 r0 ; on remet la bonne couleur

push 64 r0
leti r0 2
push 64  r7
call time.time
pop 64 r7
pop 64 r0


push 64 r6 ; r6 va servir de drapeau pour savoir s'il y a une collision horizontale
;inserer l'action du joueur ici
;push 64 r7
;call keyboard.waitkey
;pop 64 r7
	;si le joueur n'a pas apppuye
;	cmpi r0 -1
;	jumpif z suite
	;on gere tous les mouvements possibles, a gauche c'est gentil a droite c'est chiant comme dans la vraie vie
;	cmpi r0 7 ;veut on décaler la pièce à droite ?
;	jumpif nz ndroite
;		add2i r1 UNIT
;		push 64 r7
;		call collision.collision
;		pop 64 r7
;		cmpi r6 0 ; si en décalant on collisionne
;		jumpif z imp1
;		sub2i r1 UNIT
;		imp1:
;	ndroite:
;	cmpi r0 20
;	jumpif nz ngauche
;		cmpi r1 BORDG
;		jumpif z imp2
;		sub2i r1 UNIT
;		imp2:
;	ngauche:
;	cmpi r0 22
;	jumpif nz nrotd
;		;mettre a jour l'orientation
;		cmpi r4 UNIT
;		jumpif z vaut4
;		add2i r4 1
;		jump dif4
;		vaut4:
;		leti r4 0
;		dif4:
;		push 64 r7
;		call collicote.collicote
;		pop 64 r7
;		cmpi r6 0
;		jumpif z possible
;		cmpi r4 0
;		jumpif z vaut0
;		sub2i r4 1
;		jump dif0
;		vaut0:
;		leti r4 UNIT
;		dif0:
;		possible:
;	nrotd:
;	cmpi r0 29
;	jumpif nz nrotg
;		;mettre a jour l'orientation copier coller inverse du précédent
;		cmpi r4 0
;		jumpif z vaut0bis
;		sub2i r4 1
;		jump dif0bis
;		vaut0bis:
;		leti r4 UNIT
;		dif0bis:
;		push 64 r7
;		call collicote.collicote
;		pop 64 r7
;		cmpi r6 0
;		cmpi r4 UNIT
;		jumpif z vaut4bis
;		add2i r4 1
;		jump dif4bis
;		vaut4bis:
;		leti r4 0
;		dif4bis:
;	nrotg:
;
;suite:
pop 64 r6 ; retour du drapeau dans r6




push 64 r0
push 64 r7
call collision.collision ; la reponse est envoyee dans r6 et sera traitee au prochain tour
pop 64 r7
pop 64 r0



sub2i r2 UNIT ;on descend la pièce
push 64 r7
call brique.brique ;on redessine la pièce en dessous
pop 64 r7

leti r6 0
jump partie


findepartie:

jump -13
