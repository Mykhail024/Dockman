pragma Singleton
import QtQuick

QtObject {
    id: dimensions

    // ==================== Icon Sizes ====================
    readonly property int iconXs: 12 // Extra small icons
    readonly property int iconSm: 16 // Small icons
    readonly property int iconMd: 20 // Medium icons
    readonly property int iconLg: 24 // Large icons
    readonly property int iconXl: 32 // Extra large icons
    readonly property int icon2xl: 48 // 2x large icons

    // ==================== Button Heights ====================
    readonly property int buttonXs: 24 // Extra small button
    readonly property int buttonSm: 32 // Small button
    readonly property int buttonMd: 36 // Medium button (default)
    readonly property int buttonLg: 44 // Large button
    readonly property int buttonXl: 52 // Extra large button

    // ==================== Input Heights ====================
    readonly property int inputSm: 32 // Small input
    readonly property int inputMd: 40 // Medium input (default)
    readonly property int inputLg: 48 // Large input

    // ==================== Layout Dimensions ====================
    readonly property int sidebarWidth: 256 // Sidebar width
    readonly property int sidebarCollapsed: 64 // Collapsed sidebar width
    readonly property int headerHeight: 56 // Header height
    readonly property int footerHeight: 48 // Footer height
    readonly property int toolbarHeight: 44 // Toolbar height

    // ==================== Modal Dimensions ====================
    readonly property int modalSm: 400 // Small modal width
    readonly property int modalMd: 560 // Medium modal width
    readonly property int modalLg: 720 // Large modal width
    readonly property int modalXl: 900 // Extra large modal width

    // ==================== Container Max Widths ====================
    readonly property int containerSm: 640 // Small container
    readonly property int containerMd: 768 // Medium container
    readonly property int containerLg: 1024 // Large container
    readonly property int containerXl: 1280 // Extra large container
    readonly property int container2xl: 1536 // 2x large container
}
