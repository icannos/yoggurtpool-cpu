jump drawend

cmp r1 r2
jumpif lt pasechange
let r5 r1
let r1 r2
let r2 r5
let r5 r3
let r3 r4
let r4 r5


pasechange:

sub3 r6 r3 r1
let r5 r6
shift left r5 1
sub2 r4 r2
shift left r4 1
call plot


boucle:
cmp r1 r3
jumpif ge fin
add2i r1 1
sub2 r6 r5
cmpi r6 0
jumpif ge chgmtpixel
add2i r2 1
add2 r6 r5
chgmtpixel:
call plot
jump boucle
fin:
drawend:
