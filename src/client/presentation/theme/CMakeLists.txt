set_source_files_properties(
    Colors.qml
    Typography.qml
    Spacing.qml
    Borders.qml
    Shadows.qml
    Opacity.qml
    Transitions.qml
    ZIndex.qml
    Dimensions.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(dockman-theme
    STATIC
    URI "Dockman.Theme"
    VERSION 1.0
    QML_FILES
        Colors.qml
        Typography.qml
        Spacing.qml
        Borders.qml
        Shadows.qml
        Opacity.qml
        Transitions.qml
        ZIndex.qml
        Dimensions.qml
    NO_GENERATE_EXTRA_QMLDIRS
)

target_link_libraries(dockman-theme PRIVATE Qt6::Quick)
