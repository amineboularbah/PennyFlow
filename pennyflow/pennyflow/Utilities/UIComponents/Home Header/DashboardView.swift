//
//  DashboardView.swift
//  pennyflow
//
//  Created by Amine on 8/12/2024.
//

import SwiftUI

struct DashboardView: View {
    @State private var progress: Double = 0
    private let circleSize: Double = 280.0
    private let circleRotationDegree: Double = 130
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer().frame(height: .topInsets)
                // Gear Icon
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
                // Circular Progress View
                ZStack {
                    // Background Arc (Static)
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

                    // Foreground Progress Circle
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
                        .shadow(
                            color: Color.secondaryC.opacity(0.5), radius: 10
                        )
                        .onAppear {
                            withAnimation(.easeOut(duration: 2.0)) {
                                progress = 0.77  // Animate to 75%
                            }
                        }

                    // Inner Content
                    VStack(spacing: 20) {
                        // App Name
                        HStack(spacing: 5) {
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 20, height: 20)
                            Text("TRACKIZER")
                                .font(.headline)
                                .foregroundColor(.white)
                        }.padding(.top, 50)

                        // Value
                        Text("$1,235")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)

                        // Subtitle
                        Text("This month bills")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        // Budget Button
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
                                                    Color.white.opacity(
                                                        0.15),  // 15% opacity
                                                    Color.white.opacity(
                                                        0.10),  // 10% opacity
                                                ]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .strokeBorder(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.white.opacity(
                                                        0.15),  // 15% opacity
                                                    Color.white.opacity(
                                                        0.10),  // 10% opacity
                                                ]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 1  // Stroke thickness
                                        )
                                )
                        }
                    }
                }

                SubscriptionSummaryView().padding(.bottom)
                
            }
            .background(
                BottomRoundedRectangle(cornerRadius: 40)
                    .fill(Color.gray70)  // Fill with a color

            )
        }
    }

    private func handleSeeYourBudget() {
        // handle the button logic here
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().applyDefaultBackground()
    }
}
