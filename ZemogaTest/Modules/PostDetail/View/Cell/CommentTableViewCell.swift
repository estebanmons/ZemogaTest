//
//  CommentTableViewCell.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 22/08/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        contentView.backgroundColor = .systemGray6
    }
    
    func setData(comment: String) {
        commentLabel.text = comment
    }
}
