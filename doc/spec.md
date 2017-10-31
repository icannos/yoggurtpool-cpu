
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


### Conditions

Les conditions offertes dans l'ISA initiale ne permettent pas de réaliser des tests sur la valeur du flag carry uniquement. Donc nous avons décidé de nous séparer des conditions redondantes lt et le (110,111) pour les remplacer par des conditions plus utiles.

| Code          |     Mnemonic    |    Desc        |
| ------------- | -------------   | ------------   |
|   110         |       c         |  Test carry=1  |
|   111         |                 |    A voir      |


### Instructions Maison


| OpCode        |     Mnemonic        |    Desc                                |
| ------------- | ------------------- | ---------------------------------------|
|   0x7d        |   jumpreg reg       |  Jump relatif à la valeur du registre  |
|   0x7e        | jumpifreg cond reg  |  Jump cond à la valeur du registre     |
