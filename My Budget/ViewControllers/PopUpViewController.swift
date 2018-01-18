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

    @IBOutlet var expenceValueTextField: UITextField!
    
    var selectedSubCategory = (pk : 0 , "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius  = 20
        popUpView.layer.masksToBounds = true
    }

    override func viewWillAppear(_ animated: Bool) {
        if selectedSubCategory.1 != "" {
            subCategoryLabel.text = selectedSubCategory.1
        }
    }
    
    @IBAction func okPressed(_ sender: UIButton) {
        if let valueEntered = expenceValueTextField.text {
            guard let value = Double(valueEntered) else {
                print("no value")
                return  //add alert value must be double
            }
            if selectedSubCategory.0 != 0 {
                DBManager.singleton.insertInExpenceTable(value: value, subcategory: selectedSubCategory.pk)
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
