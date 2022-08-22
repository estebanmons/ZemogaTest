//
//  PostTableViewCell.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 22/08/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(with title: String) {
        titleLabel.text = title
    }
}
