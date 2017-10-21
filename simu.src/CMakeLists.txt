

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

find_package (Threads)

INCLUDE(FindPkgConfig)

PKG_SEARCH_MODULE(SDL2 REQUIRED sdl2)
PKG_SEARCH_MODULE(SDL2IMAGE REQUIRED SDL2_image>=2.0.0)


set(SOURCE_FILES 
    main.cpp
    processor.cpp
    memory.cpp
    screen.cpp
    
    
    )

add_executable(simu ${SOURCE_FILES})




target_link_libraries (simu ${CMAKE_THREAD_LIBS_INIT})

INCLUDE_DIRECTORIES(${SDL2_INCLUDE_DIRS} ${SDL2IMAGE_INCLUDE_DIRS})
TARGET_LINK_LIBRARIES(simu ${SDL2_LIBRARIES} ${SDL2IMAGE_LIBRARIES})
