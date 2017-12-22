leti r0 1073350080
leti r3 1072703332
setctr a1 r3 
write a1 64 r0 
leti r0 31
leti r3 1072703332
setctr a1 r3 
readze a1 64 r3 
setctr a1 r3 
write a1 16 r0 
leti r0 12
leti r3 1072703396
setctr a1 r3 
write a1 8 r0 
leti r0 1072703396
setctr a1 r0 
readse a1 8 r0 
let r1 r0 
leti r0 8

cmp r1 r0 
jumpif neq elseok35c8c656b099c8
leti r0 1 
jump   ifok35c8c656b099c8
elseok35c8c656b099c8:
leti r0 0 
ifok35c8c656b099c8:
cmpi r0 1 
jumpif neq   ifelse35c8c656b097ea
leti r0 6
leti r3 1072703396
setctr a1 r3 
write a1 8 r0 
jump   ifend35c8c656b097ea
ifelse35c8c656b097ea: 
ifend35c8c656b097ea: 
jump   funendmafunction: 
funbeginmafunction: 
leti r0 1072703404
setctr a1 r0 
readse a1 8 r0 
let r1 r0 
leti r0 6

cmp r1 r0 
jumpif neq elseok35c8c656b09d98
leti r0 1 
jump   ifok35c8c656b09d98
elseok35c8c656b09d98:
leti r0 0 
ifok35c8c656b09d98:
cmpi r0 1 
jumpif neq   ifelse35c8c656b09c88
leti r0 5
jump   ifend35c8c656b09c88
ifelse35c8c656b09c88: 
leti r0 12
ifend35c8c656b09c88: 
return 
funendmafunction: 
call    funbeginmafunction
