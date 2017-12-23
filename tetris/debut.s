;#include <graph.sl>
;#include <time.s>

jump skipdebut

;.char 65535 20 100 Bienvenue
;.char 65535 80 100 dans
;.char 65535 50 70 T
leti r0 10000
call time.time
leti r0 0
call graph.clear_screen
.char 65535 5 100 SCORE
.char 992 18 60 0
.carre 992 80 50
.fill 65535 45 128 50 0
.fill 65535 50 5 150 0
.fill 65535 150 128 155 0

return

skipdebut:

