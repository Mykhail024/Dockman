add_executable(dockman_server
  main.cpp
)

target_include_directories(dockman_server PRIVATE
  ${CMAKE_CURRENT_BINARY_DIR}
)

target_link_libraries(dockman_server PRIVATE
  common
)

target_compile_options(dockman_server PRIVATE
  -Wno-error=nullability-extension
)

if(NOT ANDROID)
  set_target_properties(dockman_server PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/server/bin
    OUTPUT_NAME "dockman_server"
  )
  install(TARGETS dockman_server
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  )
endif()
