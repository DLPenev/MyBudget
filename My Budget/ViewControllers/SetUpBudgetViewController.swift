//
//  SetUpBudgetViewController.swift
//  My Budget
//
//  Created by MacUSER on 12.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class SetUpBudgetViewController: UIViewController {

    
    
    @IBOutlet var regularIncomeLabel: UILabel!
    @IBOutlet var incomesSlider: UISlider!
    @IBOutlet var incomeValueLabel: UILabel!
    
    @IBOutlet var regularExpenseLabel: UILabel!
    @IBOutlet var expenseSlider: UISlider!
    @IBOutlet var expenseValueLabel: UILabel!
    
    
    @IBOutlet var savingsProcentageLabel: UILabel!
    @IBOutlet var savingsSlider: UISlider!
    @IBOutlet var percentageValueLabel: UILabel!

    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyTextField: UITextField!
    
    var pickedCurrency = ""
    let currencyList = ["$","€","лв","£","¥","CHF","₽","฿"]
    
    var regularIncome  = 0
    var regularExpense = 0
    var savingsProcent = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  regularIncomeLabel.text = NSLocalizedString(, comment: "some")
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        setSlidersIfThereIsChashFlow()
    }

    func createCurrencyPickerView(){
        let currencyPickerView = UIPickerView()
        currencyPickerView.delegate = self
        currencyTextField.inputView = currencyPickerView
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target :self, action: #selector(doneBarButtonItem))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target :self, action: #selector(canselBarButtonItem))
        
        toolBar.setItems([doneButton, cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        currencyTextField.inputAccessoryView = toolBar
        
    }
    
    func setSlidersIfThereIsChashFlow(){

        if globalUserDefaults.cashFlowIsSet {
            let cashFlow = DBManager.singleton.getCashFlow()
            self.regularIncome = Int(cashFlow.income)
            self.regularExpense = Int(cashFlow.expense)
            self.savingsProcent = Int(cashFlow.savingsPercentage)
            
            self.incomesSlider.setValue(Float(regularIncome), animated: true)
            self.expenseSlider.setValue(Float(regularExpense), animated: true)
            self.savingsSlider.setValue(Float(savingsProcent), animated: true)
            self.incomeValueLabel.text = String(regularIncome)
            self.expenseValueLabel.text = String(regularExpense)
            self.percentageValueLabel.text = String(savingsProcent)
            self.currencyTextField.text = cashFlow.currency
        }
        
    }
    
    @objc func doneBarButtonItem(){
        self.currencyTextField.text = pickedCurrency
        globalUserDefaults.userCurrecy = pickedCurrency

        view.endEditing(true)
    }
    
    @objc func canselBarButtonItem(){
        view.endEditing(true)
    }
    
    @IBAction func incomeSliderChanged(_ sender: UISlider) {
        self.regularIncome = Int(sender.value)
        self.incomeValueLabel.text = "\(regularIncome)"
    }
    
    @IBAction func expenseSliderChanged(_ sender: UISlider) {
        self.regularExpense = Int(sender.value)
        self.expenseValueLabel.text = "\(regularExpense)"
    }
    
    @IBAction func percentageValueChanged(_ sender: UISlider) {
        self.savingsProcent = Int(sender.value)
        self.percentageValueLabel.text = "\(savingsProcent) %"
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        DBManager.singleton.updateCashFlowValues(income: regularIncome, expense: regularExpense, savings: savingsProcent, currensy: pickedCurrency)

        UserDefaults.standard.set(true, forKey: globalUserDefaults.cashFlowIsSetKey)
        UserDefaults.standard.set(pickedCurrency, forKey: globalUserDefaults.userCurrecyKey)
        
        tabBarController?.selectedIndex = globalIndexes.tabBarOverviewIndex
    }
    
    @IBAction func pickCurencyEditingDidBegin(_ sender: UITextField) {
        self.createCurrencyPickerView()
    }
    
}

extension SetUpBudgetViewController: UIPickerViewDelegate, UIPickerViewDataSource {     ///////// picker view
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  self.currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickedCurrency = self.currencyList[row]
    }
}

