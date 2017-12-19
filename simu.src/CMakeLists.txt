

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

find_package (Threads)

INCLUDE(FindPkgConfig)

PKG_SEARCH_MODULE(SDL2 REQUIRED sdl2)

set(SOURCE_FILES 
    main.cpp
    processor.cpp
    memory.cpp
    screen.cpp


        beeper.cpp beeper.h audio.cpp audio.h)

add_executable(simu.exe ${SOURCE_FILES})




target_link_libraries (simu.exe ${CMAKE_THREAD_LIBS_INIT})

INCLUDE_DIRECTORIES(${SDL2_INCLUDE_DIRS})
TARGET_LINK_LIBRARIES(simu.exe ${SDL2_LIBRARIES})
