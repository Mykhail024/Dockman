pragma Singleton
import QtQuick

QtObject {
    id: shadows

    // ==================== Shadow Definitions ====================
    readonly property string none: "none" // No shadow
    readonly property string sm: "0 1px 2px 0 rgba(0, 0, 0, 0.4)" // Small shadow
    readonly property string base: "0 1px 3px 0 rgba(0, 0, 0, 0.5), 0 1px 2px -1px rgba(0, 0, 0, 0.5)" // Default shadow
    readonly property string md: "0 4px 6px -1px rgba(0, 0, 0, 0.5), 0 2px 4px -2px rgba(0, 0, 0, 0.5)" // Medium shadow
    readonly property string lg: "0 10px 15px -3px rgba(0, 0, 0, 0.5), 0 4px 6px -4px rgba(0, 0, 0, 0.5)" // Large shadow
    readonly property string xl: "0 20px 25px -5px rgba(0, 0, 0, 0.5), 0 8px 10px -6px rgba(0, 0, 0, 0.5)" // Extra large shadow
    readonly property string xxl: "0 25px 50px -12px rgba(0, 0, 0, 0.6)" // 2x extra large shadow
    readonly property string inner: "inset 0 2px 4px 0 rgba(0, 0, 0, 0.3)" // Inner shadow

    // ==================== Glow Effects ====================
    readonly property string glowPrimary: "0 0 20px rgba(45, 212, 167, 0.3)" // Primary color glow
    readonly property string glowError: "0 0 20px rgba(220, 38, 38, 0.3)" // Error color glow
}
