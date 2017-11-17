#ifndef H_SCREEN
#define H_SCREEN

#include <cstdint>

//constants about the environnement
const int WIDTH = 160;
const int HEIGHT = 128;

const uint64_t MEM_SCREEN_BEGIN = 1073350080;

const uint64_t KEYBOARD_BEGIN = 0x3FFA04A4;
const uint64_t CLOCK_BEGIN = 0x3FFA0464;


#include <SDL2/SDL.h>
#include "memory.h"
#include <ctime>


/* this is the function that runs in the screen thread
 * m -> the simulator's memory
 * force_quit -> shared variable to detect if we must close the screen
 * refresh -> shared variable that instructs the thread to refresh the screen
 */
void simulate_screen(Memory* m, bool *refresh);

#endif
