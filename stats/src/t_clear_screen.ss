leti r0 31
call clear_screen
jump -13

jump clear_screen_end
clear_screen:
    leti r1 1073350080
    setctr a0 r1
boucle:
    cmpi r1 1073677760
    jumpif ge fin
    write a0 16 r0
    getctr a0 r1
    jump boucle
fin:
    return
clear_screen_end:
