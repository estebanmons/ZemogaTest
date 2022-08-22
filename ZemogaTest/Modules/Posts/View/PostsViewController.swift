//
//  PostsViewController.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import UIKit

final class PostsViewController: UIViewController {
    
    // MARK: - Public properties -
    var presenter: PostsPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

// MARK: - Extensions -
extension PostsViewController: PostsViewInterface { }
