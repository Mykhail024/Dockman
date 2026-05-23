find_package(Qt6 REQUIRED COMPONENTS
  Core
  Gui
  QuickControls2
  LinguistTools
  Multimedia
  Protobuf
  Grpc
  Network
)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)
set(QT_QML_GENERATE_QMLLS_INI ON)
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)

qt_add_executable(dockman
  main.cpp
)

add_subdirectory(presentation)

target_link_libraries(dockman PRIVATE
    common
    dockman_presentationplugin
    Qt6::Core
    Qt6::QuickControls2
    Qt6::Multimedia
    Qt6::Protobuf
    Qt6::Grpc
    Qt6::Network
)

configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/qmlls.ini.in
  ${CMAKE_SOURCE_DIR}/.qmlls.ini
)

if(NOT ANDROID)
set_target_properties(dockman PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/client/bin
    OUTPUT_NAME "dockman"
  )
  install(TARGETS dockman
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  )
endif()

qt_import_qml_plugins(dockman)

#     DEPENDS ${CMAKE_BINARY_DIR}/src/android-build/dockman.apk
# 	)
# endif()
