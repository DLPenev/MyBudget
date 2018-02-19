//
//  SendFileOrUploadPhotoViewController.swift
//  My Budget
//
//  Created by MacUSER on 6.02.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit
import XMPPFramework

class SendFileOrUploadPhotoViewController: UIViewController {

    @IBOutlet var receiverTextField: UITextField!
    
    let xmppOutgoingFileTransfer = XMPPOutgoingFileTransfer()
    
    var jidVar = XMPPJID(string: "info-aqua-systems-com@xmpp.ipay.eu", resource: "yovko")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func sendTouchUpInside(_ sender: UIButton) {
        print("send touchupinside")
        let imageData = UIImagePNGRepresentation( #imageLiteral(resourceName: "richEmoji") ) as Data?
        
        self.xmppOutgoingFileTransfer.addDelegate(self, delegateQueue: DispatchQueue.main)
        self.xmppOutgoingFileTransfer.activate(XmppManager.singleton.xmppStream)
        
        do {
           try  self.xmppOutgoingFileTransfer.send(imageData, named: "LoreIpsum", toRecipient: jidVar, description: "LoreIpsumdolarsad!")
        } catch {
            print("=====")
            print(error)
        }
    }
    
}

extension SendFileOrUploadPhotoViewController : XMPPOutgoingFileTransferDelegate  {
    
    func xmppOutgoingFileTransferDidSucceed(_ sender: XMPPOutgoingFileTransfer!) {
        print("yay")
    }
    
    func xmppOutgoingFileTransfer(_ sender: XMPPOutgoingFileTransfer!, didFailWithError error: Error!) {
        print("didFailWithError : \(error)")
    }
    
    func xmppOutgoingFileTransferIBBClosed(_ sender: XMPPOutgoingFileTransfer!) {
        print("xmppOutgoingFileTransferIBBClosed")
    }
    
}

//extension SendFileOrUploadPhotoViewController : XMPPIncomingFileTransferDelegate  {
//    
//    func xmppIncomingFileTransfer(_ sender: XMPPIncomingFileTransfer!, didFailWithError error: Error!) {
//        print("didFailWithError")
//    }
//    
//    func xmppIncomingFileTransfer(_ sender: XMPPIncomingFileTransfer!, didReceiveSIOffer offer: XMPPIQ!) {
//        print("didReceiveSIOffer")
//    }
//    
//    func xmppIncomingFileTransfer(_ sender: XMPPIncomingFileTransfer!, didSucceedWith data: Data!, named name: String!) {
//        print("didSucceedWith")
//    }
//    
//}












