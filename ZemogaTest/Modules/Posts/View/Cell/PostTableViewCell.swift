//
//  PostTableViewCell.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 22/08/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var favoriteImageView: UIImageView!
    @IBOutlet private weak var favoriteView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        favoriteImageView.image = nil
        favoriteView.isHidden = false
    }
    
    func setData(with model: PostModel) {
        titleLabel.text = model.title
        
        switch model.type {
        case .all:
            favoriteView.isHidden = true
            favoriteImageView.image = nil
        case .favorites:
            favoriteView.isHidden = false
            guard let image = UIImage(systemName: Constants.PostDetail.starFillImage)?.withRenderingMode(.alwaysTemplate) else { return }
            image.withTintColor(.red)
            favoriteImageView.image = image
            favoriteImageView.tintColor = .systemYellow
            layoutIfNeeded()
        }
    }
}
