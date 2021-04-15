//
//  FeedBackViewController.swift
//  MeasurmentApp
//
//  Created by Tech Tree on 24/07/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit
import Firebase


class FeedBackViewController: UIViewController {

    @IBOutlet weak var feedBackTextViewOut: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    
    var userName:String?
    var db = Firestore.firestore()
    var handle:AuthStateDidChangeListenerHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.layer.cornerRadius = 10
        hideKeyboardWhenTappedAround()
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        if let userEmail = user?.email{
            self.userName = userEmail
        }
        
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitBtnClick(_ sender: Any) {
        
        print(feedBackTextViewOut.text)
        
        if  let messageBody = self.feedBackTextViewOut.text,let messageSender = self.userName{
            self.db.collection("FEEDBACK").document(self.userName ?? "default" ).setData(["UserName":messageSender,"Feedback":messageBody]) { (error) in
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

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
