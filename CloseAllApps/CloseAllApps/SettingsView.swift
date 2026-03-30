import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("hasSetupShortcut") var hasSetupShortcut: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section("Shortcut") {
                    Toggle("Shortcut Configured", isOn: $hasSetupShortcut)

                    Button {
                        if let url = URL(string: "shortcuts://") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Label("Open Shortcuts App", systemImage: "arrow.up.forward.app")
                    }
                }

                Section("System Settings") {
                    Button {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Label("Background App Refresh", systemImage: "arrow.clockwise.circle")
                    }

                    Button {
                        if let url = URL(string: "App-prefs:ACCESSIBILITY") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Label("Accessibility Settings", systemImage: "accessibility")
                    }
                }

                Section("Tips") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Save Battery Life")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("Closing background apps can help save battery, especially apps that use location services or play audio in the background.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("iOS Manages Memory")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("iOS automatically manages memory and suspends unused apps. You don't always need to close apps, but it can help if an app is misbehaving.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("iOS Target")
                        Spacer()
                        Text("17.0+")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
