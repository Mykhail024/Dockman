pragma Singleton
import QtQuick

QtObject {
    id: typography

    // ==================== Font Families ====================
    readonly property string fontSans: "Geist" // Primary UI font
    readonly property string fontSansFallback: "Inter, -apple-system, BlinkMacSystemFont, Segoe UI, sans-serif" // Sans fallback
    readonly property string fontMono: "Geist Mono" // Code/terminal font
    readonly property string fontMonoFallback: "JetBrains Mono, Fira Code, Consolas, monospace" // Mono fallback

    // ==================== Font Sizes ====================
    readonly property int sizeXs: 10 // Extra small text
    readonly property int sizeSm: 12 // Small text
    readonly property int sizeBase: 14 // Base text size
    readonly property int sizeMd: 16 // Medium text
    readonly property int sizeLg: 18 // Large text
    readonly property int sizeXl: 20 // Extra large text
    readonly property int size2xl: 24 // Heading 2
    readonly property int size3xl: 30 // Heading 1
    readonly property int size4xl: 36 // Display heading

    // ==================== Font Weights ====================
    readonly property int weightNormal: 400 // Normal weight
    readonly property int weightMedium: 500 // Medium weight
    readonly property int weightSemibold: 600 // Semibold weight
    readonly property int weightBold: 700 // Bold weight

    // ==================== Line Heights ====================
    readonly property real lineHeightTight: 1.25 // Tight line height
    readonly property real lineHeightNormal: 1.5 // Normal line height
    readonly property real lineHeightRelaxed: 1.625 // Relaxed line height
    readonly property real lineHeightLoose: 2.0 // Loose line height

    // ==================== Letter Spacing ====================
    readonly property real trackingTighter: -0.05 // Tighter tracking (em)
    readonly property real trackingTight: -0.025 // Tight tracking (em)
    readonly property real trackingNormal: 0 // Normal tracking (em)
    readonly property real trackingWide: 0.025 // Wide tracking (em)
    readonly property real trackingWider: 0.05 // Wider tracking (em)
}
