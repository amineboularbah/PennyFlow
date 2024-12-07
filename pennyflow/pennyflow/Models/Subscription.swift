struct Subscription: Codable, Identifiable {
    let id = UUID() // Unique identifier for SwiftUI
    let name: String
    let description: String
    let image: String
}