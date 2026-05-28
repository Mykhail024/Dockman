add_subdirectory(theme)

set(QML_FILES
    #root
    Main.qml
)

set(SRC_FILES
    src/url_opener.cpp
)

set(INCLUDE_FILES
    include/url_opener.h
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

target_include_directories(dockman_presentation PUBLIC include)

target_link_libraries(dockman_presentation PRIVATE
  dockman-theme
  Qt6::Gui
  Qt6::QuickControls2
  Qt6::Core
)
