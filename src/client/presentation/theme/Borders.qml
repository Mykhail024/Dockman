pragma Singleton
import QtQuick

QtObject {
    id: borders

    // ==================== Border Widths ====================
    readonly property int width0: 0 // No border
    readonly property int width1: 1 // Default border width
    readonly property int width2: 2 // Medium border width
    readonly property int width4: 4 // Thick border width

    // ==================== Border Radius ====================
    readonly property int radiusNone: 0 // No rounding
    readonly property int radiusSm: 4 // Small rounding
    readonly property int radiusMd: 6 // Medium rounding
    readonly property int radiusBase: 8 // Base rounding
    readonly property int radiusLg: 8 // Large rounding
    readonly property int radiusXl: 12 // Extra large rounding
    readonly property int radius2xl: 16 // 2x large rounding
    readonly property int radius3xl: 24 // 3x large rounding
    readonly property int radiusFull: 9999 // Fully rounded (pill)

    // ==================== Scrollbar ====================
    readonly property int scrollbarWidth: 8 // Scrollbar width
    readonly property int scrollbarRadius: 4 // Scrollbar border radius
}
