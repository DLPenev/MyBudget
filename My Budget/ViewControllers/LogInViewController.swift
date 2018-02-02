//
//  LogInViewController.swift
//  My Budget
//
//  Created by MacUSER on 29.12.17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit
import XMPPFramework

class LogInViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let overviewTabViewControllerIndex      = 0
    let setUpCashFlowTabViewControllerIndex = 1
    
    var xmppStream: XMPPStream!
    let hostName: String = "xmpp.ipay.eu"
    let hostPort: UInt16 = 5222
    
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func streamConnect(jid: String){
        xmppStream = XMPPStream()
        self.xmppStream.hostName = hostName
        self.xmppStream.hostPort = hostPort
        xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
        xmppStream.myJID = XMPPJID(string: jid)
        
        do {
            try xmppStream.connect(withTimeout: 30)
        }
        catch {
            print("error occured in connecting")
        }
    }
    
    func streamAuth(password: String) {
        
        do {
            try xmppStream.authenticate(withPassword: password)
        }
        catch {
            print("catch")
        }
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
      
        guard let jid = emailTextField.text, let pass = passwordTextField.text else {
            print("no email and/or pass")
            return
        }
        password = pass
        streamConnect(jid: jid)
    }
}

extension LogInViewController: XMPPStreamDelegate {
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("DidConnect")
        streamAuth(password: password)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("DidAuthenticate")
        goToTabBar()
    }
    
    func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        print("DidDisconnect")
    }
}
