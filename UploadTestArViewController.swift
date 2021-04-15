//
//  UploadTestArViewController.swift
//  MeasurmentApp
//
//  Created by shubham mayekar on 28/06/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit
import Firebase

class UploadTestArViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    let db = Firestore.firestore()
    
    var handle:AuthStateDidChangeListenerHandle?
    var userName:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        if let userEmail = user?.email{
            self.userName = userEmail
        }
        
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }

    @IBAction func uploadBtn(_ sender: Any) {
//        if  let messageBody = textField.text,let messageSender = Auth.auth().currentUser?.email{
//            db.collection(userName ?? "default").addDocument(data: ["Username":messageSender,"userId":messageBody]) { (error) in
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
        
        
        if  let messageBody = textField.text,let messageSender = Auth.auth().currentUser?.email{
            db.collection(userName ?? "default").document("m1").setData(["Username":messageSender,"userId":messageBody]) { (error) in
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
