import SwiftUI

struct SegmentedControlView: View {
    @State private var selectedTab: Int = 0 // 0 for "Your subscriptions", 1 for "Upcoming bills"

    var body: some View {
        HStack(spacing: 8) {
            // Your Subscriptions Button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selectedTab = 0
                }
            }) {
                Text("Your subscriptions")
                    .font(.headline)
                    .foregroundColor(selectedTab == 0 ? .white : .gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(selectedTab == 0 ? Color.gray.opacity(0.4) : Color.clear)
                    )
            }

            // Upcoming Bills Button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selectedTab = 1
                }
            }) {
                Text("Upcoming bills")
                    .font(.headline)
                    .foregroundColor(selectedTab == 1 ? .white : .gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(selectedTab == 1 ? Color.gray.opacity(0.4) : Color.clear)
                    )
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.2)) // Background for the entire segment control
        )
        .padding(.horizontal, 16) // Optional padding for spacing
    }
}

struct SegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlView()
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Match dark mode background
    }
}