//
//  CategoryViewCell.swift
//  My Budget
//
//  Created by MacUSER on 5.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryIconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categoryIconView.layer.cornerRadius = self.categoryIconView.frame.size.width / 2
        self.categoryIconView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
