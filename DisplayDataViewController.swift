//
//  DisplayDataViewController.swift
//  MeasurmentApp
//
//  Created by shubham mayekar on 04/07/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit
import Firebase

class DisplayDataViewController: UIViewController {
    
    @IBOutlet weak var textView3: UILabel!
    @IBOutlet weak var textView1: UILabel!
    @IBOutlet weak var textView2: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    
    var measurment:Int?
    var userNmae:String?
    let db = Firestore.firestore()
    
    var handle:AuthStateDidChangeListenerHandle?
    var userName:String?
    var measurmentLable:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeBtn.layer.cornerRadius = 10
       // print("Load\(measurment)")
        textView2.text = String(measurment  ?? 0 ) + " cm"
       // textView1.text = userName ?? "Default"
        textView3.text = measurmentLable ?? "Default"
//        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//            if let userEmail = user?.email{
//                self.userNmae = userEmail
//            }
//
//        }
        
//        db.collection(userName ?? "").document("m1").getDocument { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else{
//                if querySnapshot != nil && querySnapshot!.exists{
//                    let data = querySnapshot?.data()
//                    print(data!["userId"])
//                    self.measurment = data!["userId"] as! String
////                    self.displayData()
//                }
//            }
//        }
//
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func homeBtnPressed(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
//    func displayData(){
//        if measurment != "" {
//            textView1.text = measurment
//
//        }
//
//        if userNmae != ""{
//            textView2.text = userNmae
//        }
//
//    }
    
}
