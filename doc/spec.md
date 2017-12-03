
## YoggurtPool CPU

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
0x3FFA0464 -->   #===================================#
                 #            Horloge (64 bits)      #
0x3FFA04A4 -->   #===================================#
                 #       284 bits pour le clavier    #
0x3FFA05C0 -->   #===================================#
                 #                                   #
                 #         VRAM(Displayed)           #
                 #                                   #
0x3FFF0600 --->  #===================================#
                 #              Stack                #
                 #===================================#                                                    
```
### Mémoire vidéo
On a déplacé la mémoire vidéo car on a réussi à avoir des programmes long qui commençaient à empiéter dessus. (Lorsque l'on intègre des images).


### Pointeurs
```C
pc = 0;
sp = 1<<30;
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

Actuellement lorsque le simulateur détecte qu'il doit terminer il ajoute affiche le dernier état des registres. (Nous avons ajouté un booléen permettant d'arrêter le cycle de von neuman).



| Call id       |     Mnemonic        |    Desc                                |
| ------------- | ------------------- | ---------------------------------------|
|   ...         |          ...        |              ...                       |
|   ...         |                     |              ...                       |

### Flags et comparaisons

Nous n'avons pas encore implémenté le flag overflow mais ça viendra. Donc certaines comparaisons ne marchent pas encore, celles qui sont nécessaires à la division et à la multiplication marche. (En tous cas celles dont on se sert dans nos programmes.)


### Syntaxe Assembleur

Nous avons ajouté un peu de sucre syntaxique à l'assembleur. Notamment il est maintenant possible de mettre la valeur d'un label dans un registre via les mnemonics `letiac reg label` pour mettre l'adresse absolue du label et `letiaj reg label` pour mettre l'adresse relative du label. C'est noramment utile lors de l'utilisation des `jumpreg` et `jumpifreg`.

De plus la macro `load filename` importe à cet endroit précis un fichier binaire. On peut alors utiliser le code suivant pour faire pointer un pointeur vers ces données:

```Assembly
letiac r0 data
setctr a0 r0

jump dataend
data:
    load filename.mem
dataend:
```

### Statistiques

Nous avons ajouté quelques variables de statistiques dans processor.h, qui comptent notamment les bits échangés avec la ram en lecture ou en écriture. On prévoit de faire générer au simulateur des fichiers de logs à la fin d'une exécution pour récupérer l'état des registres et de la ram ainsi que toutes les statistiques.
