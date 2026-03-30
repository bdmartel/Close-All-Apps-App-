import SwiftUI

struct ContentView: View {
    @StateObject private var manager = AppCloseManager()
    @State private var showInstructions = false
    @State private var showSettings = false
    @State private var animatePulse = false
    @State private var showConfirmation = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color(.systemBackground), Color.blue.opacity(0.05)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 32) {
                    Spacer()

                    // App icon area
                    ZStack {
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [Color.red.opacity(0.2), Color.clear],
                                    center: .center,
                                    startRadius: 5,
                                    endRadius: 100
                                )
                            )
                            .frame(width: 200, height: 200)
                            .scaleEffect(animatePulse ? 1.1 : 1.0)

                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.red, .orange],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: .red.opacity(0.3), radius: 10)
                    }

                    VStack(spacing: 8) {
                        Text("Close All Apps")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Free up memory & battery")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    // Main action button
                    Button {
                        showConfirmation = true
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "power")
                                .font(.title2)
                            Text("Close All Apps")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            LinearGradient(
                                colors: [.red, .orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .red.opacity(0.3), radius: 8, y: 4)
                    }
                    .padding(.horizontal, 32)

                    // Status card
                    VStack(spacing: 12) {
                        HStack {
                            Label("Background App Refresh", systemImage: "arrow.clockwise.circle")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(manager.backgroundRefreshStatus)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(manager.isBackgroundRefreshEnabled ? .green : .orange)
                        }

                        Divider()

                        HStack {
                            Label("Memory Pressure", systemImage: "memorychip")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(manager.memoryStatus)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.blue)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 24)

                    Spacer()

                    // Bottom hint
                    Button {
                        showInstructions = true
                    } label: {
                        Label("How does this work?", systemImage: "questionmark.circle")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.bottom, 8)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showInstructions) {
                InstructionsView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .alert("Close All Apps?", isPresented: $showConfirmation) {
                Button("Close All", role: .destructive) {
                    manager.closeAllApps()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This will guide you through closing all background apps using iOS Shortcuts. Your current app will remain open.")
            }
            .alert("Shortcut Launched", isPresented: $manager.showSuccess) {
                Button("OK") { }
            } message: {
                Text("The Close All Apps shortcut has been triggered. Follow the on-screen prompts to complete the process.")
            }
            .alert("Setup Required", isPresented: $manager.showSetupNeeded) {
                Button("Open Instructions") {
                    showInstructions = true
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("You need to set up the iOS Shortcut first. Tap 'Open Instructions' to learn how.")
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    animatePulse = true
                }
                manager.refreshStatus()
            }
        }
    }
}

#Preview {
    ContentView()
}
