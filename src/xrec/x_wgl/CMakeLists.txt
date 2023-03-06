message(STATUS "(EC) Generating x_wgl Makefile")

add_definitions(-DX_WGL)

file(GLOB C_FILES  *.c)
file(GLOB F_FILES  *.f)

add_library (x_wgl STATIC ${F_FILES} ${C_FILES})
target_include_directories(x_wgl PRIVATE ${CMAKE_SOURCE_DIR}/src/xrec/include)
target_link_libraries(x_wgl PRIVATE X11::X11 rmn)
get_target_property(x11_interface_include_dir X11::X11 INTERFACE_INCLUDE_DIRECTORIES)
target_compile_options(x_wgl PRIVATE -Wno-error=implicit-function-declaration)
message(STATUS "X11::X11 INTERFACE_INCLUDE_DIRECTORIES = ${x11_interface_include_dir}")
message(STATUS "X11_INCLUDE_DIR=${X11_INCLUDE_DIR}")
target_include_directories(x_wgl PRIVATE ${X11_INCLUDE_DIR})
