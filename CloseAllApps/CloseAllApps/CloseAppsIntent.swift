import AppIntents

struct CloseAppsIntent: AppIntent {
    static var title: LocalizedStringResource = "Close All Apps"
    static var description: IntentDescription = "Triggers the close all apps workflow"
    static var openAppWhenRun: Bool = true

    func perform() async throws -> some IntentResult {
        await MainActor.run {
            NotificationCenter.default.post(
                name: .closeAllAppsRequested,
                object: nil
            )
        }
        return .result()
    }
}

struct CloseAppsShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: CloseAppsIntent(),
            phrases: [
                "Close all apps with \(.applicationName)",
                "Close all background apps with \(.applicationName)",
                "Clear all apps with \(.applicationName)"
            ],
            shortTitle: "Close All Apps",
            systemImageName: "xmark.circle.fill"
        )
    }
}

extension Notification.Name {
    static let closeAllAppsRequested = Notification.Name("closeAllAppsRequested")
}
