//
//  ViewController.swift
//  My Budget
//
//  Created by MacUSER on 8.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logInButton.center.y -= view.bounds.height
        logInButton.transform = CGAffineTransform(scaleX: 6, y: 6)
        registrationButton.center.y += view.bounds.height
        registrationButton.transform = CGAffineTransform(scaleX: 12, y: 12)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.logInButton.center.y += self.view.bounds.height
            self.logInButton.transform = CGAffineTransform.identity
        }
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.registrationButton.center.y -= self.view.bounds.height
            self.registrationButton.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

