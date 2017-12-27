#define BORDG 50
#define BORDD 150
#define UNIT 4


#define BLEU 31
#define JAUNE 65523
#define VERT 992
#define ROUGE 64512
#define KEYBOARD_BEGIN 1073349796

#include <keyboard.s>
#include <graph.sl>
#include <time.s>
#include <debut.s>
#include <ligne.sl>
#include <nouvelle.s>
#include <brique.s>
#include <collision.s>
#include <collicote.s>



;; Musique:

#define AUDIO_CTRL 0x3FF9F77E
#define PTR_FILE 0x3FF9F780
#define BEGIN_QUEUE 0x3FF9F7C0

call lockaudio
leti r0 4172
call beep
leti r0 2119
call beep
leti r0 2120
call beep
leti r0 4170
call beep
leti r0 2120
call beep
leti r0 2119
call beep
leti r0 2117
call beep
leti r0 2117
call beep
leti r0 2120
call beep
leti r0 2124
call beep
leti r0 2122
call beep
leti r0 2120
call beep
leti r0 2119
call beep
leti r0 2120
call beep
leti r0 4170
call beep
leti r0 4172
call beep
leti r0 4168
call beep
leti r0 2629
call beep
leti r0 3653
call beep
leti r0 2122
call beep
leti r0 2125
call beep
leti r0 2129
call beep
leti r0 2127
call beep
leti r0 2125
call beep
leti r0 588
call beep
leti r0 2120
call beep
leti r0 2124
call beep
leti r0 2122
call beep
leti r0 2120
call beep
leti r0 2119
call beep
leti r0 2120
call beep
leti r0 4170
call beep
leti r0 4172
call beep
leti r0 4168
call beep
leti r0 2117
call beep
leti r0 581
call beep
call unlockaudioloop

leti r7 0
leti r0 0
leti r1 0
leti r2 0
leti r3 0
leti r4 0
leti r5 0
leti r6 0

;; Fin musique

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
	leti r0 2
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
	add2i r1 4
	findroite:

	cmpi r0 80 ; pour aller a gauche
	jumpif nz fingauche
	cmpi r1 54
	jumpif slt fingauche
	sub2i r1 4
	fingauche:

	cmpi r0 81 ;on tourne à droite
	jumpif nz fintour
	cmpi r4 4
	jumpif z vaut4
	add2i r4 1
	jump fintour
	vaut4:
	leti r4 0
	fintour:

	cmpi r0 82
	jumpif nz fintourbis
	cmpi r4 0
	jumpif z vaut0
	sub2i r4 1
	jump fintourbis
	vaut0:
	leti r4 4
	fintourbis:

	suite:
	pop 64 r0

	;si on est reste il faut descendre la piece
	sub2i r2 UNIT ;on descend la pièce
	push 64 r7
	call brique.brique ;on redessine la pièce en dessous
	pop 64 r7

	push 64 r0
	leti r0 2
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

jump endmusicfile



lockaudio:
; Stop audio play and go back at the begining of the queue.
  push 64 r0
  push 64 r1

  leti r0 PTR_FILE
  setctr a0 r0
  leti r0 BEGIN_QUEUE
  write a0 64 r0

  leti r0 AUDIO_CTRL
  setctr a0 r0

  leti r1 0
  write a0 1 r1
  leti r1 0
  write a0 1 r1

  pop 64 r1
  pop 64 r0

  return


unlockaudio:
; Start Playing
  push 64 r0
  push 64 r1

  leti r0 AUDIO_CTRL
  setctr a0 r0

  leti r1 0
  write a0 1 r1
  leti r1 1
  write a0 1 r1

  pop 64 r1
  pop 64 r0

  return


unlockaudioloop:
; Start Playing
  push 64 r0
  push 64 r1

  leti r0 AUDIO_CTRL
  setctr a0 r0

  leti r1 1
  write a0 1 r1
  leti r1 0
  write a0 1 r1


  pop 64 r1
  pop 64 r0

  return


beep:
    push 64 r1
    push 64 r2
		push 64 r3


; On regarde ou en est la file
    leti r3 PTR_FILE
    setctr a0 r3
    readze a0 64 r1
; On se place au bon endroit
    setctr a0 r1
; On ecrit la note
    write a0 16 r0

; On met le ptr de file au bon endroit
    getctr a0 r1
    setctr a0 r3
    write a0 64 r1

		pop 64 r3
    pop 64 r2
    pop 64 r1

    return

endmusicfile:
