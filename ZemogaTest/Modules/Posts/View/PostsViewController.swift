//
//  PostsViewController.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import UIKit

final class PostsViewController: UIViewController {
    
    // MARK: - Private properties -
    private lazy var deleteAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle(Constants.Posts.delete, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleDeleteAllButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        refreshControl.tintColor = .systemGreen
        return refreshControl
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: SegmentedControlItems.allCases.map({ $0.title }))
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .systemGreen
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.selectedSegmentTintColor = .white
        segmentedControl.layer.borderWidth = 1
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)
        ]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleTextAttributes1 = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGreen,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)
        ]
        segmentedControl.setTitleTextAttributes(titleTextAttributes1, for: .selected)
        segmentedControl.addTarget(self, action: #selector(handleSegmentedChange), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Public properties -
    var presenter: PostsPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupView()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated: animated)
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes =  [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemGreen
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance =  navigationController?.navigationBar.standardAppearance
        
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleRefreshButton))
        navigationItem.rightBarButtonItem = button
    }
    
    private func addViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(deleteAllButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            deleteAllButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    private func setupTableView() {
        tableView.register(
            UINib(nibName: PostTableViewCell.cell, bundle: nil), forCellReuseIdentifier: PostTableViewCell.reuseIdentifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(refreshControl)
    }
    
    private func setupView() {
        self.title = Constants.Title.posts
        view.backgroundColor = .white
        addViews()
        setConstraints()
        setupTableView()
    }
    
    @objc func handleSegmentedChange() {
        presenter.setSelectedSegmentedControl(selected: segmentedControl.selectedSegmentIndex)
    }
    
    @objc func handleRefreshControl() {
        presenter.refreshData()
    }
    
    @objc func handleRefreshButton() {
        presenter.refreshData()
    }
    
    @objc func handleDeleteAllButton() {
        presenter.deleteAll()
    }
}

// MARK: - Extensions -
extension PostsViewController: PostsViewInterface {
    
    func reloadData() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - Extensions UITableViewDataSource - UITableViewDelegate -
extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(with: presenter.getPostData(at: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(row: indexPath.row)
    }
}
