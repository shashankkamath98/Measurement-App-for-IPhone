//
//  OptionScreenViewController.swift
//  MeasurmentApp
//
//  Created by shubham mayekar on 02/07/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit

class OptionScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func waistToBtnClick(_ sender: Any) {
        
        
    }
    
    @IBAction func shoulderToBtnClick(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "aRKitViewController") as! ARKitViewController
        
        navigationController?.pushViewController(next, animated: true)
    }
    

}
