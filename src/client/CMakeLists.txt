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

qt_standard_project_setup(REQUIRES 6.11)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)
set(QT_QML_GENERATE_QMLLS_INI ON)
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)

qt_add_executable(dockman
  ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp

  ${CMAKE_CURRENT_SOURCE_DIR}/src/DockmanApp.cpp
  ${INCLUDE_DIR}/DockmanApp.h

  ${INCLUDE_DIR}/Host.h

  ${CMAKE_CURRENT_SOURCE_DIR}/src/HostListModel.cpp
  ${INCLUDE_DIR}/HostListModel.h

  ${INCLUDE_DIR}/HostStorage.h
  ${CMAKE_CURRENT_SOURCE_DIR}/src/HostStorage.cpp

  ${CMAKE_SOURCE_DIR}/resources/resources.qrc
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

target_include_directories(dockman PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

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
