cmake_minimum_required(VERSION 3.2)

project("ADBSDL")

file(GLOB_RECURSE sdltest_SOURCES "src/*.cpp")
file(GLOB_RECURSE sdltest_HEADERS "src/*.h")

include_directories(
	include
)

add_executable(ADBSDL ${sdltest_SOURCES})

target_link_libraries(
	ADBSDL
	${CMAKE_CURRENT_SOURCE_DIR}/lib/sdl2/sdl2.lib 
	${CMAKE_CURRENT_SOURCE_DIR}/lib/sdl_ttf/SDL2_ttf.lib
)
