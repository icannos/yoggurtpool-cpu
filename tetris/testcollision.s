#include <graph.sl>
#include <collision.s>
#include <ligne.sl>
#include <brique.s>

#define BORDG 50
#define BORDD 150
#define UNIT 4



leti r0 14
leti r3 2
leti r4 0
leti r1 70
leti r2 100
leti r6 12

push 64 r7
call brique.brique
pop 64 r7

push 64 r7
call collision.collision
pop 64 r7




jump -13