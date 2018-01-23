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
    @IBOutlet var expenseSlider: UISlider!
    @IBOutlet var savingsSlider: UISlider!
    @IBOutlet var incomeValueLabel: UILabel!
    @IBOutlet var expenseValueLabel: UILabel!
    @IBOutlet var procentageValueLabel: UILabel!
    
    var regularIncome  = 0
    var regularExpense = 0
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
    
    @IBAction func expenseSliderChanged(_ sender: UISlider) {
        regularExpense = Int(sender.value)
        expenseValueLabel.text = "\(regularExpense)"
    }
    
    @IBAction func procentageValueChanged(_ sender: UISlider) {
        savingsProcent = Int(sender.value)
        procentageValueLabel.text = "\(savingsProcent) %"
    }
    

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        DBManager.singleton.updateCashFlowValues(income: regularIncome, expense: regularExpense, savings: savingsProcent)
        UserDefaults.standard.set(true, forKey: "cashFlowIsSet")
    }
    

}
