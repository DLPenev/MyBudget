//
//  OverviewViewController.swift
//  My Budget
//
//  Created by MacUSER on 17.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var OverviewTableView: UITableView!
    @IBOutlet var emogiImageView: UIImageView!
    @IBOutlet var budgetStatusLabel: UILabel!
    @IBOutlet var remainingValueLabel: UILabel!
    
    let cellWithOneLabelId = "overviewCellWithOneLabelId"
    
    var segmentIndex = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1  // tuk shte ima switch
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = OverviewTableView?.dequeueReusableCell(withIdentifier: cellWithOneLabelId) as? OneLabelOverviewCell {
            cell.statusAndRemainingLabel.text  = "test \(segmentIndex)"
            return cell
        }
        return UITableViewCell()
    }
    
//gonners
    let firstSectorIndex  = 0
    let secondSectorIndex = 1
    
    let budgetStatusEmogiIndex = 0
    let budgetStatusTextIndex  = 1
    let budgetRemainingIndex   = 2
    let expencesDiagramIndex   = 3
 //^^
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        emogiImageView.image = #imageLiteral(resourceName: "emojiGood")
        budgetStatusLabel.text = "Status is good"
        remainingValueLabel.text = "34 remaining"
    }

    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        segmentIndex = sender.selectedSegmentIndex
        OverviewTableView.reloadData()
    }
    

}
