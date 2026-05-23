pragma Singleton
import QtQuick

QtObject {
    id: spacing

    // ==================== Spacing Scale ====================
    readonly property int space0: 0 // No spacing
    readonly property int space1: 4 // 4px - Minimal spacing
    readonly property int space2: 8 // 8px - Small spacing
    readonly property int space3: 12 // 12px - Standard small
    readonly property int space4: 16 // 16px - Base spacing
    readonly property int space5: 20 // 20px - Medium small
    readonly property int space6: 24 // 24px - Medium spacing
    readonly property int space8: 32 // 32px - Large spacing
    readonly property int space10: 40 // 40px - Extra large
    readonly property int space12: 48 // 48px - 2x large
    readonly property int space16: 64 // 64px - Section spacing
    readonly property int space20: 80 // 80px - Large section
    readonly property int space24: 96 // 96px - Extra large section

    // ==================== Gap Shortcuts ====================
    readonly property int gapXs: space1 // Extra small gap
    readonly property int gapSm: space2 // Small gap
    readonly property int gapMd: space4 // Medium gap
    readonly property int gapLg: space6 // Large gap
    readonly property int gapXl: space8 // Extra large gap

    // ==================== Padding Shortcuts ====================
    readonly property int paddingXs: space1 // Extra small padding
    readonly property int paddingSm: space2 // Small padding
    readonly property int paddingMd: space4 // Medium padding
    readonly property int paddingLg: space6 // Large padding
    readonly property int paddingXl: space8 // Extra large padding

    // ==================== Margin Shortcuts ====================
    readonly property int marginXs: space1 // Extra small margin
    readonly property int marginSm: space2 // Small margin
    readonly property int marginMd: space4 // Medium margin
    readonly property int marginLg: space6 // Large margin
    readonly property int marginXl: space8 // Extra large margin
}
