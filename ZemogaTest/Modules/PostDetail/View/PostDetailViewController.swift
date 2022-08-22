//
//  PostDetailViewController.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 22/08/22.
//

import UIKit

final class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    
    // MARK: - Public properties -
    var presenter: PostDetailPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    func setupView() {
        self.title = Constants.Title.post
        descriptionTitleLabel.font = .boldSystemFont(ofSize: 20.0)
        descriptionTitleLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 17.0)
        descriptionLabel.textColor = .gray
    }
}

// MARK: - Extensions -
extension PostDetailViewController: PostDetailViewInterface {
    
    func setModelData(with model: PostDetailModel) {
        descriptionTitleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
