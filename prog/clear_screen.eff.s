
jump clear_screen_end
clear_screen:
    leti r1 1073350080
    setctr a0 r1
    
    letiac r5 boucle
    letiac r6 fin
boucle:
    cmpi r1 1073677760
    jumpifreg ge r6
    write a0 16 r0
    getctr a0 r1
    jumpreg r5
fin:
    return
clear_screen_end:
