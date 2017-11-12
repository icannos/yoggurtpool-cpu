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
### Installation / Compilation

Il est recommandé d'utiliser CMake. 

1. Créer un dossier `build/` dans le projet
2. Exécuter à l'intérieur `cmake ../`
3. L'éxécutable se trouvera dans build/simu.src sous la forme de simu.exe

La méthode orginelle doit encore exister mais on ne l'a jamais testée.

### Simulateur

Nous avons un peu amélioré la sortie de débuggage pour afficher les données en hexa mais aussi en décimal etc...

### Documentation
 
Toute la documentation nécessaire se trouve dans le dossier `doc/`


### Dans ce rendu:

#### Multiplication

La multiplication effectue le calcul r0 * r1 dans r2.

#### Division

La division s'effectue de r0 divisé par r1 dans r3 et le reste se trouvera dans r0.

#### memory.s 

C'est un teste d'écriture lecture dans la ram pour vérifier que tout marche à peu près bien. (Pas utile pour ce rendu mais fonctionne quand même.
