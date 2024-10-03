//
//  DeeplinkRouter.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

/*
 myapp://home → Switches to the Home tab.
 myapp://home/detail/123 → Switches to the Home tab and navigates to the detail view with ID 123.
 myapp://home/extraInfo → Switches to the Home tab and navigates to the Extra Info view.
 myapp://profile → Switches to the Profile tab.
 myapp://profile/detail/456 → Switches to the Profile tab and navigates to the detail view with ID 456.
 myapp://profile/edit → Switches to the Profile tab and navigates to the Edit Profile view.
 myapp://settings → Switches to the Settings tab.
 myapp://settings/about → Switches to the Settings tab and navigates to the About view.
 myapp://settings/preferences → Switches to the Settings tab and navigates to the Preferences view.
 */
import SwiftUI
import Foundation

// Define different tabs for the app
enum Tab: Hashable {
    case home
    case profile
    case settings
}

// Define separate destinations for each view
enum HomeViewDestination: Hashable {
    case detail(String)
    case extraInfo
}

enum ProfileViewDestination: Hashable {
    case detail(String)
    case editProfile
}

enum SettingsViewDestination: Hashable {
    case about
    case preferences
}

// New enums for custom navigation styles
enum ModalType: Hashable {
    case editProfile
    case about
}

enum FullScreenCoverType: Hashable {
    case preferences
    case editProfileFullScreen
}

// A class to manage high-level navigation
class AppNavigator: ObservableObject {
    @Published var currentTab: Tab = .home // Keeps track of the currently active tab.
    
    // Paths for standard navigation
    @Published var homePath: [HomeViewDestination] = []
    @Published var profilePath: [ProfileViewDestination] = []
    @Published var settingsPath: [SettingsViewDestination] = []

    // Custom navigation states
    @Published var showModal: Bool = false  // Controls sheet presentation
    @Published var showFullScreen: Bool = false  // Controls full-screen cover presentation
    @Published var modalType: ModalType?  // Determines which modal to show
    @Published var fullScreenType: FullScreenCoverType? // Determines which full-screen cover to show

    // Method to change the currently active tab
    func changeTab(to tab: Tab) {
        currentTab = tab
    }
    
    // Method to handle deep links and specify presentation style
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
                    modalType = .editProfile // Example: Show Edit Profile modally
                case "fullcover":
                    showFullScreen = true
                    fullScreenType = .editProfileFullScreen // Example: Show Edit Profile in full screen
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
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
