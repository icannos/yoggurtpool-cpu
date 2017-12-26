;#include <graph.sl>
;#include <time.s>

jump skipdebut

debut:

push 64 r7
.char 65535 20 100 Bienvenue
.char 65535 90 100 dans
.char 65535 50 70 TETRIS

leti r0 5
push 64 r7
call time.time
pop 64 r7

leti r0 0
push 64 r7
call graph.clear_screen
pop 64 r7
.char 65535 5 100 SCORE

.draw 31 13 70 13 30 ; dessin de la jauge
.draw 31 13 30 19 30
.draw 31 19 70 19 30

.carreauto 992 80 50
.fill 65535 45 128 50 0
.fill 65535 50 5 150 0
.fill 65535 150 128 155 0
pop 64 r7

return

skipdebut:
