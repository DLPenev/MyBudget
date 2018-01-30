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
    
    var logInPosition: CGFloat!
    var registrationPosition: CGFloat!
    
    let colorRed      = UIColor(red:1.00, green:0.07, blue:0.07, alpha:1.0)
    let colorBlue     = UIColor(red:0.16, green:0.79, blue:0.97, alpha:1.0)
    let colorOrange   = UIColor(red:1.00, green:0.72, blue:0.27, alpha:1.0)
    let colorDarkGray = UIColor(red:0.36, green:0.43, blue:0.49, alpha:1.0)
    let colorPurple   = UIColor(red:0.74, green:0.11, blue:0.98, alpha:1.0)
    let colorGreen    = UIColor(red:0.05, green:0.90, blue:0.02, alpha:1.0)
    let colorDarkBlue = UIColor(red:0.16, green:0.45, blue:0.65, alpha:1.0)
    let colorSeaGreen = UIColor(red:0.10, green:0.74, blue:0.61, alpha:1.0)
    let colotPink     = UIColor(red:0.98, green:0.19, blue:0.62, alpha:1.0)
    let colorGray     = UIColor(red:0.67, green:0.70, blue:0.73, alpha:1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        DBManager.singleton.createDatabase()
        setupCategories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logInPosition                = self.logInButton.center.y
        registrationPosition         = self.registrationButton.center.y
        logInButton.transform        = CGAffineTransform(scaleX: 1500, y: 1500)
        registrationButton.transform = CGAffineTransform(scaleX: 1500, y: 1500)
        
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
            allCategoryesArray.append(Category(categoryPK: 1, categoryFullName: "Food & Drinks", categoryIcon: #imageLiteral(resourceName: "category1Food"), categoryColor: colorRed))
            allCategoryesArray.append(Category(categoryPK: 2, categoryFullName: "Shopping", categoryIcon: #imageLiteral(resourceName: "category2Shoping"), categoryColor: colorBlue))
            allCategoryesArray.append(Category(categoryPK: 3, categoryFullName: "Housing", categoryIcon: #imageLiteral(resourceName: "category3Housing"), categoryColor: colorOrange))
            allCategoryesArray.append(Category(categoryPK: 4, categoryFullName: "Transportation", categoryIcon: #imageLiteral(resourceName: "category4Transportation"), categoryColor: colorDarkGray))
            allCategoryesArray.append(Category(categoryPK: 5, categoryFullName: "Vehicle", categoryIcon: #imageLiteral(resourceName: "category5Vehicle"), categoryColor: colorPurple))
            allCategoryesArray.append(Category(categoryPK: 6, categoryFullName: "Life & Entertainment", categoryIcon: #imageLiteral(resourceName: "category6Life"), categoryColor: colorGreen))
            allCategoryesArray.append(Category(categoryPK: 7, categoryFullName: "Communication, PC", categoryIcon: #imageLiteral(resourceName: "category7Communication"), categoryColor: colorDarkBlue))
            allCategoryesArray.append(Category(categoryPK: 8, categoryFullName: "Financial expenses", categoryIcon: #imageLiteral(resourceName: "category8Financial"), categoryColor: colorSeaGreen))
            allCategoryesArray.append(Category(categoryPK: 9, categoryFullName: "Investments", categoryIcon: #imageLiteral(resourceName: "category9Investments"), categoryColor: colotPink))
            allCategoryesArray.append(Category(categoryPK: 10, categoryFullName: "Others", categoryIcon: #imageLiteral(resourceName: "category10Other"), categoryColor: colorGray))
        }

 
        
    }


}

