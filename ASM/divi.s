leti r0 17 
leti r1 2 
leti r2 0 
let r3 r1 

loopback:
cmp r1 r0
jumpif ge #loopend
shift left r1 1
jump #loopback
loopend:

boucle:
cmp r3 r1
jumpif ge #end
shift right r1 1
shift left r2 1
cmp r0 r1
jumpif lt #cond2
	sub2 r0 r1
	add2i r2 1
cond2:
jump #boucle
end:
shift right r2 1
call -1

