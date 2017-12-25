#include <graph.sl>
#include <collision.s>

leti r3 0
leti r4 0
leti r1 50
leti r2 50
leti r6 12
;.fill 31 0 0 100 100
push 64 r7
call collision.collision
pop 64 r7
jump -13
