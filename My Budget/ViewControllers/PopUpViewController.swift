//
//  PopUpViewController.swift
//  My Budget
//
//  Created by MacUSER on 13.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UITextFieldDelegate {
    
   // MARK: - general outlets and variables
    
    @IBOutlet var popupAddExpense: UIView!
    @IBOutlet var popupAddIncome: UIView!
    @IBOutlet var popupEditExpense: UIView!
    @IBAction func unwindToPopUpViewController(segue: UIStoryboardSegue){}
    let cornerRadius: CGFloat = 20
    
    var popupDelegate: PopupDelegate?
 
    var popupViewIndex = globalIndexes.popupIndexEdit
    
    // MARK: - pickerview outlets and variables
    var subCategoryList: [(subcategoryId: Int,subcategoryName: String)] = []
    var pickedSubCategory = (subcategoryId: 0,subcategoryName: "")
    
    
    // MARK: - PopoverAddExpense outlets and variables
    

    @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var popoverTitle: UILabel!
    @IBOutlet var expenseValueTextField: UITextField!
    
    
    var selectedSubCategory = (pk : 0 ,name: "")

    
    
    // MARK: - PopoverAddIncome outlets and variables
    
    
    
    
    // MARK: - PopoverEdit outlets and variables
    
    @IBOutlet var editNewValueTextField: UITextField!
    @IBOutlet var editNewSubcategoryTextField: UITextField!
    @IBOutlet var editNewDateTextField: UITextField!
    
    let datePickerView = UIDatePicker()
    var editedExpense = Expense()
    var isDatePicker = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expenseValueTextField.delegate = self
        self.customPopupUI(viewIndex: popupViewIndex)
        
        if popupViewIndex == globalIndexes.popupIndexExpense {
            self.showAddExpensePopup()
        } else if popupViewIndex == globalIndexes.popupIndexIncome {     // popup income
            
        } else {                                                         // popup edit
            self.showEditPopup()
            self.subCategoryList = DBManager.singleton.loadSubCategories(categoryId: editedExpense.categoryId)
        }
    }
    
    // MARK: - PopoverAddExpense func and actions
    
    @IBAction func addExpenseOkPressed(_ sender: UIButton) {
        
        if let valueEntered = expenseValueTextField.text {
            if valueEntered.isValidExpense  {
                guard let newValue = NumberFormatter().number(from: valueEntered)?.doubleValue else {
                   self.expenseValueTextField.textColor = UIColor.red
                    print("fail cast string to double")
                    return
                }
                
                if newValue == 0 {
                    print("value is 0")
                    self.expenseValueTextField.textColor = UIColor.red
                    return
                }
                
                if selectedSubCategory.pk != 0 {
                    DBManager.singleton.insertInExpenseTable(value: newValue, subcategory: selectedSubCategory.pk)
                    self.popupDelegate?.setNewValuesAndRefreshTableView()
                    dismiss(animated: true, completion: nil)
                } else {
                    
                    self.subCategoryLabel.textColor = UIColor.red
                    print("did not select category")
                }
                
            } else {
                self.expenseValueTextField.attributedPlaceholder = NSAttributedString(string: "Enter Value", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                self.expenseValueTextField.textColor = UIColor.red
                print("fail regex")
            }
        }
    }
    
    @IBAction func pickCategoryTouchUpInside(_ sender: UIButton) {
        self.subCategoryLabel.textColor = UIColor.white
        performSegue(withIdentifier: globalIdentificators.segueToChooseCategoryId, sender: nil)
    }
    
    
    @IBAction func enterValueTextFieldEditingChanged(_ sender: UITextField) {
        self.expenseValueTextField.textColor = .black
    }
    
    @IBAction func AddExpenseCanselTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func showAddExpensePopup(){
        if selectedSubCategory.name != "" {
            self.subCategoryLabel.text = selectedSubCategory.name
        }
    }
    
    // MARK: - PopoverAddIncome func and actions
    
    @IBAction func addIncomeCancelTouchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    // MARK: - PopoverEdit func and actions
    
    @IBAction func editOkTouchUpInside(_ sender: UIButton) {
        
        if let hasValue = editNewValueTextField.text {
            if hasValue.isValidExpense {
                guard let newValue = NumberFormatter().number(from: hasValue)?.doubleValue else {
                    self.editNewValueTextField.textColor = UIColor.red
                    print("fail cast string to double")
                    return
                }
                
                if newValue == 0 {
                    print("value is 0")
                    self.editNewValueTextField.textColor = .red
                    return
                }
                self.editedExpense.value = newValue
            } else {
                print("invalid value")
                self.editNewValueTextField.attributedPlaceholder = NSAttributedString(string: "Enter Value", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                self.editNewValueTextField.textColor = .red
                return
            }
        }
        
        DBManager.singleton.updateExpense(value: editedExpense.value, subcategory: editedExpense.subCategoryId, date: editedExpense.date, expenseId: editedExpense.expenseId)
        self.popupDelegate?.setNewValuesAndRefreshTableView()
        dismiss(animated: true)
    }
    
    @IBAction func editValueTextFieldChange(_ sender: UITextField) {
        self.editNewValueTextField.textColor = .black
    }
    
    @IBAction func editCancelTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func editSubcategoryTextFiledDidBegin(_ sender: UITextField) {
        self.isDatePicker = false
        self.createSubcategoryPickerView()
    }
    
    @IBAction func editDateTextFieldDidBegin(_ sender: UITextField) {
        self.isDatePicker = true
        self.createDatePicker()
    }
    
    func showEditPopup(){
        self.editNewValueTextField.text = "".doubleFormater(value: editedExpense.value)
        self.editNewSubcategoryTextField.text = editedExpense.subcategoryName
        self.editNewDateTextField.text = "".getTimeOrDateToString(dateInMillisec: editedExpense.date, format: globalDateFormats.dateFormatFullDate)
    }
    
    // MARK: - func and actions for All Popovers
    
    func customPopupUI(viewIndex: Int){
        
        if viewIndex == globalIndexes.popupIndexExpense {
            self.view.addSubview(popupAddExpense)
            self.popupAddExpense.center = CGPoint(x: view.frame.size.width / 2, y : view.frame.size.height / 3)
            self.popupAddExpense.layer.cornerRadius   = cornerRadius
            self.popupAddExpense.layer.masksToBounds  = true
            
        } else if viewIndex == globalIndexes.popupIndexIncome {
            self.view.addSubview(popupAddIncome)
            self.popupAddIncome.center = CGPoint(x: view.frame.size.width / 2, y : view.frame.size.height / 3)
            self.popupAddIncome.layer.cornerRadius    = cornerRadius
            self.popupAddIncome.layer.masksToBounds   = true
            
        } else {                    //popupEditExpense
            self.view.addSubview(popupEditExpense)
            self.popupEditExpense.center = CGPoint(x: view.frame.size.width / 2, y : view.frame.size.height / 3)
            self.popupEditExpense.layer.cornerRadius  = cornerRadius
            self.popupEditExpense.layer.masksToBounds = true
        }
    }
    
    func createSubcategoryPickerView(){
        let subCategoryView = UIPickerView()
        subCategoryView.delegate = self
        self.editNewSubcategoryTextField.inputView = subCategoryView
        self.createToolbar()
    }
    
    func createDatePicker(){
        self.datePickerView.datePickerMode = .date
        self.datePickerView.maximumDate = Date()
        self.editNewDateTextField.inputView = datePickerView
        self.createToolbar()
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target :self, action: #selector(PopUpViewController.doneBarButtonItem))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target :self, action: #selector(PopUpViewController.dismissToolbar))
        
        toolBar.setItems([doneButton, cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.editNewSubcategoryTextField.inputAccessoryView = toolBar
        self.editNewDateTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneBarButtonItem(){
        
        if !isDatePicker {
            self.editedExpense.subCategoryId      = pickedSubCategory.subcategoryId
            self.editedExpense.subcategoryName    = pickedSubCategory.subcategoryName
            self.editNewSubcategoryTextField.text = pickedSubCategory.subcategoryName
        } else {
            self.editedExpense.date = (CLongLong(datePickerView.date.millisecondsSince1970))
            self.editNewDateTextField.text = "".getTimeOrDateToString(dateInMillisec: editedExpense.date, format: globalDateFormats.dateFormatFullDate)
            
        }
        view.endEditing(true)
    }
    
    @objc func dismissToolbar(){
        self.editNewSubcategoryTextField.endEditing(true)
        self.editNewDateTextField.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == globalIdentificators.segueToChooseCategoryId {
            
        }
    }
}

extension PopUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {     ///////// picker view
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.subCategoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  self.subCategoryList[row].subcategoryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickedSubCategory = subCategoryList[row]
    }
}
