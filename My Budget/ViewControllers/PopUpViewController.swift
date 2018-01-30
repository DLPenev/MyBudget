//
//  PopUpViewController.swift
//  My Budget
//
//  Created by MacUSER on 13.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
   // MARK: - general outlets and variables
    
    @IBOutlet var popupAddExpense: UIView!
    @IBOutlet var popupAddIncome: UIView!
    @IBOutlet var popupEditExpense: UIView!
    @IBAction func unwindToPopUpViewController(segue: UIStoryboardSegue){}
    let cornerRadius: CGFloat = 20
    


    var popupDelegate: PopupDelegate?
 
   
    var popupViewIndex = popupIndexEdit

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
    var editedExpense: Expense!
    var isDatePicker: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customPopupUI(viewIndex: popupViewIndex)
    }

    override func viewWillAppear(_ animated: Bool) {
        if popupViewIndex == popupIndexExpense {
            willAppearAddExpensePopup()
        } else if popupViewIndex == popupIndexIncome {
            
        } else {                            // popup edit
            willAppearEditPopup()
            subCategoryList = DBManager.singleton.loadSubCategories(categoryId: editedExpense.categoryId)
        }
    }
    
    // MARK: - PopoverAddExpense func and actions
    
    @IBAction func addExpenseOkPressed(_ sender: UIButton) {
        if let valueEntered = expenseValueTextField.text {
            guard let value = Double(valueEntered) else {
                print("no value")
                return  //add alert value must be double
            }
            if selectedSubCategory.pk != 0 {
                DBManager.singleton.insertInExpenseTable(value: value, subcategory: selectedSubCategory.pk)
                popupDelegate?.setNewValuesAndRefreshTableView()
                dismiss(animated: true, completion: nil)
            } else {
                // shake animation
                print("did not select category")
            }
        }
    }
    
    @IBAction func AddExpenseCanselTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func willAppearAddExpensePopup(){
        if selectedSubCategory.name != "" {
            subCategoryLabel.text = selectedSubCategory.name
        }
    }
    
    // MARK: - PopoverAddIncome func and actions
    
    @IBAction func addIncomeCancelTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - PopoverEdit func and actions
    

    
    @IBAction func editOkTouchUpInside(_ sender: UIButton) {
        if let hasValue = editNewValueTextField.text {
            guard let newValue = Double(hasValue) else {
                print("no value")
                editNewValueTextField.attributedPlaceholder = NSAttributedString(string: "Enter Value", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                return
            }
            editedExpense.value = newValue
        }
        DBManager.singleton.updateExpense(value: editedExpense.value, subcategory: editedExpense.subCategoryId, date: editedExpense.date, expenseId: editedExpense.expenseId)
        popupDelegate?.setNewValuesAndRefreshTableView()
        dismiss(animated: true)
    }
    
    @IBAction func editCancelTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func editSubcategoryTextFiledDidBegin(_ sender: UITextField) {
        isDatePicker = false
        createSubcategoryPickerView()
    }
    
    @IBAction func editDateTextFieldDidBegin(_ sender: UITextField) {
        isDatePicker = true
        createDatePicker()
    }
    
    func willAppearEditPopup(){
        editNewValueTextField.text = Global.singleton.doubleFormater(value: editedExpense.value)
        editNewSubcategoryTextField.text = editedExpense.subcategoryName
        editNewDateTextField.text = Global.singleton.getTimeOrDateToString(dateInMillisec:  editedExpense.date, format: dateFormatFullDate)
    }
    
    // MARK: - func and actions for All Popovers
    
    func customPopupUI(viewIndex: Int){
        
        if viewIndex == popupIndexExpense {
            self.view.addSubview(popupAddExpense)
            self.popupAddExpense.center = CGPoint(x: view.frame.size.width / 2, y : view.frame.size.height / 3)
            popupAddExpense.layer.cornerRadius   = cornerRadius
            popupAddExpense.layer.masksToBounds  = true
            
        } else if viewIndex == popupIndexIncome {
            self.view.addSubview(popupAddIncome)
            self.popupAddIncome.center = CGPoint(x: view.frame.size.width / 2, y : view.frame.size.height / 3)
            popupAddIncome.layer.cornerRadius    = cornerRadius
            popupAddIncome.layer.masksToBounds   = true
            
        } else {                    //popupEditExpense
            self.view.addSubview(popupEditExpense)
            self.popupEditExpense.center = CGPoint(x: view.frame.size.width / 2, y : view.frame.size.height / 3)
            popupEditExpense.layer.cornerRadius  = cornerRadius
            popupEditExpense.layer.masksToBounds = true
        }
    }
    
    func createSubcategoryPickerView(){
        let subCategoryView = UIPickerView()
        subCategoryView.delegate = self
        editNewSubcategoryTextField.inputView = subCategoryView
        createToolbar()
    }
    
    func createDatePicker(){
        datePickerView.datePickerMode = .date
        datePickerView.maximumDate = Date()
        editNewDateTextField.inputView = datePickerView
        createToolbar()
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target :self, action: #selector(PopUpViewController.doneBarButtonItem))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target :self, action: #selector(PopUpViewController.dismissToolbar))
        
        toolBar.setItems([doneButton, cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        editNewSubcategoryTextField.inputAccessoryView = toolBar
        editNewDateTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneBarButtonItem(){
        
        if !isDatePicker {
            editedExpense.subCategoryId = pickedSubCategory.subcategoryId
            editedExpense.subcategoryName = pickedSubCategory.subcategoryName
            editNewSubcategoryTextField.text = pickedSubCategory.subcategoryName
        } else {
            editedExpense.date = (CLongLong(datePickerView.date.millisecondsSince1970))
            editNewDateTextField.text = Global.singleton.getTimeOrDateToString(dateInMillisec: editedExpense.date, format: dateFormatFullDate)
        }

        view.endEditing(true)
    }
    
    @objc func dismissToolbar(){
        editNewSubcategoryTextField.endEditing(true)
        editNewDateTextField.endEditing(true)
    }
}

extension PopUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {     ///////// picker view
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subCategoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  subCategoryList[row].subcategoryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedSubCategory = subCategoryList[row]
    }
}
