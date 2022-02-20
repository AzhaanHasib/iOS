//
//  LaunchModelTest.swift
//  SpaceXDataTests
//
//  Created by Azhaan Hasib on 20/02/22.
//

import XCTest

class LaunchModelTest: XCTestCase {
    
    private var launch : Launch?

    override func setUpWithError() throws {
        
        launch = FileDataParser.shared.load("LaunchResponse", bundle: Bundle(for: type(of: self)))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func launchResponseNotNil() {
        
        XCTAssertNotNil(launch)
    }
    
    func testLaunchFlightNumber() {
        let flightNumber = launch?.flight_number ?? 0
        XCTAssertEqual(1, flightNumber)
    }
    
    func testLaunchMissionName() {
        let missionName = launch?.name
        XCTAssertEqual("FalconSat", missionName)
    }
    
    func testLaunchLaunchDate() {
        let launchDate = launch?.launchDate
        XCTAssertEqual("2006-03-24T22:30:00.000Z", launchDate)
    }
    
    func testLaunchLaunchSiteNotNil() {
        let launchSite = launch?.launchSite
        XCTAssertNotNil(launchSite)
    }
    
    func testLaunchLaunchSiteName() {
        let launchSite = launch?.launchSite?.siteName
        XCTAssertEqual("Kwajalein Atoll", launchSite)
    }
    
    func testLaunchLaunchWkikLink() {
        let wikipedia = launch?.link?.wikipedia
        XCTAssertEqual("https://en.wikipedia.org/wiki/DemoSat", wikipedia)
    }

}
