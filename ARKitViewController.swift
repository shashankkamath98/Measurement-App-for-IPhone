//
//  ARKitViewController.swift
//  MeasurmentApp
//
//  Created by shubham mayekar on 27/06/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit
import ARKit
import Firebase

class ARKitViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var cmUpdateLable: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    var center : CGPoint!
    let ship = SCNScene(named: "art.scnassets/ship.scn")!.rootNode
    let db = Firestore.firestore()
    var handle:AuthStateDidChangeListenerHandle?
    var userName:String?
    
    var positions = [SCNVector3]()
    var dotNodes = [SCNNode]()
    var textNode = SCNNode()
    var total:Int?
    var calculation:Int?
    var measurementTypeAdd:String?
    var measurementLable:String?
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let hitTest = sceneView.hitTest(center, types: .featurePoint)
        let result = hitTest.last
        guard let transform = result?.worldTransform else {return}
        let thirdColumn = transform.columns.3
        let position = SCNVector3Make(thirdColumn.x, thirdColumn.y, thirdColumn.z)
        positions.append(position)
        let lastTenPositions = positions.suffix(10)
        ship.position = getAveragePosition(from: lastTenPositions)
        
    }
    
    func getAveragePosition(from positions : ArraySlice<SCNVector3>) -> SCNVector3 {
        
        var averageX : Float = 0
        var averageY : Float = 0
        var averageZ : Float = 0
        
        for position in positions {
            averageX += position.x
            averageY += position.y
            averageZ += position.z
        }
        let count = Float(positions.count)
        return SCNVector3Make(averageX / count , averageY / count, averageZ / count)
    }
    
    var isFirstPoint = true
    var points = [SCNNode]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let sphereGeometry = SCNSphere(radius:0.005)
        let sphereNode = SCNNode(geometry: sphereGeometry)
        sphereNode.position = ship.position
        sceneView.scene.rootNode.addChildNode(sphereNode)
        points.append(sphereNode)
        
        
        if isFirstPoint
        {
            isFirstPoint = false
        }
        else {
            //calculate the distance
            let pointA = points[points.count - 2]
            guard let pointB = points.last else {return}
            
            let d = distance(float3(pointA.position), float3(pointB.position))
            //add line
            
            let line = SCNGeometry.line(from: pointA.position, to: pointB.position)
            print(d.description)
            let  lineNode = SCNNode(geometry : line)
            sceneView.scene.rootNode.addChildNode(lineNode)
            
            //add midPoint
            
            let midPoint = (float3(pointA.position) + float3(pointB.position)) / 2
            let midPointGeometry = SCNSphere(radius: 0.003)
            midPointGeometry.firstMaterial?.diffuse.contents = UIColor.red
            let midPointNode = SCNNode (geometry: midPointGeometry)
            midPointNode.position = SCNVector3Make(midPoint.x, midPoint.y, midPoint.z)
            sceneView.scene.rootNode.addChildNode(midPointNode)
            print(midPointNode)
            
            //add text
            
            let textGeometry = SCNText(string: String(format: "%.0f", d * 100) + "cm", extrusionDepth:1)
            
            //*************************************************************************************
            calculation = Int(String(format: "%.0f", d * 100))
            print(calculation)
            calculate(pointVaule: calculation!)
            
            //            ****************************************************************************************
            let textNode = SCNNode(geometry: textGeometry)
            textNode.scale = SCNVector3Make(0.005, 0.005, 0.01)
            textGeometry.flatness = 0.2
            
            midPointNode.addChildNode(textNode)
            
            //Billboard contraints
            
            let constraints = SCNBillboardConstraint()
            constraints.freeAxes = .all
            midPointNode.constraints = [constraints]
            
            isFirstPoint = true
        }
       
    }
    
    func calculate(pointVaule:Int){
        
        total = pointVaule + total!
        print(total)
        DispatchQueue.main.async {
            self.cmUpdateLable.text = String(self.total ?? 0) + " cm" 
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        center = view.center
        sceneView.scene.rootNode.addChildNode(ship)
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        navigationController?.navigationBar.isHidden = true
        total = 0
        print(measurementTypeAdd ?? "null")
        
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        center = view.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        if let userEmail = user?.email{
            self.userName = userEmail
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func submitBtnClick(_ sender: Any) {
        print(total)
//        if  let messageBody = self.total,let messageSender = Auth.auth().currentUser?.email{
//            db.collection(userName ?? "default").addDocument(data: ["Username":messageSender,"Measurement":messageBody]) { (error) in
//                if let e = error{
//                    print(e)
//                }
//                else
//                {
//                    let alert = UIAlertController(title: "Alert", message: "Data Uploaded successfully", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//        }
        
        if  let messageBody = self.total,let messageSender = Auth.auth().currentUser?.email,let mea = self.measurementLable{
            db.collection(userName ?? "default").document(measurementTypeAdd!).setData(["Username":messageSender,"Length":messageBody,"measurmentLable":mea]) { (error) in
                if let e = error{
                    print(e)
                }
                else
                {
                    let alert = UIAlertController(title: "Alert", message: "Data Uploaded successfully", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
}

extension SCNGeometry  {
    
    class func line(from vectorA : SCNVector3, to vectorB: SCNVector3) ->SCNGeometry
    {
        let indices : [Int32] = [0,1]
        let source = SCNGeometrySource(vertices: [vectorA,vectorB])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        return SCNGeometry(sources: [source], elements: [element])
    }
    
}
// MARK: - ARSCNViewDelegate

/*
 // Override to create and configure nodes for anchors added to the view's session.
 func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
 let node = SCNNode()
 
 return node
 }
 */

func session(_ session: ARSession, didFailWithError error: Error) {
    // Present an error message to the user
    
}

func sessionWasInterrupted(_ session: ARSession) {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

func sessionInterruptionEnded(_ session: ARSession) {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
    
}
