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
```

## Environment-Driven Dismissal (WORKING-IN-PROGRESS)
The app includes a custom EnvironmentKey to provide a unified dismissal action for both modals and full-screen covers. This enables custom dismiss buttons or gestures for user-triggered dismissal, making it possible to build a consistent dismissal experience across different presentation styles.

Example EnvironmentKey Setup

```swift
private struct DismissActionKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var dismissAction: () -> Void {
        get { self[DismissActionKey.self] }
        set { self[DismissActionKey.self] = newValue }
    }
}
```

#### View Structure
Each view uses navigationDestination(for:) to define its own navigation paths. This ensures that each screen handles its own routing logic independently.

- HomeView:
    - Contains navigation paths to Detail and ExtraInfo views.
    
- ProfileView:

    - Contains navigation paths to Detail and EditProfile views.
    
- SettingsView:

    - Contains navigation paths to About and Preferences views.

#### Handling Deep Links
The handleDeeplink(url:) method in AppNavigator parses incoming URLs and updates the navigation state. For example, a URL like myapp://home/detail/123 would switch to the Home tab and push a Detail view with the ID 123 onto the stack.
```swift
func handleDeeplink(url: URL) {
    guard let host = url.host else { return }
    let pathComponents = url.pathComponents.filter { $0 != "/" }

    switch host {
    case "home":
        changeTab(to: .home)
        if let firstComponent = pathComponents.first {
            switch firstComponent {
            case "detail":
                if let detailID = pathComponents[safe: 1] {
                    homePath = [.detail(detailID)]
                }
            case "extraInfo":
                homePath = [.extraInfo]
            default:
                homePath = []
            }
        } else {
            homePath = []
        }

    case "profile":
        changeTab(to: .profile)
        if let firstComponent = pathComponents.first {
            switch firstComponent {
            case "detail":
                if let detailID = pathComponents[safe: 1] {
                    profilePath = [.detail(detailID)]
                }
            case "edit":
                profilePath = [.editProfile]
            case "modal":
                showModal = true
                modalType = .editProfile
            case "fullcover":
                showFullScreen = true
                fullScreenType = .editProfileFullScreen
            default:
                profilePath = []
            }
        } else {
            profilePath = []
        }

    case "settings":
        changeTab(to: .settings)
        if let firstComponent = pathComponents.first {
            switch firstComponent {
            case "about":
                settingsPath = [.about]
            case "preferences":
                settingsPath = [.preferences]
            case "modal":
                showModal = true
                modalType = .about
            case "fullcover":
                showFullScreen = true
                fullScreenType = .preferences
            default:
                settingsPath = []
            }
        } else {
            settingsPath = []
        }

    default:
        break
    }
}
```

#### Instalation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/SwiftUI-DeepLink-Navigation.git
```
2. Open the Xcode project file.
3. Build and run the project on the iOS simulator or a real device.

#### Testing Deep Links
You can test deep links using the following methods:
1. Xcode Debug Menu:

    - Go to Debug > Open URL... and enter a custom deep link, e.g., myapp://home/detail/123.
2. Terminal Command:
```bash
xcrun simctl openurl booted myapp://profile/modal
```
3. iOS Safari:

    - Paste a deep link into the Safari address bar on your simulator or device, e.g., myapp://settings/fullcover.
    
#### Customization
To extend this architecture, you can:

    - Add new destination types for each tab.
    - Define additional modal and full-screen types.
    - Update the deep link handling logic to support new paths and behaviors.
    
#### Conclusion
This is an working in progress app that could provide a flexible and scalable navigation architecture that integrates multi-tab navigation, deep linking, and custom modal/full-screen presentations. The use of enums for different navigation states, combined with environment-based dismissals, makes this architecture easy to extend and maintain.
