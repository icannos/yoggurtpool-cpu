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
- simu.src -- Les sources du simulateur
- tetris -- Une implémentation de Tetris avec sa musique
- doc -- La documentation et les remarques concernant le processeur
- statistiques -- des tests et statistiques effectuées sur quelques uns de nos programmes
- utils -- Quelques scripts/sauvegardes utilitaires

### Installation / Compilation

##### Dépendances:
- CMake
- SDL2
- Tatsu (Uniquement pour le compilateur python): `sudo pip install tatsu` réglera le problème.

##### Compilation

- `./build_all.sh` dans le dossier racine compilera le simulateur, créera le dossier build etc...
- `./build_prog.sh` recompilera uniquement les programmes du dossier prog
- `./demo_r2.sh` exécutera une démo minimale du rendu 2: Un teaser pour le rendu 3.

La méthode orginelle doit encore exister mais on ne l'a jamais testée.

### Simulateur

J'ai apporté des modifications à la manière dont le simulateur gère l'écriture dans la RAM pour corriger des problèmes graphiques. A priori maintenant le lien entre l'écran et la RAM se fait beaucoup mieux. On évite par exemple le problème des couleurs mirroires que l'on rencontrait jusqu'à présent.

Nous avons un peu amélioré la sortie de débuggage pour afficher les données en hexa mais aussi en décimal etc...

#### Documentation

Toute la documentation nécessaire ainsi que les remarques se trouvent dans le dossier `doc/`
