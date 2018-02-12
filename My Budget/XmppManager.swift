//
//  XmppManager.swift
//  My Budget
//
//  Created by MacUSER on 6.02.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import Foundation
import UIKit
import XMPPFramework

class XmppManager: NSObject  {
    
    static let singleton: XmppManager = XmppManager()

    var xmppStream:XMPPStream = XMPPStream()
    let hostName: String = "xmpp.ipay.eu"
    let hostPort: UInt16 = 5222
    
    override init() {
        self.xmppStream.hostName = hostName
        self.xmppStream.hostPort = hostPort
    }
    
    func streamConnect(){

        do {
            try xmppStream.connect(withTimeout: 30)
        }
        catch {
            print("error occured in connecting")
        }
    }
    
    func streamAuth(password: String){
        do {
            try xmppStream.authenticate(withPassword: password)
        }
        catch {
            print("fail authenticate")
        }
    }
    
}

