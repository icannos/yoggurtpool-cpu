
## YogurtPool CPU




### Memory
```
 0     ------>   #===================================#
                 #                                   #
                 #              Code                 #
                 #                                   #
0x10000 ----->   #===================================#
                 #                                   #
                 #         VRAM(Displayed)           #
                 #                                   #
0x60000 ----->   #===================================#
                 #                                   #
                 #                                   #
                 #                                   #
                 #                                   #
                 #                                   #
                 #               Data                #
                 #                                   #
                 #                                   #
                 #                                   #
                 #                                   #
                 #                                   #
                 #                                   #
                 #                                   #
0x3FFF0600 --->  #===================================#
                 #              Stack                #
                 #===================================#                                                    
```

### Pointeurs
A voir si on offre la possibilité de les changer.
```C
pc = 0;
sp = 0x3FFF0600;
A0 = DATA;
A1 = DATA;
```

### Instructions Maison


| OpCode        |     Mnemonic        |    Desc                                |
| ------------- | ------------------- | ---------------------------------------|
|   0x7d        |   jumpreg reg       |  Jump relatif à la valeur du registre  |
|   0x7e        | jumpifreg cond reg  |  Jump cond à la valeur du registre     |


### Addresse de call négatives

Dans le cas où on effectue un call avec une adresse négative on appelle une fonction "built-in" du proco.

En particulier call -1 correspond à la terminaison d'un programme. Dans ce cas le processeur affiche dans la console son état final.



| Call id       |     Mnemonic        |    Desc                                |
| ------------- | ------------------- | ---------------------------------------|
|   -1          |   Term, return0     |  Indique au proco la terminaison       |
|   ...         |                     |                                        |
