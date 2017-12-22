
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
                 #               Data                #
                 #                                   #
                 #                                   #
                 #===================================#
0x3FF9F780 -->   #             file ptr(audio)       #
0x3FF9F7C0 -->   #===================================#
                 #                                   #
                 #               Audio               #
                 #                                   #
1073349696 -->   #===================================#
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


### Audio

Nous avons implémenté un buffer audio dans la ram qui débute à partir de `MEM_AUDIO_BEGIN+128` et qui a une taille de 200(notes) * 16 bits.
De `MEM_AUDIO_BEGIN` à `MEM_AUDIO_BEGIN+63` est stocké le ptr de file. Si on le met à 0 le player s'arrête et se replace au début de la file.
On file des notes avec la librairie `audiolib` créée pour l'occasion.

Une note est représentée par 7 bits de hauteur et 8 bits de durée. A l'adresse `MEM_AUDIO_BEGIN+64` on trouve une indication sur le tempo à suivre. On utilie l'encodage des notes MIDI pour la hauteur (Cela devrait permettre de plus facilemet créer un convertisseur: midi -> assembly).

#### Références Code notes/rythmes/Commandes


|  File ptr     |      Action         |
| ------------- | ------------------- |
|     0         |     Audio lock      |
|     1         |      Loop           |

| n°rythme      |       rythme        |
| ------------- | ------------------- |
|     0         |     RETOUR          |
|     1         |     Noire           |
|     2         |     Blanche         |
|     3         |     Ronde           |
|     4         |     Croche          |
|     5         |     Double Croche   |
|     6         |     Triple Croche   |
|     7         |     Noire           |


```
MIDI                   MIDI                   MIDI
 Note     Frequency      Note   Frequency       Note   Frequency
 C1  0    8.1757989156    12    16.3515978313    24    32.7031956626
 Db  1    8.6619572180    13    17.3239144361    25    34.6478288721
 D   2    9.1770239974    14    18.3540479948    26    36.7080959897
 Eb  3    9.7227182413    15    19.4454364826    27    38.8908729653
 E   4   10.3008611535    16    20.6017223071    28    41.2034446141
 F   5   10.9133822323    17    21.8267644646    29    43.6535289291
 Gb  6   11.5623257097    18    23.1246514195    30    46.2493028390
 G   7   12.2498573744    19    24.4997147489    31    48.9994294977
 Ab  8   12.9782717994    20    25.9565435987    32    51.9130871975
 A   9   13.7500000000    21    27.5000000000    33    55.0000000000
 Bb  10  14.5676175474    22    29.1352350949    34    58.2704701898
 B   11  15.4338531643    23    30.8677063285    35    61.7354126570

 C4  36  65.4063913251    48   130.8127826503    60   261.6255653006
 Db  37  69.2956577442    49   138.5913154884    61   277.1826309769
 D   38  73.4161919794    50   146.8323839587    62   293.6647679174
 Eb  39  77.7817459305    51   155.5634918610    63   311.1269837221
 E   40  82.4068892282    52   164.8137784564    64   329.6275569129
 F   41  87.3070578583    53   174.6141157165    65   349.2282314330
 Gb  42  92.4986056779    54   184.9972113558    66   369.9944227116
 G   43  97.9988589954    55   195.9977179909    67   391.9954359817
 Ab  44  103.8261743950   56   207.6523487900    68   415.3046975799
 A   45  110.0000000000   57   220.0000000000    69   440.0000000000
 Bb  46  116.5409403795   58   233.0818807590    70   466.1637615181
 B   47  123.4708253140   59   246.9416506281    71   493.8833012561

 C7  72  523.2511306012   84  1046.5022612024    96  2093.0045224048
 Db  73  554.3652619537   85  1108.7305239075    97  2217.4610478150
 D   74  587.3295358348   86  1174.6590716696    98  2349.3181433393
 Eb  75  622.2539674442   87  1244.5079348883    99  2489.0158697766
 E   76  659.2551138257   88  1318.5102276515   100  2637.0204553030
 F   77  698.4564628660   89  1396.9129257320   101  2793.8258514640
 Gb  78  739.9888454233   90  1479.9776908465   102  2959.9553816931
 G   79  783.9908719635   91  1567.9817439270   103  3135.9634878540
 Ab  80  830.6093951599   92  1661.2187903198   104  3322.4375806396
 A   81  880.0000000000   93  1760.0000000000   105  3520.0000000000
 Bb  82  932.3275230362   94  1864.6550460724   106  3729.3100921447
 B   83  987.7666025122   95  1975.5332050245   107  3951.0664100490

 C10 108 4186.0090448096  120  8372.0180896192
 Db  109 4434.9220956300  121  8869.8441912599
 D   110 4698.6362866785  122  9397.2725733570
 Eb  111 4978.0317395533  123  9956.0634791066
 E   112 5274.0409106059  124 10548.0818212118
 F   113 5587.6517029281  125 11175.3034058561
 Gb  114 5919.9107633862  126 11839.8215267723
 G   115 6271.9269757080  127 12543.8539514160
 Ab  116 6644.8751612791
 A   117 7040.0000000000
 Bb  118 7458.6201842894
 B   119 7902.1328200980

```


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
