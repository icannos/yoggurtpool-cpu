
#include <brique.s>
#include <graph.sl>
#include <debut.s>
#include <time.s>
#include <nouvelle.s>
#include <ligne.sl>
#include <collision.s>


#define BORDG 50
#define BORDD 150
#define UNIT 4


#define BLEU 31
#define JAUNE 65523
#define VERT 992
#define ROUGE 64512

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

push 64 r0
leti r0 0
push 64 r7
call brique.brique
pop 64 r7
pop 64 r0

push 64 r0
push 64 r7
call collision.collision ; la reponse est envoyee dans r6 et sera traitee au prochain tour
pop 64 r7
pop 64 r0

sub2i r2 UNIT ;on descend la pièce
push 64 r7
call brique.brique ;on redessine la pièce en dessous
pop 64 r7



jump -13
