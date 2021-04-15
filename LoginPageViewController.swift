//
//  LoginPageViewController.swift
//  MeasurmentApp
//
//  Created by shubham mayekar on 27/06/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit
import FirebaseAuth
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

class LoginPageViewController: UIViewController {

    @IBOutlet weak var passTxtF: UITextField!
    @IBOutlet weak var emailTxtF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnClick(_ sender: Any) {
        if  let email = emailTxtF.text , let password = passTxtF.text{
         Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
             if let Err = error{
                
                let alert = UIAlertController(title: "Alert", message: Err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                 
             }
             else
             {
                let next = self?.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                self?.navigationController?.pushViewController(next, animated: true)
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
