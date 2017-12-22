leti r0 25
leti r1 4
call div
jump -13


jump skipdiv
div:
    push 64 r0
    push 64 r1

loopback:
    cmp r1 r0
    jumpif ge loopend
    shift left r1 1
    jump loopback
loopend:

boucle:
    cmp r3 r1
    jumpif ge end
    shift right r1 1
    shift left r2 1
    cmp r0 r1
    jumpif lt cond2
	sub2 r0 r1
	add2i r2 1
cond2:
    jump boucle
end:
    shift right r2 1
    let r3 r0
    
    pop 64 r1
    pop 64 r0
    return
skipdiv:


