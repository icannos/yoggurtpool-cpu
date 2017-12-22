
jump clear_screen.eff.clear_screen_end
clear_screen:
leti r1 1073350080 
setctr a0 r1 

letiac r5 clear_screen.eff.boucle
letiac r6 clear_screen.eff.fin
clear_screen.eff.boucle:
cmpi r1 1073677760 
jumpifreg ge r6 
write a0 16 r0 
getctr a0 r1 
jumpreg r5 
clear_screen.eff.fin:
return 
clear_screen.eff.clear_screen_end:

jump draw.drawend
draw:

push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r4 
push 64 r5 
push 64 r6 


cmp r1 r3 
jumpif lt draw.echange
let r5 r1 
let r1 r3 
let r3 r5 
let r5 r2 
let r2 r4 
let r4 r5 
draw.echange:


sub3 r5 r3 r1 
shift left r5 1 
sub3 r6 r4 r2 
shift left r6 1 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r7 
call plot
pop 64 r7 
pop 64 r3 
pop 64 r2 
pop 64 r1 


cmpi r6 0 
jumpif slt draw.negatif
cmp r5 r6 
jumpif slt draw.grandepente



let r4 r6 
sub3 r6 r3 r1 

draw.boucle:
cmp r1 r3 
jumpif ge draw.fin
add2i r1 1 
sub2 r6 r4 
cmpi r6 0 
jumpif sgt draw.chgmtpixel
add2i r2 1 
add2 r6 r5 
draw.chgmtpixel:
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r7 
call plot
pop 64 r7 
pop 64 r3 
pop 64 r2 
pop 64 r1 
jump draw.boucle
draw.fin:

pop 64 r6 
pop 64 r5 
pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

return 
draw.drawend:

draw.grandepente:

let r3 r5 
let r5 r6 
sub3 r6 r4 r2 


draw.bouclebis:
cmp r2 r4 
jumpif ge draw.finbis
add2i r2 1 
sub2 r6 r3 
cmpi r6 0 
jumpif sgt draw.chgmtpixelbis
add2i r1 1 
add2 r6 r5 
draw.chgmtpixelbis:
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r7 
call plot
pop 64 r7 
pop 64 r3 
pop 64 r2 
pop 64 r1 
jump draw.bouclebis
draw.finbis:
pop 64 r6 
pop 64 r5 
pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

return 


draw.negatif:
push 64 r0 
leti r0 0 
sub2 r0 r6 
cmp r5 r0 
jumpif slt draw.grandepentebis
pop 64 r0 

let r4 r6 
sub3 r6 r3 r1 

draw.boucleter:
cmp r1 r3 
jumpif ge draw.finter
add2i r1 1 
add2 r6 r4 
cmpi r6 0 
jumpif sgt draw.chgmtpixelter
sub2i r2 1 
add2 r6 r5 
draw.chgmtpixelter:
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r7 
call plot
pop 64 r7 
pop 64 r3 
pop 64 r2 
pop 64 r1 
jump draw.boucleter
draw.finter:
pop 64 r6 
pop 64 r5 
pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

return 



draw.grandepentebis:
pop 64 r0 

let r3 r5 
let r5 r6 
sub3 r6 r4 r2 
draw.bouclequater:
cmp r4 r2 
jumpif ge draw.finquater
sub2i r2 1 
add2 r6 r3 
cmpi r6 0 
jumpif slt draw.chgmtpixelquater
add2i r1 1 
add2 r6 r5 
draw.chgmtpixelquater:
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r7 
call plot
pop 64 r7 
pop 64 r3 
pop 64 r2 
pop 64 r1 
jump draw.bouclequater
draw.finquater:
pop 64 r6 
pop 64 r5 
pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

return 

jump draw.plotend
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
draw.plotend:



jump fill.fillskipfill
fill:
push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r4 
push 64 r5 
push 64 r6 


cmp r1 r3 
jumpif lt fill.fillechange
let r5 r1 
let r1 r3 
let r3 r5 
fill.fillechange:



cmp r2 r4 
jumpif gt fill.fillechangebis
let r5 r2 
let r2 r4 
let r4 r5 
fill.fillechangebis:

sub2 r3 r1 
add2i r3 1 
sub3 r5 r2 r4 
add2i r5 1 
leti r4 160 
sub2 r4 r3 
shift left r4 4 





leti r6 1073350080 
sub2i r2 127 
shift left r2 9 
sub2 r6 r2 
shift left r2 2 
sub2 r6 r2 
shift left r1 4 
add2 r6 r1 
setctr a0 r6 

fill.fillboucley:
cmpi r5 1 
jumpif slt fill.fillfin
sub2i r5 1 

let r1 r3 
fill.fillbouclex:
cmpi r3 1 
jumpif slt fill.fillfinligne
sub2i r3 1 
write a0 16 r0 
jump fill.fillbouclex
fill.fillfinligne:
let r3 r1 

getctr a0 r6 
add2 r6 r4 
setctr a0 r6 

jump fill.fillboucley



fill.fillfin:
pop 64 r6 
pop 64 r5 
pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

return 


fill.fillskipfill:
jump plot.plotend
plot:
push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 

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

pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 
plot.plotend:

jump putchar.skipputchar
putchar:
push 64 r0 
push 64 r1 
push 64 r2 
push 64 r3 
push 64 r4 
push 64 r5 
push 64 r6 
push 64 r7 






add2i r2 8 

leti r4 1073350080 
sub2i r2 127 
shift left r2 9 
sub2 r4 r2 
shift left r2 2 
sub2 r4 r2 
shift left r1 4 
add2 r4 r1 

setctr a0 r4 




letiac r5 putchar.font
shift l r3 6 
add2 r3 r5 

setctr a1 r3 





leti r5 152 
shift l r5 4 






leti r1 0 

putchar.boucle_carac_line_back:
cmpi r1 7 
jumpif sgt putchar.boucle_carac_line
call putchar.putlc


getctr a0 r2 
add2 r2 r5 
setctr a0 r2 
add2i r1 1 
jump putchar.boucle_carac_line_back
putchar.boucle_carac_line:

pop 64 r7 
pop 64 r6 
pop 64 r5 
pop 64 r4 
pop 64 r3 
pop 64 r2 
pop 64 r1 
pop 64 r0 

return 






putchar.putlc:

push 64 r1 
push 64 r5 
push 64 r6 

readze a1 8 r5 
leti r1 0 

putchar.boucle_carac_pix_back:
cmpi r1 8 
jumpif sgt putchar.boucle_carac_pix_end
shift r r5 1 
jumpif nc putchar.carac_nowrite
write a0 16 r0 
jump putchar.carac_writeend
putchar.carac_nowrite:
getctr a0 r6 
add2i r6 16 
setctr a0 r6 

putchar.carac_writeend:

add2i r1 1 
jump putchar.boucle_carac_pix_back
putchar.boucle_carac_pix_end:


pop 64 r6 
pop 64 r5 
pop 64 r1 

return 




jump putchar.endfont
putchar.font:
load font.mem 
putchar.endfont:

putchar.skipputchar:
['buildlib', 'clear_screen', 'draw', 'fill', 'graph', 'list', 'plot', 'putchar']
