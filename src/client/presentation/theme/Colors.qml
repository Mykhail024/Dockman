pragma Singleton
import QtQuick

QtObject {
    id: colors

    // ==================== Base Colors ====================
    readonly property color background: "#0f1014" // Main application background
    readonly property color foreground: "#f0f0f0" // Primary text color
    readonly property color card: "#1a1b20" // Card background
    readonly property color cardForeground: "#f0f0f0" // Card text color
    readonly property color popover: "#1a1b20" // Popover/dropdown background
    readonly property color popoverForeground: "#f0f0f0" // Popover text color

    // ==================== Accent Colors ====================
    readonly property color primary: "#2dd4a7" // Primary accent (teal/green)
    readonly property color primaryForeground: "#0f1014" // Text on primary
    readonly property color secondary: "#26272e" // Secondary background
    readonly property color secondaryForeground: "#d4d4d4" // Text on secondary
    readonly property color accent: "#2dd4a7" // Accent color
    readonly property color accentForeground: "#0f1014" // Text on accent

    // ==================== Utility Colors ====================
    readonly property color muted: "#26272e" // Muted background
    readonly property color mutedForeground: "#8b8b8b" // Muted text
    readonly property color destructive: "#dc2626" // Error/delete color
    readonly property color destructiveForeground: "#f0f0f0" // Text on destructive
    readonly property color border: "#32333a" // Border color
    readonly property color input: "#26272e" // Input background
    readonly property color ring: "#2dd4a7" // Focus ring color

    // ==================== Chart Colors ====================
    readonly property color chart1: "#2dd4a7" // Chart color 1 - Teal/Green
    readonly property color chart2: "#6366f1" // Chart color 2 - Blue/Indigo
    readonly property color chart3: "#eab308" // Chart color 3 - Yellow
    readonly property color chart4: "#dc2626" // Chart color 4 - Red
    readonly property color chart5: "#22d3ee" // Chart color 5 - Cyan

    // ==================== Sidebar Colors ====================
    readonly property color sidebar: "#141519" // Sidebar background
    readonly property color sidebarForeground: "#f0f0f0" // Sidebar text
    readonly property color sidebarPrimary: "#2dd4a7" // Sidebar active item
    readonly property color sidebarAccent: "#26272e" // Sidebar hover
    readonly property color sidebarBorder: "#32333a" // Sidebar border

    // ==================== Container Status Colors ====================
    readonly property color statusRunning: "#2dd4a7" // Container running
    readonly property color statusStopped: "#8b8b8b" // Container stopped
    readonly property color statusPaused: "#eab308" // Container paused
    readonly property color statusError: "#dc2626" // Container error

    // ==================== Scrollbar Colors ====================
    readonly property color scrollbarTrack: "#1a1b20" // Scrollbar track color
    readonly property color scrollbarThumb: "#3a3b42" // Scrollbar thumb color
    readonly property color scrollbarThumbHover: "#5a5b62" // Scrollbar thumb hover
}
