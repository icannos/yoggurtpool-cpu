

include_directories(${CMAKE_CURRENT_SOURCE_DIR})


# includes cmake/FindSDL2.cmake
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

find_package(SDL2 REQUIRED)
include_directories(${SDL2_INCLUDE_DIR})

set(SOURCE_FILES 
    main.cpp
    processor.cpp
    memory.cpp
    screen.cpp
    
    
    )

add_executable(SDL2_App ${SOURCE_FILES})
target_link_libraries(SDL2_App ${SDL2_LIBRARY})
