//
//  PostsPresenter.swift
//  ZemogaTestTests
//
//  Created by Esteban Monsalve on 22/08/22.
//

import XCTest
@testable import ZemogaTest

class PostsPresenterTest: XCTestCase {
    
    var interactor: FakePostsInteractorInterface!
    var presenter: PostsPresenter!
    var view: FakePostsViewInterface!
    var wireframe: FakePostsWireframe!
    
    private var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = FakePostsInteractorInterface()
        wireframe = FakePostsWireframe()
        view = FakePostsViewInterface()
        presenter = PostsPresenter(view: view, interactor: interactor, wireframe: wireframe)
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
        presenter.viewDidLoad()
        XCTAssert(view.isReloadData)
    }
    
    func testSelectedItem() {
        presenter.setSelectedSegmentedControl(selected: 0)
        XCTAssert(view.isReloadData)
    }
    
    func testDeleteAllPosts() {
        presenter.setSelectedSegmentedControl(selected: 0)
        presenter.deleteAll()
        XCTAssert(presenter.numberOfItems == 0)
    }
    
    func testDeleteAllFavorites() {
        presenter.setSelectedSegmentedControl(selected: 1)
        presenter.deleteAll()
        XCTAssert(presenter.numberOfItems == 0)
    }
}

extension PostsPresenterTest {
    
    final class FakePostsWireframe: PostsWireframeInterface {
        func goToDetail(post: Post) { }
    }
    
    final class FakePostsInteractorInterface: PostsInteractorInterface {
        var dataManager: DataManager { DataManager.sharedInstance }
        func requestGetPost(completionHandler: @escaping (PostsResult) -> Void) {
            completionHandler(.success([]))
        }
    }
    
    final class FakePostsViewInterface: PostsViewInterface {
        var isReloadData: Bool = false
        func reloadData() {
            isReloadData = true
        }
    }
}
