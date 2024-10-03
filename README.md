# SwiftUI Multi-Tab App with Deep Linking and Custom Navigation

## Overview
This project is a multi-tab SwiftUI app that supports deep linking and custom navigation. It includes standard navigation using `NavigationStack` and also features modal and full-screen presentations using `sheet` and `fullScreenCover` modifiers. The architecture is designed to be modular, allowing each view to manage its own navigation destinations while a central `AppNavigator` class handles high-level navigation state and deep link management.

### Key Features
1. **Multi-Tab Navigation:** 
   - Uses a `TabView` with separate tabs for `Home`, `Profile`, and `Settings`.
2. **Deep Linking:**
   - Supports deep linking from both outside and inside the app, enabling navigation to any screen directly using custom URL schemes.
3. **Custom Navigation Patterns:**
   - Includes support for modals and full-screen presentations using custom types.
   - Allows flexible screen presentation based on deep link structure or internal triggers.
4. **Centralized Navigation Management:**
   - Uses an `AppNavigator` class to manage navigation state across the app, including standard navigation paths, modal, and full-screen states.

## Architecture

### AppNavigator Class
The `AppNavigator` class is the central hub for managing navigation state. It controls:

1. **Tab Navigation:**
   - Tracks the currently active tab.
   - Handles switching between tabs based on deep links or user actions.

2. **Standard Navigation Paths:**
   - Each tab (`Home`, `Profile`, and `Settings`) has its own `NavigationStack` path:
     - `homePath` for `Home` tab navigation.
     - `profilePath` for `Profile` tab navigation.
     - `settingsPath` for `Settings` tab navigation.
   - The paths are stored as arrays and updated whenever navigation changes.

3. **Modal and Full-Screen Presentation:**
   - Uses separate state properties for modals and full-screen covers:
     - `showModal`: Boolean flag to control modal presentation.
     - `showFullScreen`: Boolean flag to control full-screen cover presentation.
   - `modalType`: Enum that determines which view should be presented as a modal.
   - `fullScreenType`: Enum that determines which view should be presented as a full-screen cover.

### Deep Linking Structure
The app uses a custom URL scheme (`myapp://`) to handle deep linking. This allows navigation to specific tabs, paths, and custom presentations (modals or full-screen covers) based on the incoming URL. The `handleDeeplink(url:)` method in `AppNavigator` handles the parsing and navigation logic for these deep links.

#### Example Deep Links
- `myapp://home` - Navigates to the Home tab.
- `myapp://home/detail/123` - Navigates to the Home tab and pushes a Detail view with ID `123`.
- `myapp://profile` - Navigates to the Profile tab.
- `myapp://profile/edit` - Navigates to the Profile tab and shows the Edit Profile view.
- `myapp://profile/modal` - Presents the Edit Profile view modally.
- `myapp://settings/fullcover` - Presents the Preferences view as a full-screen cover.

### Custom Modal and Full-Screen Navigation
The architecture uses custom enums for managing modal and full-screen presentation types:

```swift
enum ModalType: Hashable {
    case editProfile
    case about
}

enum FullScreenCoverType: Hashable {
    case preferences
    case editProfileFullScreen
}
