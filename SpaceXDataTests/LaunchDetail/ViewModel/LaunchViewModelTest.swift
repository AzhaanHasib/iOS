//
//  LaunchViewModelTest.swift
//  SpaceXDataTests
//
//  Created by Azhaan Hasib on 21/02/22.
//

import XCTest

class LaunchViewModelTest: XCTestCase {
    
    private var launchCellViewModel : LaunchCellViewModel?

    override func setUpWithError() throws {
        
        guard let launch: Launch? = FileDataParser.shared.load("LaunchResponse", bundle: Bundle(for: type(of: self))) else {return}
        launchCellViewModel = LaunchCellViewModel(launch!)
        
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
    
    func testLaunchCellModelNotNil() {
        XCTAssertNotNil(launchCellViewModel)
    }
    
    func testLaunchCellModelNumber() {
        let flightNumber = launchCellViewModel?.flightNumber
        XCTAssertEqual(flightNumber, "1")
    }
    
    func testLaunchCellModelLaunchdate() {
        let launchDateString = launchCellViewModel?.launchDateString
        XCTAssertEqual(launchDateString, "2006-03-24")
    }
    
    func testLaunchCellModelLaunchSucesss() {
        let launchSuccess = launchCellViewModel?.launchSuccess
        XCTAssertEqual(launchSuccess, false)
    }

}
