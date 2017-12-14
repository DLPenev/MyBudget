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
    
    
    @IBAction func cancelPopUp(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius  = 20
        popUpView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
