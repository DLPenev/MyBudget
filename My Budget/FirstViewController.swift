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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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


}

