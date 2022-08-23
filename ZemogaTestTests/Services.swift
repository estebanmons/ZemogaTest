//
//  Services.swift
//  ZemogaTestTests
//
//  Created by Esteban Monsalve on 22/08/22.
//

import XCTest
@testable import ZemogaTest

class Services: XCTestCase {
    
    private lazy var apiManager = APIManager()

    override func setUpWithError() throws {
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
    
    func testGetPostsService() {
        let serviceExpectation = expectation(description: "\(EndPoint.getPosts.path)")
        apiManager.request(
            parameters: EmptyRequest(),
            endpoint: .getPosts
        ) { (result: Result<[Post]>) in
            switch result {
            case .success:
                XCTAssert(true)
            case .error(let error):
                XCTFail(error.asAFError?.failureReason ?? "")
            }
            serviceExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3) { error in
            if let error = error {
                XCTFail("exceeded timeout: \(error)")
            }
        }
    }
    
    func testGetUserService() {
        let serviceExpectation = expectation(description: "\(EndPoint.getUser(id: 1).path)")
        apiManager.request(
            parameters: EmptyRequest(),
            endpoint: .getUser(id: 1)
        ) { (result: Result<User>) in
            switch result {
            case .success:
                XCTAssert(true)
            case .error(let error):
                XCTFail(error.asAFError?.failureReason ?? "")
            }
            serviceExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3) { error in
            if let error = error {
                XCTFail("exceeded timeout: \(error)")
            }
        }
    }
    
    func testGetCommentsService() {
        let serviceExpectation = expectation(description: "\(EndPoint.getPostComments(id: 1).path)")
        apiManager.request(
            parameters: EmptyRequest(),
            endpoint: .getPostComments(id: 1)
        ) { (result: Result<[Comment]>) in
            switch result {
            case .success:
                XCTAssert(true)
            case .error(let error):
                XCTFail(error.asAFError?.failureReason ?? "")
            }
            serviceExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3) { error in
            if let error = error {
                XCTFail("exceeded timeout: \(error)")
            }
        }
    }

}
