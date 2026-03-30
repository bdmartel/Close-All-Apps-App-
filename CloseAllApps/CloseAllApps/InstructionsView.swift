import SwiftUI

struct InstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("hasSetupShortcut") var hasSetupShortcut: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "gearshape.2.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.blue)
                        Text("Setup Guide")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Follow these steps to enable the close all apps feature")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)

                    // Method 1: Shortcuts
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Method 1: iOS Shortcut (Recommended)", systemImage: "star.fill")
                            .font(.headline)
                            .foregroundStyle(.orange)

                        StepView(number: 1, text: "Open the **Shortcuts** app on your iPhone")
                        StepView(number: 2, text: "Tap the **+** button to create a new shortcut")
                        StepView(number: 3, text: "Name it exactly: **Close All Apps**")
                        StepView(number: 4, text: "Add a **Scripting** action > **Open App**")
                        StepView(number: 5, text: "Set it to open the **Home Screen**")
                        StepView(number: 6, text: "Save the shortcut")

                        Button {
                            if let url = URL(string: "shortcuts://") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Label("Open Shortcuts App", systemImage: "arrow.up.forward.app")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color.orange.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    // Method 2: Manual
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Method 2: Manual Close", systemImage: "hand.draw")
                            .font(.headline)
                            .foregroundStyle(.blue)

                        StepView(number: 1, text: "Swipe up from the bottom of the screen and **pause** in the middle")
                        StepView(number: 2, text: "This opens the **App Switcher**")
                        StepView(number: 3, text: "Swipe up on each app card to **close** it")

                        Text("**Tip:** Use multiple fingers to close 2-3 apps at once!")
                            .font(.callout)
                            .padding(12)
                            .background(.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding()
                    .background(Color.blue.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    // Method 3: Accessibility
                    VStack(alignment: .leading, spacing: 16) {
                        Label("Method 3: AssistiveTouch", systemImage: "accessibility")
                            .font(.headline)
                            .foregroundStyle(.purple)

                        StepView(number: 1, text: "Go to **Settings > Accessibility > Touch > AssistiveTouch**")
                        StepView(number: 2, text: "Enable **AssistiveTouch**")
                        StepView(number: 3, text: "Customize the menu to add **App Switcher**")
                        StepView(number: 4, text: "Use the floating button to quickly access the App Switcher")

                        Button {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Label("Open Settings", systemImage: "gear")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    .background(Color.purple.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    // Mark as done
                    Button {
                        hasSetupShortcut = true
                        dismiss()
                    } label: {
                        Text("I've Set Up the Shortcut")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationTitle("How It Works")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

struct StepView: View {
    let number: Int
    let text: LocalizedStringKey

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(number)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 24, height: 24)
                .background(Circle().fill(.blue))

            Text(text)
                .font(.subheadline)
        }
    }
}

#Preview {
    InstructionsView()
}
