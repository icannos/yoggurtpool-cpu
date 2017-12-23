jump skipcollicote
; renvoie si on peut tourner la piece ou pas, en gardant le point en a gauche comme reference
; on regarde donc si les points plus a droite sont colores on non
;il faut push r0 avant !
collicote:

push 64 r1
add2i r1 5 ;
push 64 r5
leti r5 0 ; r5 contiendra la somme des couleurs des points a tester, r5 =0 ssi pas de collision

skipcollicote:
