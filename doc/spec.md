
## YogurtPool CPU

Tout ce qui est présenté dans la doc n'est pas encore nécessairement implémenté mais ça viendra.


### Memory
```
 0     ------>   #===================================#
                 #                                   #
                 #              Code                 #
                 #                                   #
                 #===================================#
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
0x3FFA05C0 -->   #===================================#
                 #                                   #
                 #         VRAM(Displayed)           #
                 #                                   #
0x3FFF0600 --->  #===================================#
                 #              Stack                #
                 #===================================#                                                    
```
### Mémoire vidéo
On a déplacé la mémoire vidéo car on a réussi à avoir des programmes long qui commençaient à empiéter dessus.


### Pointeurs
```C
pc = 0;
sp = 0x3FFF0600;
A0 = 0;
A1 = 0;
```

### Instructions Maison


| OpCode        |     Mnemonic        |    Desc                                |
| ------------- | ------------------- | ---------------------------------------|
|   0x7d        |   jumpreg reg       |  Jump relatif à la valeur du registre  |
|   0x7e        | jumpifreg cond reg  |  Jump cond à la valeur du registre     |


### Addresse de call négatives

Dans le cas où on effectue un call avec une adresse négative on appelle une fonction "built-in" du proco.

En particulier call -1 correspond à la terminaison d'un programme. Dans ce cas le processeur affiche dans la console son état final. (On le retirera au profit d'un détecteur de boucle infini.) Mais on garde la possibilité d'étendre le jeu d'Instructions de cette manière (reset, instruction pour la vidéo, le clavier, l'horloge).



| Call id       |     Mnemonic        |    Desc                                |
| ------------- | ------------------- | ---------------------------------------|
|   -1          |          ...        |  Indique au proco la terminaison       |
|   ...         |                     |              ...                       |


### Syntaxe Assembleur

La syntaxe des labels est la suivante: `label:` pour déclarer un label puis `#label` lorsqu'on souhaite l'utiliser dans jump (saut relatif) ou `@label` lorsqu'on l'utilise dans un call (saut absolu).

Exemple de la multiplication.
```
leti r0 6
leti r1 -8
leti r2 0
boucle:
cmpi r0 0
jumpif eq #end
shift right r0 1
jumpif nc #pair
add2 r2 r1
pair:
shift left  r1 1
jump #boucle
end:
call -1
```
