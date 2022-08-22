//
//  PostDetailViewController.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    // MARK: - Public properties -
    var presenter: PostDetailPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Extensions -
extension PostDetailViewController: PostDetailViewInterface { }
