//
//  thisWeekExpensesCell.swift
//  My Budget
//
//  Created by MacUSER on 24.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class ExpensesCell: UITableViewCell {

    @IBOutlet var dayOfWeekLabel: UILabel!
    @IBOutlet var subcategoryNameLabel: UILabel!
    @IBOutlet var expenseValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
