pragma Singleton
import QtQuick

QtObject {
    id: transitions

    // ==================== Duration ====================
    readonly property int durationInstant: 0 // Instant (no animation)
    readonly property int durationFast: 100 // Fast transition (ms)
    readonly property int durationNormal: 150 // Normal transition (ms)
    readonly property int durationBase: 200 // Base transition (ms)
    readonly property int durationSlow: 300 // Slow transition (ms)
    readonly property int durationSlower: 400 // Slower transition (ms)
    readonly property int durationSlowest: 500 // Slowest transition (ms)

    // ==================== Easing Types ====================
    readonly property int easingLinear: Easing.Linear // Linear easing
    readonly property int easingIn: Easing.InQuad // Ease in
    readonly property int easingOut: Easing.OutQuad // Ease out
    readonly property int easingInOut: Easing.InOutQuad // Ease in-out
    readonly property int easingBounce: Easing.OutBounce // Bounce effect
    readonly property int easingElastic: Easing.OutElastic // Elastic effect
    readonly property int easingBack: Easing.OutBack // Overshoot effect
}
