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
    @IBOutlet var imageView: UIImageView!
    
    var pickedImage = UIImage()
    
    // MARK: - OutgoingFileTransfer

    
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
    
    // MARK: - ImageFileUpload
    
    @IBAction func upload(sender: AnyObject) {
        if let image = self.imageView.image {
            let imageData = UIImageJPEGRepresentation(image, 1.0)
            
            let urlString = "https://devs.icards.eu/gatekeeper/trunk/phone/request"
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
            
            mutableURLRequest.httpMethod = "POST"
            
            let boundaryConstant = "----------------12345";
            let contentType = "multipart/form-data;boundary=" + boundaryConstant
            mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
            
            // create upload data to send
            let uploadData = NSMutableData()

            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(image.description)\"; filename=\"file.png\"\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append(imageData!)
            uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
            
            mutableURLRequest.httpBody = uploadData as Data
            
            let task = session.dataTask(with: mutableURLRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    // Image uploaded
                    print("Image uploaded?")
                }
                print(response!)
            })
            
            task.resume()
            
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

extension SendFileOrUploadPhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    @IBAction func openImageGallery(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image_data
            self.dismiss(animated: true, completion: nil)
        }
        else {
            return
        }

    }
}













