//
//  RegistrationPageViewController.swift
//  MeasurmentApp
//
//  Created by shubham mayekar on 27/06/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class RegistrationPageViewController: UIViewController {

    @IBOutlet weak var passTxtF: UITextField!
    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var userNameTxtF: UITextField!
    @IBOutlet weak var addressTxtF: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    
    let db = Firestore.firestore()
       
       var handle:AuthStateDidChangeListenerHandle?
       var userName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
               if let userEmail = user?.email{
                   self.userName = userEmail
               }
               
               }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func regBtnPressed(_ sender: Any) {
        
        if  let email = emailTxtF.text ,let password = passTxtF.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let Err = error {
                   let alert = UIAlertController(title: "Alert", message: Err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else{
                    
                    
                    if  let messageBody = self.userNameTxtF.text,let messageSender = self.addressTxtF.text, let mNo =  self.mobileNumber.text{
                        self.db.collection("UserDetails").document(self.userName ?? "default" ).setData(["Address":messageSender,"userName":messageBody,"mobileNumber":mNo]) { (error) in
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
                    
                    
                    
                    
                    

                        let alert = UIAlertController(title: "Alert", message:"Registration Successful", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
