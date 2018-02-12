//
//  ViewController.swift
//  My Budget
//
//  Created by MacUSER on 8.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var logInButton: UIButton!
    @IBOutlet var registrationButton: UIButton!
    @IBOutlet var logInTopConstrain: NSLayoutConstraint!
    
    var logInPosition = CGFloat()
    var registrationPosition = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        DBManager.singleton.createDatabaseIfNotExists()
        setupCategories()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logInPosition                = self.logInButton.center.y
        self.registrationPosition         = self.registrationButton.center.y
        self.logInButton.transform        = CGAffineTransform(scaleX: 1500, y: 1500)
        self.registrationButton.transform = CGAffineTransform(scaleX: 1500, y: 1500)
        
        self.logInButton.alpha        = 0
        self.registrationButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.logInButton.center.y  = self.logInPosition
            self.logInButton.transform = CGAffineTransform.identity
            self.logInButton.alpha = 1
        }
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.registrationButton.center.y  = self.registrationPosition
            self.registrationButton.transform = CGAffineTransform.identity
            self.registrationButton.alpha = 1
        }, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCategories(){
        if allCategoryesArray.count == 0 {
            
            allCategoryesArray.append(Category(categoryPK: 1, categoryFullName: NSLocalizedString(globalStringsKeys.categoryFood, comment: ""), categoryIcon: #imageLiteral(resourceName: "category1Food"), categoryColor: globalMyColors.colorRed))
            allCategoryesArray.append(Category(categoryPK: 2, categoryFullName: NSLocalizedString(globalStringsKeys.categoryShopping, comment: ""), categoryIcon: #imageLiteral(resourceName: "category2Shoping"), categoryColor: globalMyColors.colorBlue))
            allCategoryesArray.append(Category(categoryPK: 3, categoryFullName: NSLocalizedString(globalStringsKeys.categoryHousing, comment: ""), categoryIcon: #imageLiteral(resourceName: "category3Housing"), categoryColor: globalMyColors.colorOrange))
            allCategoryesArray.append(Category(categoryPK: 4, categoryFullName: NSLocalizedString(globalStringsKeys.categoryTransportation, comment: ""), categoryIcon: #imageLiteral(resourceName: "category4Transportation"), categoryColor: globalMyColors.colorDarkGray))
            allCategoryesArray.append(Category(categoryPK: 5, categoryFullName: NSLocalizedString(globalStringsKeys.categoryVehicle, comment: ""), categoryIcon: #imageLiteral(resourceName: "category5Vehicle"), categoryColor: globalMyColors.colorPurple))
            allCategoryesArray.append(Category(categoryPK: 6, categoryFullName: NSLocalizedString(globalStringsKeys.categoryLife, comment: ""), categoryIcon: #imageLiteral(resourceName: "category6Life"), categoryColor: globalMyColors.colorGreen))
            allCategoryesArray.append(Category(categoryPK: 7, categoryFullName: NSLocalizedString(globalStringsKeys.categoryComunication, comment: ""), categoryIcon: #imageLiteral(resourceName: "category7Communication"), categoryColor: globalMyColors.colorDarkBlue))
            allCategoryesArray.append(Category(categoryPK: 8, categoryFullName: NSLocalizedString(globalStringsKeys.categoryFinancial, comment: ""), categoryIcon: #imageLiteral(resourceName: "category8Financial"), categoryColor: globalMyColors.colorSeaGreen))
            allCategoryesArray.append(Category(categoryPK: 9, categoryFullName: NSLocalizedString(globalStringsKeys.categoryInvestments, comment: ""), categoryIcon: #imageLiteral(resourceName: "category9Investments"), categoryColor: globalMyColors.colotPink))
            allCategoryesArray.append(Category(categoryPK: 10, categoryFullName: NSLocalizedString(globalStringsKeys.categoryOthers, comment: ""), categoryIcon: #imageLiteral(resourceName: "category10Other"), categoryColor: globalMyColors.colorGray))
            
        }

    }

}



