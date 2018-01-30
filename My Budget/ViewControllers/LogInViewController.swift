//
//  LogInViewController.swift
//  My Budget
//
//  Created by MacUSER on 29.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    let overviewTabViewControllerIndex      = 0
    let setUpCashFlowTabViewControllerIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToTabBar(){
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: tabBarControllerId) as! TabBarViewController
        let budgetCashFlowIsSet = UserDefaults.standard.bool(forKey: "cashFlowIsSet")
        tabBarController.selectedViewController = tabBarController.viewControllers?[budgetCashFlowIsSet ? overviewTabViewControllerIndex : setUpCashFlowTabViewControllerIndex]
        present(tabBarController, animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        goToTabBar()
    }
    
    

}
