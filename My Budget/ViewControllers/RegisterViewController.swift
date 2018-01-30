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
    
    @IBOutlet var usernameTextFieldLeftConstant: NSLayoutConstraint!
    @IBOutlet var userNameTextFieldRightConstant: NSLayoutConstraint!
    @IBOutlet var emailTextFieldRightConstant: NSLayoutConstraint!
    @IBOutlet var emailTextFieldLeftConstant: NSLayoutConstraint!
    @IBOutlet var passwordTextFieldLeftConstant: NSLayoutConstraint!
    @IBOutlet var passwordTextFieldRightConstant: NSLayoutConstraint!
    @IBOutlet var passwordAgainLeftConstant: NSLayoutConstraint!
    @IBOutlet var passwordAgainRightConstant: NSLayoutConstraint!
    
    var textFieldspositionX: CGFloat!
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldspositionX              = self.usernameTextField.center.x

        self.userNameTextFieldRightConstant.constant +=  400
        self.emailTextFieldLeftConstant.constant += 400
        self.passwordTextFieldRightConstant.constant += 400
        self.passwordAgainLeftConstant.constant += 400

        cancelButton.center.x           += view.bounds.width
        cancelButton.transform          = CGAffineTransform(rotationAngle: CGFloat.pi)
        submitButton.center.x           -= view.bounds.width
        submitButton.transform          = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        self.submitButton.alpha = 0
        self.cancelButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.userNameTextFieldRightConstant.constant -=  400
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [], animations: {
            self.emailTextFieldLeftConstant.constant -= 400
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [], animations: {
            self.passwordTextFieldRightConstant.constant -=  400
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.passwordAgainLeftConstant.constant -=  400
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.submitButton.center.x += self.view.bounds.width
            self.submitButton.transform = CGAffineTransform.identity
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
            self.cancelButton.center.x -= self.view.bounds.width
            self.cancelButton.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: [], animations: {
            self.submitButton.alpha = 1
            self.cancelButton.alpha = 1
        }, completion: nil)
        
    }


}
