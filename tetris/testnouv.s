
#include <brique.s>
#include <graph.sl>
#include <time.s>
#include <nouvelle.s>
#include <ligne.sl>
#include <collision.s>


#define BORDG 50
#define BORDD 150
#define UNIT 4


#define BLEU 31
#define JAUNE 62430
#define VERT 992
#define ROUGE 64512

push 64 r7
call ligne.lignevide
pop 64 r7

push 64 r7
call nouvelle.nouvelle
pop 64 r7

push 64 r3
push 64 r4
push 64 r7
call brique.brique
pop 64 r7
pop 64 r4
pop 64 r3

push 64 r7
call collision.collision
pop 64 r7






jump -13
