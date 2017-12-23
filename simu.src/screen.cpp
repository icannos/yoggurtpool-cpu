#include "screen.h"


void simulate_screen(Memory *m, bool *refresh) {
    /*initialise sdl and create the screen*/
    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window *window = SDL_CreateWindow("Asm", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, WIDTH * 2, HEIGHT * 2,
                                          0);
    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, 0);
    SDL_Texture *texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STATIC, WIDTH,
                                             HEIGHT);
    SDL_Event e;
    Uint32 last_time = SDL_GetTicks();
    SDL_RenderSetScale(renderer, 2, 2);
    bool escape = false;
    /*temp buffer*/
    uint32_t tempscreen[WIDTH * HEIGHT];

    while (!escape) {

        //Update Clock

        double time =  ( ((double) clock()) / (CLOCKS_PER_SEC));

        m->m[CLOCK_BEGIN  >> 6] = (uint64_t) time;

        /*deal with events*/
        while (SDL_PollEvent(&e) != 0) { // S'il se passe qqchose

            if (e.type == SDL_QUIT) {
                escape = true;
            } else {
                if (e.type ==
                    SDL_KEYDOWN) { // Si le qqchose c'est appuyer su une touche on met le bit de la mémoire à 1

                    if (e.key.keysym.scancode <= 283)
                        m->m[((KEYBOARD_BEGIN + e.key.keysym.scancode)) >> 6] =
                                (1 << (63 - (KEYBOARD_BEGIN + e.key.keysym.scancode % 64))) |
                                m->m[((KEYBOARD_BEGIN + e.key.keysym.scancode)) >> 6];
                } else if (e.type == SDL_KEYUP) // Si le qqchose c'est relacher: bah on met à 0
                {
                    if (e.key.keysym.scancode <= 283)
                        m->m[((KEYBOARD_BEGIN + e.key.keysym.scancode)) >> 6] =
                                (~(1 << (63 - (KEYBOARD_BEGIN + e.key.keysym.scancode % 64)))) &
                                m->m[((KEYBOARD_BEGIN + e.key.keysym.scancode)) >> 6];;
                }
            }
        }
        /* if we need to refresh the screen*/
        if (true) {
            /* convert the colors */
            // i is a counter of 16-bit words
            for (unsigned int i = 0; i < HEIGHT * WIDTH; i++) {
                uint64_t mword = m->m[(MEM_SCREEN_BEGIN >> 6) + (i >> 2)];
                uint16_t pixel = (mword >> ((63-16) - (i & 3) << 4)) & 0xffff;

                uint32_t blue = pixel & ((1 << 5) - 1); // 5 bits
                uint32_t green = (pixel >> 5) & ((1 << 5) - 1); // 5 bits
                uint32_t red = (pixel >> 10); // 6 bits

                tempscreen[i] = (red << (3 + 16)) + (green << (3 + 8)) + (blue << 3);
            }
            /* update the screen */
            SDL_UpdateTexture(texture, NULL, tempscreen, WIDTH * sizeof(uint32_t));
            SDL_RenderClear(renderer);
            SDL_RenderCopy(renderer, texture, NULL, NULL);
            SDL_RenderPresent(renderer);
            /* wait */
            Uint32 current = SDL_GetTicks();
            if (current - last_time < (1000.f * 1.f / 60.f)) {
                SDL_Delay((1000.f * 1.f / 60.f) - last_time + current);
            }
            //refresh = false;
            last_time = current;
        }
    }
    /* close the screen properly */
    //refr = false;
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
}


