leti r0 31 ;couleur
leti r1 0 ;x1
leti r2 0 ;y1
leti r3 100 ;x2
leti r4 50  ;y2

call draw
jump -13

jump drawend
draw:
;mettons les points dans le bon sens
cmp r1 r3
jumpif lt echange
let r5 r1
let r1 r3
let r3 r5
let r5 r2
let r2 r4
let r4 r5
echange:


;ceci prepare le premier point
sub3 r6 r3 r1 
let r5 r6 ;r6 contient e
shift left r5 1 ;r5 contient dx
sub2 r4 r2
shift left r4 1 ;r4 contient dy
push 64 r1
push 64 r2
push 64 r3
push 64 r7
call plot
pop 64 r7
pop 64 r3
pop 64 r2
pop 64 r1

cmpi r4 0
jumpif sgt negatif

boucle:
cmp r1 r3
jumpif ge fin
add2i r1 1
sub2 r6 r4
cmpi r6 0
jumpif sgt chgmtpixel
add2i r2 1
add2 r6 r5
chgmtpixel:
push 64 r1
push 64 r2
push 64 r3
push 64 r7
call plot
pop 64 r7
pop 64 r3
pop 64 r2
pop 64 r1
jump boucle
fin:
return
drawend:

negatif:
;a completer

jump plotend
plot:
leti r3 1073350080
sub2i r2 127
shift left r2 9
sub2 r3 r2
shift left r2 2
sub2 r3 r2
shift left r1 4
add2 r3 r1
setctr a0 r3
write a0 16 r0
return
plotend:

