//
//  SettingsView.swift
//  pennyflow
//
//  Created by Amine on 13/12/2024.
//

import SwiftUI

// MARK: - Settings View

struct SettingsView: View {
    // MARK: - ViewModel
    @StateObject private var viewModel = ProfileViewModel()  // Initialize ViewModel

    var body: some View {

        ScrollView {
            VStack(spacing: 20) {
                // MARK: Header Section
                SettingsHeaderView()

                // MARK: Profile Section
                ProfileSection(viewModel: viewModel)  // Pass ViewModel

                // MARK: General Section
                SettingsCategorySection(
                    title: "General",
                    items: [
                        AnyView(
                            IconItemRow(
                                icon: "face_id",
                                title: "Security",
                                value: "FaceID"
                            )
                        ),
                        AnyView(
                            IconItemSwitchRow(
                                icon: "icloud",
                                title: "iCloud Sync",
                                value: $viewModel.isICloudSyncEnabled
                            )
                        ),
                    ]
                )

                // MARK: Subscriptions Section
                SettingsCategorySection(
                    title: "My Subscriptions",
                    items: [
                        AnyView(
                            IconItemRow(
                                icon: "sorting",
                                title: "Sorting",
                                value: "Date"
                            )
                        ),
                        AnyView(
                            IconItemRow(
                                icon: "chart",
                                title: "Summary",
                                value: "Average"
                            )
                        ),
                        AnyView(
                            IconItemRow(
                                icon: "money",
                                title: "Default currency",
                                value: "USD ($)"
                            )
                        ),
                    ]
                )

                // MARK: Appearance Section
                SettingsCategorySection(
                    title: "Appearance",
                    items: [
                        AnyView(
                            IconItemRow(
                                icon: "app_icon",
                                title: "App icon",
                                value: "Default"
                            )
                        ),
                        AnyView(
                            IconItemRow(
                                icon: "light_theme",
                                title: "Theme",
                                value: "Dark"
                            )
                        ),
                        AnyView(
                            IconItemRow(
                                icon: "font",
                                title: "Font",
                                value: "Inter"
                            )
                        ),
                    ]
                )
                Spacer().frame(height: 50)
            }

        }.padding(.horizontal)
            .applyDefaultBackground()
            .navigationBarBackButtonHidden(true)  // Hide the default back button
            .ignoresSafeArea()
    }
}

// MARK: - Header View
struct SettingsHeaderView: View {
    @Environment(\.dismiss) var dismiss  // Dismiss environment

    var body: some View {
        ZStack {
            HStack {
                Button {
                    // Handle back navigation
                    dismiss()
                } label: {
                    Image("back")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray30)
                }
                Spacer()
            }

            Text("Settings")
                .appTextStyle(font: .bodyLarge, color: .gray30)

        }
        .padding(.top, .topInsets)
    }
}

// MARK: - Profile Section
struct ProfileSection: View {
    @ObservedObject var viewModel: ProfileViewModel  // Inject ViewModel

    var body: some View {
        VStack(spacing: 15) {
            // Profile Image
            profileImage

            // Profile Name
            Text(viewModel.name)
                .appTextStyle(font: .headline5)

            // Profile Email
            Text(viewModel.email)
                .appTextStyle(font: .bodySmall, color: .gray30)

            // Edit Profile Button
            SecondaryButton(
                title: "Edit Profile",
                action: {
                    viewModel.editProfile()
                }, width: 87, isFilled: true, textColor: .white
            ).frame(height: 32)
        }
    }
    
    
    private var profileImage: some View {
        if let imageData = viewModel.profileImageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 70, height: 70)
        } else {
            Image("u1") // Fallback to default placeholder
                .resizable()
                .frame(width: 70, height: 70)
        }
    }
}

// MARK: - Settings Category Section
struct SettingsCategorySection: View {
    let title: String
    let items: [AnyView]  // Use a type-erased view array

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .appTextStyle(font: .bodyLarge)
                .padding(.top, 8)

            VStack(spacing: 8) {
                ForEach(0..<items.count, id: \.self) { index in
                    items[index]
                }
            }
            .padding(.vertical, 10)
            .background(Color.gray60.opacity(0.2))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray70, lineWidth: 1)
            )
            .cornerRadius(16)
        }
        .foregroundColor(.white)
    }
}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
            .applyDefaultBackground()

    }
}
