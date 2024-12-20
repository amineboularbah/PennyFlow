import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var subViewModel : SubscriptionsViewModel
    @Binding var navigateToSettings: Bool

    private let circleSize: Double = 290.0
    private let circleRotationDegree: Double = 130

    var body: some View {

        ZStack {
            VStack(spacing: 0) {
                CustomAppBar(navigateToSettings: $navigateToSettings)
                    .padding(.top, .topInsets)
                progressCircle

                SubscriptionSummaryView()
                    .padding(.bottom)
            }.frame(maxWidth: .infinity)
            .background(
                BottomRoundedRectangle(cornerRadius: 40)
                    .fill(Color.gray70)  // Fill with a color
            )
        }
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
            .trim(from: 0, to: 0.78)  // Show only the top 75% of the circle
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
    private var animatedProgressArc : some View {
        Circle()
            .trim(from: 0, to: subViewModel.calculateCircleProgress())
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
                withAnimation(.easeOut(duration: 0.5)) {
                    subViewModel.calculateMonthlyBills()
                }
            }
    }

    // Inner Circle Content
    private var innerCircleContent: some View {
        VStack(spacing: 20) {
            appName
            Text("$\(subViewModel.monthlyBills.total.formatted())")
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
            Text("PENNYFLOW")
                .font(.headline)
                .foregroundColor(.white)
        
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
        // Take the user to the budgets & spendings view
        if !appViewModel.forceShowBudget {
            appViewModel.forceShowBudget = true
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(navigateToSettings: .constant(false) )
            .applyDefaultBackground()
    }
}
