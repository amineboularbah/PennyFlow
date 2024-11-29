import UIKit

extension CGFloat {
    
    /// The screen's width in points.
    static var screenWidth: Double {
        return UIScreen.main.bounds.size.width
    }
    
    /// The screen's height in points.
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    
    /// Calculates a percentage of the screen's width.
    ///
    /// - Parameter per: The percentage (0.0 - 1.0) of the screen width.
    /// - Returns: The width value corresponding to the given percentage.
    static func widthPer(per: Double) -> Double {
        return screenWidth * per / 100
    }
    
    /// Calculates a percentage of the screen's height.
    ///
    /// - Parameter per: The percentage (0.0 - 1.0) of the screen height.
    /// - Returns: The height value corresponding to the given percentage.
    static func heightPer(per: Double) -> Double {
        return screenHeight * per / 100
    }
    
    /// The top safe area inset of the screen.
    ///
    /// - Note: Returns `0.0` if the app cannot access the key window.
    static var topInsets: Double {
        return Double(getCurrentWindow()?.safeAreaInsets.top ?? 0.0)
    }
    
    /// The bottom safe area inset of the screen.
    ///
    /// - Note: Returns `0.0` if the app cannot access the key window.
    static var bottomInsets: Double {
        return Double(getCurrentWindow()?.safeAreaInsets.bottom ?? 0.0)
    }
    
    /// The combined horizontal safe area insets (left + right).
    ///
    /// - Note: Returns `0.0` if the app cannot access the key window.
    static var horizontalInsets: Double {
        let insets = getCurrentWindow()?.safeAreaInsets
        return (insets?.left ?? 0.0) + (insets?.right ?? 0.0)
    }
    
    /// The combined vertical safe area insets (top + bottom).
    ///
    /// - Note: Returns `0.0` if the app cannot access the key window.
    static var verticalInsets: Double {
        let insets = getCurrentWindow()?.safeAreaInsets
        return (insets?.top ?? 0.0) + (insets?.bottom ?? 0.0)
    }
    
    /// Fetches the current active window for safe area insets.
    ///
    /// - Returns: The current active `UIWindow`.
    private static func getCurrentWindow() -> UIWindow? {
        // Loop through all connected scenes to find a foreground active window
        return UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
