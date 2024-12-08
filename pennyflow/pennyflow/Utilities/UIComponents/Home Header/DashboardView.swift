import SwiftUI

struct DashboardView: View {
    @State private var progress: Double = 0
    private let circleSize: Double = 280.0
    private let circleRotationDegree: Double = 130

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                topBar

                progressCircle

                SubscriptionSummaryView()
                    .padding(.bottom)
            }
            .background(
                BottomRoundedRectangle(cornerRadius: 40)
                    .fill(Color.gray70)  // Fill with a color
            )
        }
    }

    // Top Bar with Gear Icon
    private var topBar: some View {
        HStack {
            Spacer()
            Button(action: {
                print("Settings tapped")
            }) {
                Image("settings")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 20)
        }
        .padding(.top, .topInsets)
    }

    // Circular Progress View
    private var progressCircle: some View {
        ZStack {
            staticProgressArc
            animatedProgressArc
            innerCircleContent
        }
    }

    // Static Progress Arc
    private var staticProgressArc: some View {
        Circle()
            .trim(from: 0, to: 0.75)  // Show only the top 75% of the circle
            .stroke(
                Color.gray60.opacity(0.2),
                style: StrokeStyle(
                    lineWidth: 15,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(circleRotationDegree))
            .frame(width: circleSize, height: circleSize)
    }

    // Animated Progress Arc
    private var animatedProgressArc: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                Color.secondaryC,
                style: StrokeStyle(
                    lineWidth: 15,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(circleRotationDegree))  // Rotate to start at the top
            .frame(width: circleSize, height: circleSize)
            .shadow(color: Color.secondaryC.opacity(0.5), radius: 10)
            .onAppear {
                withAnimation(.easeOut(duration: 2.0)) {
                    progress = 0.77  // Animate to 75%
                }
            }
    }

    // Inner Circle Content
    private var innerCircleContent: some View {
        VStack(spacing: 20) {
            appName
            Text("$1,235")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)
            Text("This month bills")
                .font(.subheadline)
                .foregroundColor(.gray)
            seeYourBudgetButton
        }
        .padding(.top, 50)
    }

    // App Name with Icon
    private var appName: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(Color.purple)
                .frame(width: 20, height: 20)
            Text("TRACKIZER")
                .font(.headline)
                .foregroundColor(.white)
        }
    }

    // See Your Budget Button
    private var seeYourBudgetButton: some View {
        Button(action: handleSeeYourBudget) {
            Text("See Your Budget")
                .appTextStyle(font: .headline8)
                .padding(12)
                .frame(maxWidth: 130)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.15),  // 15% opacity
                                    Color.white.opacity(0.10),  // 10% opacity
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.15),  // 15% opacity
                                    Color.white.opacity(0.10),  // 10% opacity
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1  // Stroke thickness
                        )
                )
        }
    }

    private func handleSeeYourBudget() {
        print("See Your Budget tapped")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .applyDefaultBackground()
    }
}
