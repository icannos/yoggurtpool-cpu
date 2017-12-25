leti r0 10
leti r1 10

call mult

jump -13

jump callmultendend
mult:
    push 64 r0
    push 64 r1

boucle:
    cmpi r0 0
    jumpif eq callmultend
    shift right r0 1

    jumpif nc pair
    add2 r2 r1

pair:
    shift left  r1 1

    jump boucle

callmultend:

    pop 64 r1
    pop 64 r0

    return

callmultendend:
