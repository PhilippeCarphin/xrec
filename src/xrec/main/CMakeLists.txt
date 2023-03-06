message(STATUS "(EC) Generating xrec Makefile")

#set(EXTRA_LIBRARIES "-lXt -lSM -lICE -lXext -lX11 -lz -lm -ldl -ljpeg")

add_executable(${PROJECT_NAME} rec.f)

set(FULL_PROJECT_NAME ${PROJECT_NAME}_${PROJECT_VERSION})
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${FULL_PROJECT_NAME})

# add_dependencies(${PROJECT_NAME} rec rec_util wgl gd_wgl x_wgl gdb gd png ${rmn_SRC})
message("MOTIF_LIBRARIES = ${MOTIF_LIBRARIES}")
target_link_libraries(${PROJECT_NAME} PRIVATE rec rec_util wgl gd_wgl x_wgl gdb gd png rmn ${EXTRA_LIBRARIES} X11::X11 ${MOTIF_LIBRARIES})
target_link_options(${PROJECT_NAME} PRIVATE -undefined dynamic_lookup)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   # Symbolic link to latest build
   COMMAND ln -sfv $<TARGET_FILE_NAME:${PROJECT_NAME}> xrec
)

install(TARGETS ${PROJECT_NAME})
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/xrec DESTINATION bin)
