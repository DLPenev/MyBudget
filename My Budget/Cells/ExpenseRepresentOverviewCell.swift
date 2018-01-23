//
//  ExpenseRepresentOverviewCell.swift
//  My Budget
//
//  Created by MacUSER on 19.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class ExpenseRepresentOverviewCell: UITableViewCell {

    @IBOutlet var categoryIconImageView:      UIImageView!
    @IBOutlet var categoryNameLabel:          UILabel!
    @IBOutlet var procentOfTotalExpenceLabel: UILabel!
    @IBOutlet var valueOfExpenseLabel:        UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
