add_subdirectory(theme)

set(QML_FILES
    #root
    Main.qml

    components/StyledSwitch.qml
    components/BorderBox.qml
    components/BorderProperties.qml
    components/TabButton.qml
    components/HostListItem.qml
)

set(SRC_FILES
    src/UrlOpener.cpp
)

set(INCLUDE_FILES
    include/dockman/UrlOpener.h
)

qt_add_qml_module(dockman_presentation
    STATIC
    VERSION 1.0
    URI "Dockman.Presentation"
    QML_FILES
        ${QML_FILES}
    SOURCES
        ${SRC_FILES}
        ${INCLUDE_FILES}
    IMPORTS "Dockman.Theme"
    NO_GENERATE_EXTRA_QMLDIRS
)

target_include_directories(dockman_presentation PUBLIC
  include
  include/dockman
)

target_link_libraries(dockman_presentation PRIVATE
  dockman-theme
  Qt6::Gui
  Qt6::QuickControls2
  Qt6::Core
)
