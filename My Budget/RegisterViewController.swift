//
//  RegisterViewController.swift
//  My Budget
//
//  Created by MacUSER on 11.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordAgainTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  emailTextField.placeholder.color = "#4EB8CE"
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.center.x -= view.bounds.width
        emailTextField.center.x += view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        passwordAgainTextField.center.x += view.bounds.width
        cancelButton.center.x += view.bounds.width
        cancelButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        submitButton.center.x -= view.bounds.width
        submitButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.usernameTextField.center.x += self.view.bounds.width
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [], animations: {
            self.emailTextField.center.x -= self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [], animations: {
            self.passwordTextField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.passwordAgainTextField.center.x -= self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
            self.submitButton.center.x += self.view.bounds.width
            self.submitButton.transform = CGAffineTransform.identity
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 1, options: [], animations: {
            self.cancelButton.center.x -= self.view.bounds.width
            self.cancelButton.transform = CGAffineTransform.identity
        }, completion: nil)
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
