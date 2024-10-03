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
}
