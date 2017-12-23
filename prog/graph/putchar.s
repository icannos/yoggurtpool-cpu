
jump skipputchar
putchar:
    push 64 r0
    push 64 r1
    push 64 r2
    push 64 r3
    push 64 r4
    push 64 r5
    push 64 r6
    push 64 r7


    ; ===================================================

    ; On construit l'adresse du pixel en haut a gauche on le met dans r6

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

    ; ===================================================

    ; On construit l'adresse du caractere à lire
    letiac r5 font
    shift l r3 6 ; On multiplie r3 par 64
    add2 r3 r5 ; r3 pointe maintenant vers l'adresse du 1er bit de notre caractere

    setctr a1 r3

    ; ====================================================

    ; On construit le saut à réaliser en fin de ligne dans r5

    leti r5 152
    shift l r5 4


    ; ====================================================

    ; Boucle pour chaque ligne à écrire

    leti r1 0

    boucle_carac_line_back:
    cmpi r1 7
    jumpif sgt boucle_carac_line
        call putlc ; On ecrit une ligne du caractere

        ; On saute de 120 pixels
        getctr a0 r2
        add2 r2 r5 ; On ajoute r5 = 120 * 16 dans r2
        setctr a0 r2
        add2i r1 1
    jump boucle_carac_line_back
    boucle_carac_line:

    pop 64 r7
    pop 64 r6
    pop 64 r5
    pop 64 r4
    pop 64 r3
    pop 64 r2
    pop 64 r1
    pop 64 r0

    return


; ===================================================

; Pour chaque ligne

putlc:

    push 64 r1
    push 64 r5
    push 64 r6

    readze a1 8 r5 ; On lit 8 pixels du caractere ie une ligne
    leti r1 0

    boucle_carac_pix_back:
    cmpi r1 8
    jumpif sgt boucle_carac_pix_end
        shift r r5 1
        jumpif nc carac_nowrite ; Si bit = 1 alors on ecrit
            write a0 16 r0
        jump carac_writeend
        carac_nowrite: ; Sinon on ne fait rien et on déplace juste a0
            getctr a0 r6
            add2i r6 16
            setctr a0 r6

        carac_writeend:

        add2i r1 1
    jump boucle_carac_pix_back
    boucle_carac_pix_end:


    pop 64 r6
    pop 64 r5
    pop 64 r1

    return




jump endfont
font: ; Binary font
    load font.mem
endfont:

skipputchar:
