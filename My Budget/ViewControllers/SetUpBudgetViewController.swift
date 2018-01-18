//
//  SetUpBudgetViewController.swift
//  My Budget
//
//  Created by MacUSER on 12.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class SetUpBudgetViewController: UIViewController {

    
    @IBOutlet var imcomesSlider: UISlider!
    @IBOutlet var expenceSlider: UISlider!
    @IBOutlet var savingsSlider: UISlider!
    @IBOutlet var incomeValueLabel: UILabel!
    @IBOutlet var expenceValueLabel: UILabel!
    @IBOutlet var procentageValueLabel: UILabel!
    
    var regularIncome  = 0
    var regularExpence = 0
    var savingsProcent = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func incomeSliderChanged(_ sender: UISlider) {
        regularIncome = Int(sender.value)
        incomeValueLabel.text = "\(regularIncome)"
    }
    
    @IBAction func expenceSliderChanged(_ sender: UISlider) {
        regularExpence = Int(sender.value)
        expenceValueLabel.text = "\(regularExpence)"
    }
    
    @IBAction func procentageValueChanged(_ sender: UISlider) {
        savingsProcent = Int(sender.value)
        procentageValueLabel.text = "\(savingsProcent) %"
    }
    

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        DBManager.singleton.updateCashFlowValues(income: regularIncome, expense: regularExpence, savings: savingsProcent)
        UserDefaults.standard.set(true, forKey: "cashFlowIsSet")
    }
    

}
