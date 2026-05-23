pragma Singleton
import QtQuick

QtObject {
    id: zIndex

    // ==================== Z-Index Layers ====================
    readonly property int base: 0 // Base layer
    readonly property int raised: 10 // Slightly raised elements
    readonly property int dropdown: 50 // Dropdown menus
    readonly property int sticky: 100 // Sticky elements
    readonly property int overlay: 150 // Overlay backgrounds
    readonly property int modal: 200 // Modal dialogs
    readonly property int popover: 300 // Popovers
    readonly property int tooltip: 400 // Tooltips
    readonly property int toast: 500 // Toast notifications
    readonly property int max: 9999 // Maximum z-index
}
