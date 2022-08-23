//
//  PostDetailViewController.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 22/08/22.
//

import UIKit

final class PostDetailViewController: UIViewController {
    
    @IBOutlet private weak var commentsTableView: UITableView!
    @IBOutlet private weak var commentsTitleLabel: UILabel!
    @IBOutlet private weak var commentsTitleView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var userEmailLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userPhoneLabel: UILabel!
    @IBOutlet private weak var userTittleLabel: UILabel!
    @IBOutlet private weak var userWebsiteLabel: UILabel!
    
    // MARK: - Public properties -
    var presenter: PostDetailPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.Title.post
        configureNavigationBar()
        setupTableView()
        presenter.viewDidLoad()
    }
    
    private func configureNavigationBar() {
        let image = UIImage(systemName: presenter.isFavorite ? Constants.PostDetail.starFillImage : Constants.PostDetail.starImage)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleFavoriteButton), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.semanticContentAttribute = .forceRightToLeft
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func setupView() {
        descriptionTitleLabel.font = .boldSystemFont(ofSize: 20.0)
        descriptionTitleLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 17.0)
        descriptionLabel.textColor = .gray
        userTittleLabel.font = .boldSystemFont(ofSize: 20.0)
        userTittleLabel.textColor = .black
        userNameLabel.font = .systemFont(ofSize: 17.0)
        userNameLabel.textColor = .black
        userEmailLabel.font = .systemFont(ofSize: 17.0)
        userEmailLabel.textColor = .black
        userPhoneLabel.font = .systemFont(ofSize: 17.0)
        userPhoneLabel.textColor = .black
        userWebsiteLabel.font = .systemFont(ofSize: 17.0)
        userWebsiteLabel.textColor = .black
        commentsTitleLabel.font = .boldSystemFont(ofSize: 20.0)
        commentsTitleLabel.textColor = .black
        commentsTitleView.backgroundColor = .systemGray4
        commentsTableView.backgroundColor = .systemGray6
    }
    
    private func setupTableView() {
        commentsTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        commentsTableView.backgroundColor = .systemGray6
    }
    
    @objc private func handleFavoriteButton() {
        presenter.validateFavorite()
        navigationItem.rightBarButtonItem = nil
        configureNavigationBar()
    }
}

// MARK: - Extensions -
extension PostDetailViewController: PostDetailViewInterface {
    
    func setModelData(with model: PostDetailModel) {
        setupView()
        descriptionTitleLabel.text = model.descriptionTitle
        descriptionLabel.text = model.description
        userTittleLabel.text = model.userTitle
        userNameLabel.text = model.name
        userEmailLabel.text = model.email
        userPhoneLabel.text = model.phone
        userWebsiteLabel.text = model.website
        commentsTitleLabel.text = model.commentsTitle
        commentsTableView.reloadData()
    }
}
    
// MARK: - Extensions UITableViewDataSource - UITableViewDelegate -
extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "commentCell",
            for: indexPath
        ) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(comment: presenter.setComment(at: indexPath.row))
        
        return cell
    }
}
