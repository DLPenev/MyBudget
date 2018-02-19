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
    
    
    
    var xmppIncomingFileTransfer = XMPPIncomingFileTransfer()
    
    
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
    
    func prepareForIncomingFileTransfer(){
                self.xmppIncomingFileTransfer.activate(xmppStream)
                self.xmppIncomingFileTransfer.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
}

extension XmppManager : XMPPIncomingFileTransferDelegate {
    
    func xmppIncomingFileTransfer(_ sender: XMPPIncomingFileTransfer!, didFailWithError error: Error!) {
        print("didFailWithError")
    }
    
    func xmppIncomingFileTransfer(_ sender: XMPPIncomingFileTransfer!, didReceiveSIOffer offer: XMPPIQ!) {
        print("didReceiveSIOffer")
        xmppIncomingFileTransfer.acceptSIOffer(offer)
    }
    
    func xmppIncomingFileTransfer(_ sender: XMPPIncomingFileTransfer!, didSucceedWith data: Data!, named name: String!) {
        print("didSucceedWith")
        var recivedImage = UIImage()
        if let convertedDataToUIImage = data {
            recivedImage = UIImage(data: convertedDataToUIImage)!
        }
    }
    
    
    
}
