//
//  ViewController.swift
//  MeasurmentApp
//
//  Created by shubham mayekar on 27/06/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    @IBAction func loginBtnClick(_ sender: Any) {
      
        let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
        navigationController?.pushViewController(next, animated: true)


    }
    
    @IBAction func regBtnClick(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationPageViewController") as! RegistrationPageViewController
        navigationController?.pushViewController(next, animated: true)
    }
}

