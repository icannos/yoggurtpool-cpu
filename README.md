```
__   __                           _    ______           _   _____ ______ _   _
\ \ / /                          | |   | ___ \         | | /  __ \| ___ \ | | |
 \ V /___   __ _  __ _ _   _ _ __| |_  | |_/ /__   ___ | | | /  \/| |_/ / | | |
  \ // _ \ / _` |/ _` | | | | '__| __| |  __/ _ \ / _ \| | | |    |  __/| | | |
  | | (_) | (_| | (_| | |_| | |  | |_  | | | (_) | (_) | | | \__/\| |   | |_| |
  \_/\___/ \__, |\__, |\__,_|_|   \__| \_|  \___/ \___/|_|  \____/\_|    \___/
            __/ | __/ |                                                        
           |___/ |___/                                                         

 _____    _          _              _____                 ___  ___           _                 ______
|  ___|  | |        (_)            /  __ \       ___      |  \/  |          (_)                |  _  \
| |__  __| |_      ___  __ _  ___  | /  \/      ( _ )     | .  . | __ ___  ___ _ __ ___   ___  | | | |
|  __|/ _` \ \ /\ / / |/ _` |/ _ \ | |          / _ \/\   | |\/| |/ _` \ \/ / | '_ ` _ \ / _ \ | | | |
| |__| (_| |\ V  V /| | (_| |  __/ | \__/\_    | (_>  <   | |  | | (_| |>  <| | | | | | |  __/ | |/ /
\____/\__,_| \_/\_/ |_|\__, |\___|  \____(_)    \___/\/   \_|  |_/\__,_/_/\_\_|_| |_| |_|\___| |___(_)
                        __/ |                                                                         
                       |___/                                                                          

```
### Description du dossier

- prog -- Contient tous les programmes du rendu
  - audio -- Librairie audio
  - graph -- librairie graphique
  - keyboard -- librairie de gestion du clavier
  - time -- librairie gestion de l'horloge
- compiler -- Contient l'asm, le compilateur et les scripts de conversion de musiques/images
- max -- contient quelques demonstrations du langage max
- simu.src -- Les sources du simulateur
- tetris -- Une implémentation de Tetris avec sa musique
- doc -- La documentation et les remarques concernant le processeur
- statistiques -- des tests et statistiques effectuées sur quelques uns de nos programmes
- utils -- Quelques scripts/sauvegardes utilitaires

#### Documentation

Toute la documentation nécessaire ainsi que les remarques se trouvent dans le dossier `doc/`

### Installation / Compilation

##### Dépendances:
- CMake
- SDL2
- Tatsu (Uniquement pour le compilateur python): `sudo pip install tatsu` réglera le problème.

##### Compilation

- `./build_all.sh` dans le dossier racine compilera le simulateur, créera le dossier build, compilera l'ensemble des programmes de `prop/` ainsi que le tetris.
- `build_maxdemo.sh` compilera à l'aide Tatsu s'il est installé les programmes max et mettra dans `bin/` les fichiers .obj.
- `./build_prog.sh` recompilera uniquement les programmes du dossier prog

##### Demos & tests

Nous souhaitons vivement que vous testiez les demonstrations suivantes, automatiquement générées après avoir exécuté les 2 premiers fichiers bash ci-dessus. En exécutant les fichiers bash `./demo_tetris.sh`, `./demo_edwige.sh` et enfin si vous avez installé Tatsu: `./demo_ptr` (Difficile de voir ce qu'il se passe: il y a seulement un point bleu en haut à gauche, je vous invite à lire le fichier correspondant dans le dossier max.)

### Simulateur

J'ai apporté des modifications à la manière dont le simulateur gère l'écriture dans la RAM pour corriger des problèmes graphiques. A priori maintenant le lien entre l'écran et la RAM se fait beaucoup mieux. On évite par exemple le problème des couleurs mirroires que l'on rencontrait jusqu'à présent.

Nous avons un peu amélioré la sortie de débuggage pour afficher les données en hexa mais aussi en décimal etc...




### Tetris

#### Déroulement du jeu
Une nouvelle pièce de couleur, de forme et d'orientation aléatoire est tirée à chaque fois que la pièce précédente est arrivée à sa position définitive. Lorsque les pièces arrivent en haut de l'écran, le jeu s'arrête. Lorsqu'une ligne est remplie, elle s'efface et fait augmenter le niveau de la jauge de score sur la gauche.

#### Commandes
La pièce se décale selon les touches suivantes :
- LEFT pour décaler la pièce sur la gauche
- RIGHT pour décaler la pièce sur la droite
- UP pour la faire tourner vers la droite
- DOWN pour la faire tourner vers la gauche


#### Problèmes non résolus
Il s'est avéré complexe de gérer les collisions horizontales. Notre rendu ne les détecte pas, on peut donc manger des pièces avec d'autres si on les bouge sur le côté au dernier moment. Concernant les bordures, celle de gauche est bien une limite infranchissable. En revanche, il faut aller éroder celle de droite pour remplir la ligne complètement sur la droite. Un décalage supplémentaire sur la droite bloque alors la pièce dans la bordure.
