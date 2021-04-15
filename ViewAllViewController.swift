//
//  ViewAllViewController.swift
//  MeasurmentApp
//
//  Created by Tech Tree on 25/07/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit

class ViewAllViewController: UIViewController {
    
    var dataModel:DataModle?
    var s1:Int?
    var s2:Int?
    var s3:Int?
    var s4:Int?
    var s5:Int?
    var s6:Int?
    var s7:Int?
    @IBOutlet weak var s1Txt: UILabel!
    @IBOutlet weak var s2Txt: UILabel!
    @IBOutlet weak var s3Txt: UILabel!
    @IBOutlet weak var s4Txt: UILabel!
    @IBOutlet weak var s5Txt: UILabel!
    @IBOutlet weak var s6Txt: UILabel!
    @IBOutlet weak var s7Txt: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(s1 ,s2 ,s3,s4,s5,s6,s7)
        
        s1Txt.text = String(s1 ?? 0)
        s2Txt.text = String(s2 ?? 0)

        s3Txt.text = String(s3 ?? 0)

        s4Txt.text = String(s4 ?? 0)
        s5Txt.text = String(s5 ?? 0)

        s6Txt.text = String(s6 ?? 0)

        s7Txt.text = String(s7 ?? 0)

        
    }
    

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func homeBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
