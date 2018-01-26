//
//  PopUpViewController.swift
//  My Budget
//
//  Created by MacUSER on 13.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var popUpView: UIView!
    
    @IBAction func unwindToPopUpViewController(segue: UIStoryboardSegue){}
    @IBOutlet var subCategoryLabel: UILabel!

    @IBOutlet var popoverTitle: UILabel!
    @IBOutlet var expenseValueTextField: UITextField!
    
    var isExpensePopUp = true
    var selectedSubCategory = (pk : 0 , "")
    var myDelegate: testProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius  = 20
        popUpView.layer.masksToBounds = true
    }

    override func viewWillAppear(_ animated: Bool) {
        if isExpensePopUp {    //////made that short
           popoverTitle.text = "Expense"
        }  else {
            popoverTitle.text = "Income"
        }
        
        
        if selectedSubCategory.1 != "" {
            subCategoryLabel.text = selectedSubCategory.1
        }
    }
    
    @IBAction func okPressed(_ sender: UIButton) {
        if let valueEntered = expenseValueTextField.text {
            guard let value = Double(valueEntered) else {
                print("no value")
                return  //add alert value must be double
            }
            if selectedSubCategory.0 != 0 {
                DBManager.singleton.insertInExpenseTable(value: value, subcategory: selectedSubCategory.pk)
                myDelegate?.setStatusAndRefreshTableView()
                dismiss(animated: true, completion: nil)
            } else {
                // shake animation
                print("did not select category")
            }
        }
    }
    
    @IBAction func cancelPopUp(_ sender: Any) {

        dismiss(animated: true)
    }
    

}
