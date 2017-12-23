#define BORDG 50
#define BORDD 150
#define UNIT 4

#include <graph.sl>
#include <time.s>
#include <debut.s>
#include <ligne.sl>

call debut.debut

;r0 va garder la couleur de la piece mais sert souvent de booleen
;r1 va garder l'abscisse de gauche de la pièce
;r2 va garder l'ordonnee du haut de la pièce
;r3 va garder sa forme
;r4 va garder son orientation
;r5 va garder le score
;r6 sert de drapeau pour demander une nouvelle piece

;le jeu continue tant que la ligne du haut est non vide

partie:
call ligne.lignevide
cmpi r0 0
jumpif z findepartie

;gestion de la piece

;on l'efface
push 64 r0
leti r0 0
call brique

push 64 r5 ; r5 va servir de drapeau pour savoir s'il y a une collision horizontale
;inserer l'action du joueur ici
call keyboard.waitkey
	;si le joueur n'a pas apppuye
	cmpi r0 -1
	jumpif z suite
	cmpi r0 7 ;veut on décaler la pièce à droite ?
	jumpif nz ndroite
		call collicote
		cmpi r5 0
		jumpif nz imp1
		add2i r1 4	
		imp1:
	ndroite:
	cmpi r0 20
	jumpif nz ngauche
		cmpi r1 BORDG
	ngauche:

suite:
pop 64 r5 ; retour du score dans r5

pop 64 r0

push 64 r0
call collision
pop 64 r0

add2i r2 4 ;on descend la pièce
call brique ;on redessine la pièce en dessous

;on regarde si on a besoin d'une nouvelle piece
	cmpi r6 0
	jumpif nz partie ;si on n'a pas de collision c'est reparti pour un cycle
	;sinon
	;gestion de la grille
	call ligne.majligne
	;creation d'une nouvelle piece
	call nouvelle
	leti r6 1 ; on remet le drapeau en attente
	jump partie 
	

jump partie


findepartie:

jump -13
