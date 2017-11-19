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
jumpif ge #elseok35af840057f5b8
leti r0 1 
jump #ifok35af840057f5b8
elseok35af840057f5b8:
leti r0 0 
ifok35af840057f5b8:
cmpi r0 1 
jumpif neq #ifelse35af840057f4e6
leti r0 3
jump #ifend35af840057f4e6
ifelse35af840057f4e6: 
leti r0 89
ifend35af840057f4e6: 
