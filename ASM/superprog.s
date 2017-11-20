leti r0 5
leti r3 1072703332
setctr a1 r3 
write a1 8 r0 
leti r0 1072703332
setctr a1 r0 
readze a1 8 r0 
let r1 r0 
leti r0 8

cmp r1 r0 
jumpif ge #elseok35b01bc8c22266
leti r0 1 
jump #ifok35b01bc8c22266
elseok35b01bc8c22266:
leti r0 0 
ifok35b01bc8c22266:
cmpi r0 1 
jumpif neq #ifelse35b01bc8c22190
leti r0 3
jump #ifend35b01bc8c22190
ifelse35b01bc8c22190: 
leti r0 89
ifend35b01bc8c22190: 
jump -13
