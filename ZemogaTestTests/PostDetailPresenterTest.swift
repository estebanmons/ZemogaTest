//
//  PostDetailPresenterTest.swift
//  ZemogaTestTests
//
//  Created by Esteban Monsalve on 22/08/22.
//

import XCTest
@testable import ZemogaTest

class PostDetailPresenterTest: XCTestCase {
    
    var interactor: FakePostDetailInteractorInterface!
    var presenter: PostDetailPresenter!
    var view: FakePostDetailViewInterface!
    var wireframe: FakePostDetailsWireframe!
    
    private var expectationPresener: XCTestExpectation!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = FakePostDetailInteractorInterface()
        wireframe = FakePostDetailsWireframe()
        view = FakePostDetailViewInterface()
        presenter = PostDetailPresenter(
            view: view,
            interactor: interactor,
            wireframe: wireframe,
            post: Post(body: Constants.emptyString, id: 1, title: Constants.emptyString, userId: 1)
        )
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
    
    func testViewDidLoad() {
        expectationPresener = expectation(description: "Test View Did Load")
        presenter.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let strongSelf = self else { return }
            XCTAssertTrue(strongSelf.view.isSetModelDataExcuted)
            strongSelf.expectationPresener.fulfill()
        }
        waitForExpectations(timeout: 3)
    }

}

extension PostDetailPresenterTest {
    
    class FakePostDetailsWireframe: PostDetailWireframeInterface { }
    
    class FakePostDetailInteractorInterface: PostDetailInteractorInterface {
        
        var dataManager: DataManager { DataManager.sharedInstance }
        
        func requestGetUser(id: Int, completionHandler: @escaping (PostUserRsult) -> Void) {
            let user = User(
                id: 1,
                name: Constants.emptyString,
                username: Constants.emptyString,
                email: Constants.emptyString,
                address: .init(street: Constants.emptyString, suite: Constants.emptyString, city: Constants.emptyString, zipcode: Constants.emptyString, geo: .init(lat: Constants.emptyString, lng: Constants.emptyString)),
                phone: Constants.emptyString,
                website: Constants.emptyString,
                company: .init(name: Constants.emptyString, catchPhrase: Constants.emptyString, bs: Constants.emptyString)
            )
            completionHandler(.success(user))
        }
        
        func requestGetPostComments(id: Int, completionHandler: @escaping (PostCommentsResult) -> Void) {
            let comments = [
                Comment(
                    body: Constants.emptyString,
                    email: Constants.emptyString,
                    id: 1,
                    name: Constants.emptyString,
                    postId: 1
                )
            ]
            
            completionHandler(.success(comments))
        }
    }
    
    class FakePostDetailViewInterface: PostDetailViewInterface {
        
        var isSetModelDataExcuted: Bool = false
        
        func setModelData(with model: PostDetailModel) {
            isSetModelDataExcuted = true
        }
    }
}
