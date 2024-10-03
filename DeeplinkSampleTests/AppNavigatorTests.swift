//
//  AppNavigatorTests.swift
//  DeeplinkSampleTests
//
//  Created by Carlos on 03/10/24.
//

import XCTest
@testable import DeeplinkSample

final class AppNavigatorTests: XCTestCase {

    var navigator: AppNavigator!
    
    override func setUp() {
        super.setUp()
        navigator = AppNavigator()
    }
    
    override func tearDown() {
        navigator = nil
        super.tearDown()
    }

    // MARK: - Home Tab Tests
    
    func testHandleHomeDeepLink() {
        let url = URL(string: "myapp://home")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .home)
        XCTAssertTrue(navigator.homePath.isEmpty)
    }
    
    func testHandleHomeDetailDeepLink() {
        let url = URL(string: "myapp://home/detail/123")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .home)
        XCTAssertEqual(navigator.homePath, [.detail("123")])
    }
    
    func testHandleHomeExtraInfoDeepLink() {
        let url = URL(string: "myapp://home/extraInfo")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .home)
        XCTAssertEqual(navigator.homePath, [.extraInfo])
    }
    
    // MARK: - Profile Tab Tests
    
    func testHandleProfileDeepLink() {
        let url = URL(string: "myapp://profile")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .profile)
        XCTAssertTrue(navigator.profilePath.isEmpty)
    }
    
    func testHandleProfileDetailDeepLink() {
        let url = URL(string: "myapp://profile/detail/456")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .profile)
        XCTAssertEqual(navigator.profilePath, [.detail("456")])
    }
    
    func testHandleProfileEditDeepLink() {
        let url = URL(string: "myapp://profile/edit")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .profile)
        XCTAssertEqual(navigator.profilePath, [.editProfile])
    }
    
    func testHandleProfileModalDeepLink() {
        let url = URL(string: "myapp://profile/modal")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .profile)
        XCTAssertTrue(navigator.profilePath.isEmpty)
        XCTAssertTrue(navigator.showModal)
        XCTAssertEqual(navigator.modalType, .editProfile)
    }
    
    func testHandleProfileFullCoverDeepLink() {
        let url = URL(string: "myapp://profile/fullcover")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .profile)
        XCTAssertTrue(navigator.profilePath.isEmpty)
        XCTAssertTrue(navigator.showFullScreen)
        XCTAssertEqual(navigator.fullScreenType, .editProfileFullScreen)
    }
    
    // MARK: - Settings Tab Tests
    
    func testHandleSettingsDeepLink() {
        let url = URL(string: "myapp://settings")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .settings)
        XCTAssertTrue(navigator.settingsPath.isEmpty)
    }
    
    func testHandleSettingsAboutDeepLink() {
        let url = URL(string: "myapp://settings/about")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .settings)
        XCTAssertEqual(navigator.settingsPath, [.about])
    }
    
    func testHandleSettingsPreferencesDeepLink() {
        let url = URL(string: "myapp://settings/preferences")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .settings)
        XCTAssertEqual(navigator.settingsPath, [.preferences])
    }
    
    func testHandleSettingsModalDeepLink() {
        let url = URL(string: "myapp://settings/modal")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .settings)
        XCTAssertTrue(navigator.settingsPath.isEmpty)
        XCTAssertTrue(navigator.showModal)
        XCTAssertEqual(navigator.modalType, .about)
    }
    
    func testHandleSettingsFullCoverDeepLink() {
        let url = URL(string: "myapp://settings/fullcover")!
        navigator.handleDeeplink(url: url)
        
        XCTAssertEqual(navigator.currentTab, .settings)
        XCTAssertTrue(navigator.settingsPath.isEmpty)
        XCTAssertTrue(navigator.showFullScreen)
        XCTAssertEqual(navigator.fullScreenType, .preferences)
    }
}
