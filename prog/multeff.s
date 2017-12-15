jump callmultendend
mult:
    push 64 r0
    push 64 r1
    push 64 r5
    push 64 r6
    letiac r5 callmultend
    letiac r6 boucle
boucle:
    cmpi r0 0

    jumpifreg eq r5
    shift right r0 1
        
    jumpif nc pair
    add2 r2 r1
        
pair:
    shift left  r1 1

    jumpreg r5
    
callmultend:

    pop 64 r6
    pop 64 r5
    pop 64 r1
    pop 64 r0

    return
    
callmultendend:

