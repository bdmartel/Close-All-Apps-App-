import SwiftUI
import UIKit

@MainActor
class AppCloseManager: ObservableObject {
    @Published var backgroundRefreshStatus: String = "Checking..."
    @Published var isBackgroundRefreshEnabled: Bool = false
    @Published var memoryStatus: String = "Normal"
    @Published var showSuccess: Bool = false
    @Published var showSetupNeeded: Bool = false

    @AppStorage("hasSetupShortcut") var hasSetupShortcut: Bool = false

    func refreshStatus() {
        // Check background app refresh status
        switch UIApplication.shared.backgroundRefreshStatus {
        case .available:
            backgroundRefreshStatus = "Enabled"
            isBackgroundRefreshEnabled = true
        case .denied:
            backgroundRefreshStatus = "Disabled"
            isBackgroundRefreshEnabled = false
        case .restricted:
            backgroundRefreshStatus = "Restricted"
            isBackgroundRefreshEnabled = false
        @unknown default:
            backgroundRefreshStatus = "Unknown"
            isBackgroundRefreshEnabled = false
        }

        // Report memory usage
        let memoryUsed = getMemoryUsageMB()
        if memoryUsed > 0 {
            memoryStatus = "\(memoryUsed) MB used"
        } else {
            memoryStatus = "Normal"
        }
    }

    func closeAllApps() {
        if hasSetupShortcut {
            triggerShortcut()
        } else {
            showSetupNeeded = true
        }
    }

    private func triggerShortcut() {
        // Open the Shortcuts app with our shortcut via URL scheme
        // The user needs to have created a shortcut named "Close All Apps"
        let shortcutName = "Close All Apps"
        let encoded = shortcutName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? shortcutName
        if let url = URL(string: "shortcuts://run-shortcut?name=\(encoded)") {
            UIApplication.shared.open(url) { success in
                Task { @MainActor in
                    if success {
                        self.showSuccess = true
                    } else {
                        self.showSetupNeeded = true
                        self.hasSetupShortcut = false
                    }
                }
            }
        }
    }

    private func getMemoryUsageMB() -> Int {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        let result = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        if result == KERN_SUCCESS {
            return Int(info.resident_size / (1024 * 1024))
        }
        return 0
    }
}
