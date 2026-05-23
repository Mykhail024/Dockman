pragma Singleton
import QtQuick

QtObject {
    id: theme

    // ==================== Sub-modules ====================
    readonly property Colors colors: Colors {}
    readonly property Typography typography: Typography {}
    readonly property Spacing spacing: Spacing {}
    readonly property Borders borders: Borders {}
    readonly property Shadows shadows: Shadows {}
    readonly property Opacity opacity: Opacity {}
    readonly property Transitions transitions: Transitions {}
    readonly property ZIndex zIndex: ZIndex {}
    readonly property Dimensions dimensions: Dimensions {}

    // ==================== Quick Access Aliases ====================
    // Colors - most frequently used
    readonly property color background: colors.background
    readonly property color foreground: colors.foreground
    readonly property color primary: colors.primary
    readonly property color secondary: colors.secondary
    readonly property color accent: colors.accent
    readonly property color muted: colors.muted
    readonly property color border: colors.border
    readonly property color destructive: colors.destructive

    // Typography - most frequently used
    readonly property string fontSans: typography.fontSans
    readonly property string fontMono: typography.fontMono

    // Spacing - most frequently used
    readonly property int space2: spacing.space2
    readonly property int space4: spacing.space4
    readonly property int space6: spacing.space6
    readonly property int space8: spacing.space8

    // Borders - most frequently used
    readonly property int radius: borders.radiusBase
    readonly property int radiusSm: borders.radiusSm
    readonly property int radiusLg: borders.radiusLg
}
