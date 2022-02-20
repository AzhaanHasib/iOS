//
//  LaunchListModelTest.swift
//  SpaceXDataTests
//
//  Created by Azhaan Hasib on 20/02/22.
//

import XCTest

class LaunchListModelTest: XCTestCase {
    
    private var launchs : [Launch]?

    override func setUpWithError() throws {
        
        launchs = FileDataParser.shared.load("LaunchListResponse", bundle: Bundle(for: type(of: self)))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        
        launchs = nil
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

    }
    
    func testLaunchListResponseNotNil() {
        
        XCTAssertNotNil(launchs)
    }
    
    func testLaunchListCountNotZero() {
        let count = launchs?.count ?? 0
        
        XCTAssertNotEqual(0, count)
        
    }
    
    func testLaunchListTotalCount() {
        let count = launchs?.count ?? 0
        
        XCTAssertEqual(111, count)
        
    }

}
