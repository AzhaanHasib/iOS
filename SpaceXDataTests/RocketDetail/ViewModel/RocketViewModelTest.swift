//
//  RocketViewModelTest.swift
//  SpaceXDataTests
//
//  Created by Azhaan Hasib on 21/02/22.
//

import XCTest

class RocketViewModelTest: XCTestCase {
    
    private var rocketDetailCellModel: RocketDetailCellModel?

    override func setUpWithError() throws {
        
        guard let rocket: Rocket? = FileDataParser.shared.load("RocketResponse", bundle: Bundle(for: type(of: self))) else {return}
        rocketDetailCellModel = RocketDetailCellModel(rocket!)
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
    
    func testRocketCellModelNotNil() {
        XCTAssertNotNil(rocketDetailCellModel)
    }
    func testRocketCellModelRocketName() {
        let rocketName = rocketDetailCellModel?.rocket.name ?? ""
        XCTAssertEqual("Falcon 1", rocketName)
    }
    
    func testRocketCellModelCountryName() {
        let country = rocketDetailCellModel?.rocket.country ?? ""
        XCTAssertEqual("Republic of the Marshall Islands", country)
    }
    
    func testRocketCellModelCompanyName() {
        let company = rocketDetailCellModel?.rocket.company ?? ""
        XCTAssertEqual("SpaceX", company)
    }
    
    func testRocketCellModelWikiLink() {
        let wikipedia = rocketDetailCellModel?.rocket.wikipedia ?? ""
        XCTAssertEqual("https://en.wikipedia.org/wiki/Falcon_1", wikipedia)
    }

}
