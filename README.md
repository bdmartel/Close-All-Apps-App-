# Close All Apps

A simple iPhone app that helps you close all background apps at once.

## Features

- **One-Tap Close All** - Triggers an iOS Shortcut to close all background apps
- **Siri Integration** - Say "Close all apps with Close All" to trigger via Siri
- **App Intents** - Works with iOS Shortcuts app for automation
- **Memory Monitor** - Shows current memory usage
- **Background Refresh Status** - Displays whether background app refresh is enabled
- **Setup Guide** - Step-by-step instructions for configuring the iOS Shortcut

## How It Works

Due to iOS sandboxing, apps cannot directly close other apps. This app works by:

1. **iOS Shortcuts Integration** - Launches a pre-configured Shortcut that navigates to the Home Screen
2. **Siri App Intents** - Provides voice-activated shortcuts
3. **Manual Guide** - Teaches efficient multi-finger swipe techniques in the App Switcher

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## Setup

1. Open the project in Xcode: `CloseAllApps/CloseAllApps.xcodeproj`
2. Select your development team in Signing & Capabilities
3. Build and run on your iPhone
4. Follow the in-app setup guide to create the iOS Shortcut

## Project Structure

```
CloseAllApps/
├── CloseAllAppsApp.swift    # App entry point
├── ContentView.swift        # Main screen with close button
├── AppCloseManager.swift    # Core logic & Shortcuts integration
├── CloseAppsIntent.swift    # Siri & App Intents support
├── InstructionsView.swift   # Setup guide with 3 methods
└── SettingsView.swift       # App settings & tips
```
