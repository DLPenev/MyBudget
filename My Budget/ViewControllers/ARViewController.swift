//
//  ARViewController.swift
//  My Budget
//
//  Created by MacUSER on 19.02.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var arrayOfSumExpense = [SumExpense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sceneView.delegate = self
        sceneView.autoenablesDefaultLighting  = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }

    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            let planeAnchor = anchor as! ARPlaneAnchor
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: planeAnchor.center.y, z: planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
//            //grid view
//            let gridMaterial = SCNMaterial()
//            gridMaterial.diffuse.contents = #imageLiteral(resourceName: "grid") //UIImage(named: "Assets.xcassets/grid.png")
//            plane.materials = [gridMaterial]
//            planeNode.geometry = plane
//            //grid view
            
            node.addChildNode(planeNode)
            
            func createCylinderNode(height: Double, color: UIColor, xPosition: Double){
                let cylynder = SCNCylinder(radius: 0.02, height: CGFloat(height))
                let material = SCNMaterial()
                material.diffuse.contents = color
                cylynder.materials = [material]
                let node = SCNNode()
                node.transform = SCNMatrix4MakeRotation(Float.pi/2, 1, 0, 0)
                node.position = SCNVector3(x: planeNode.position.x + Float(xPosition) ,y: planeNode.position.y , z: Float(height/2))
                node.geometry = cylynder
                planeNode.addChildNode(node)
            }
            
            func createTitle(text: String, xPosition: Double,retreat: Double, color: UIColor){
                let text = SCNText(string: text, extrusionDepth: 0.6)

                let textMaterial = SCNMaterial()
                textMaterial.diffuse.contents = color
                text.materials = [textMaterial]
                let node3 = SCNNode()
                node3.transform = SCNMatrix4MakeRotation(Float.pi/2, 1, 0, 0)
                node3.scale = SCNVector3(0.003 , 0.003, 0.003 )
                node3.position = SCNVector3(x: planeNode.position.x - 0.15 + Float(xPosition),y: planeNode.position.y, z: planeNode.position.z - 0.06 - Float(retreat) )
                node3.geometry = text
                
                planeNode.addChildNode(node3)
            }

            var currentXPosition = -0.20
            var titleDistanceFromCylider = 0.0
            for i in arrayOfSumExpense {
                createCylinderNode(height: i.procentOfTotalExpense/150, color: i.categoryColor, xPosition: currentXPosition)
                createTitle(text: i.categoryFullName, xPosition: currentXPosition, retreat: titleDistanceFromCylider, color: i.categoryColor)
                currentXPosition += 0.10
                titleDistanceFromCylider -= -0.05
            }
        }
        else {
            return
        }
        
    }
    

}
