pragma Singleton
import QtQuick

QtObject {
    id: opacity

    // ==================== Opacity Values ====================
    readonly property real transparent: 0.0 // Fully transparent
    readonly property real opacity5: 0.05 // 5% opacity
    readonly property real opacity10: 0.1 // 10% opacity
    readonly property real opacity20: 0.2 // 20% opacity
    readonly property real opacity30: 0.3 // 30% opacity
    readonly property real opacity40: 0.4 // 40% opacity
    readonly property real disabled: 0.5 // Disabled state (50%)
    readonly property real opacity60: 0.6 // 60% opacity
    readonly property real muted: 0.7 // Muted/secondary (70%)
    readonly property real hover: 0.8 // Hover state (80%)
    readonly property real opacity90: 0.9 // 90% opacity
    readonly property real full: 1.0 // Full opacity
}
