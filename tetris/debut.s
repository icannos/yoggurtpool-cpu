#include <graph.sl>
#include <time.s>

; .char 65535 20 100 Bienvenue
; .char 65535 80 100 dans
; .char 65535 50 70 T
leti r0 10
; call time.time
leti r0 0
call graph.clear_screen
.char 65565 10 100 MAXIME
; .char 992 20 60 0
.fill 65535 50 128 55 0
.fill 65535 55 5 145 0
.fill 65535 145 128 150 0
jump -13

