leti r1 0
leti r2 0
leti r0 54


leti r1 1073350080
setctr a0 r1
boucle:
cmpi r1 1073677760
jumpif ge #fin
write a0 16 r0
getctr a0 r1
jump #boucle
fin:
jump -13
