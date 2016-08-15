#include <SDL.h>

#include <stdlib.h>
//#include <time.h>
#include <iostream>

//#ifdef _WIN32
//#define _WIN32_WINNT 0x500
#include <windows.h>
//#endif

//#include "Arduboy.h"
/*
#ifdef linux

#endif
*/

// Check if WIDTH or HEIGHT has been defined
#ifndef WIDTH
#define WIDTH 124
#endif
#ifndef HEIGHT
#define HEIGHT 64
#endif

struct ABDSDL {
    SDL_Renderer* renderer;
} ABDSDL;

// Entry point for application
int main (int argc, char *argv[])
{
    // Windows
    HWND consoleWindow = GetConsoleWindow();

    SDL_Window *window;     // pointer to window
    //SDL_Renderer *renderer; // pointer to renderer

    SDL_Init(SDL_INIT_VIDEO);
    SDL_Init(SDL_INIT_AUDIO);

    // Implemented in the future, requires library
    //TTF_Init();

    window = SDL_CreateWindow(
            "Arduboy SDL",
            SDL_WINDOWPOS_UNDEFINED,
            SDL_WINDOWPOS_UNDEFINED,
            WIDTH,
            HEIGHT,
            0
            );

    /*
     * SDL_RENDER_ACCELERATED not defined in miniGW
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDER_ACCELERATED | 
            SDL_RENDERER_TARGETTEXTURE);
    */

    ABDSDL.renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_TARGETTEXTURE);

    // Check if window has been created
    if (!window)
        return 1;


    // Main application loop
    for (;;)
    {
        SDL_Event e;

        // Poll events
        if (SDL_PollEvent(&e))
        {
            if (e.type == SDL_QUIT)
                break;
        }
    }

    SDL_DestroyRenderer(ABDSDL.renderer);
    SDL_DestroyWindow(window);

    SDL_Quit();

    return 0;
}
