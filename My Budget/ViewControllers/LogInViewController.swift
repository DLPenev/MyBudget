//
//  LogInViewController.swift
//  My Budget
//
//  Created by MacUSER on 29.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit
import XMPPFramework
import GoogleSignIn
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate  {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate    = self
        self.passwordTextField.delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        XmppManager.singleton.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func goToTabBar(){
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: globalIdentificators.tabBarControllerId) as! TabBarViewController
        
        tabBarController.selectedViewController = tabBarController.viewControllers?[globalUserDefaults.cashFlowIsSet ? globalIndexes.overviewViewController : globalIndexes.setUpCashFlowViewController]
        present(tabBarController, animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        guard let jid  = emailTextField.text, let pass = passwordTextField.text  else {
            return
        }
    
        if  jid != "" &&  pass != "" {
       let easyLogIn = "info-\(jid)-systems-com@xmpp.ipay.eu" // i will remove this later
            
            XmppManager.singleton.xmppStream.myJID = XMPPJID(string: easyLogIn)  // replace easyLogIn with jid
            self.password = pass
            XmppManager.singleton.streamConnect()
        } else {
            print("no email and/or pass")
            return
        }
    }
}

extension LogInViewController: XMPPStreamDelegate {
    
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        XmppManager.singleton.streamAuth(password: password)
        print("DidConnect")
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("DidAuthenticate")
        goToTabBar()
    }
    
    func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        print("DidDisconnect")
    }

}

