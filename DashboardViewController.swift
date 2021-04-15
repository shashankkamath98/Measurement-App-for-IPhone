//
//  DashboardViewController.swift
//  MeasurmentApp
//
//  Created by shubham mayekar on 27/06/20.
//  Copyright © 2020 imbatman. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


struct DataModle {
    var s1:Int?
    var s2:Int?
    var s3:Int?
    var s4:Int?
    var s5:Int?
    var s6:Int?
}

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var viewAllBtnOut: UIButton!
    @IBOutlet weak var userNameLable: UILabel!
    let db = Firestore.firestore()
    // var ref: DatabaseReference!
    var userName:String?
    var measurmentType:String?
    var measurmentDisplayType:String?
    var temp:Int?
    var measurementLable:String?
    var dataModel:DataModle? = nil
    
    
    var handle:AuthStateDidChangeListenerHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAllBtnOut.isUserInteractionEnabled = true
        
        //  ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewAllBtnOut.isUserInteractionEnabled = true
        
        navigationController?.navigationBar.backgroundColor = .clear
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let userEmail = user?.email{
                self.userNameLable.text = userEmail
                self.userName = userEmail
            }
            
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    @IBAction func startCameraBtn(_ sender: UIButton) {
        
        //        let next = self.storyboard?.instantiateViewController(withIdentifier: "aRKitViewController") as! ARKitViewController
        //        navigationController?.pushViewController(next, animated: true)
        
        
        switch sender.tag {
        case 1:
            measurmentType = "s1"
            measurementLable = "Shoulder to Shoulder"
            
            break
            
        case 2:
            measurmentType = "s2"
            measurementLable = "Shoulder to Wasit"
            break
        case 3:
            measurmentType = "s3"
            measurementLable = "Shoulder to elbow"
            break
        case 4:
            measurmentType = "s4"
            measurementLable = "Shoulder to Wrists"
            break
        case 5:
            measurmentType = "s5"
            measurementLable = "Waist to Knee"
            break
        case 6:
            measurmentType = "s6"
            measurementLable = "Waist to Ankle"
            break
        case 7:
            measurmentType = "s7"
            measurementLable = "Waist to Waist"
            break
        default:
            measurmentType = "sD"
            measurementLable = ".."
            break
        }
        
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "aRKitViewController") as! ARKitViewController
        
        next.measurementTypeAdd = self.measurmentType
        next.measurementLable = self.measurementLable
        navigationController?.pushViewController(next, animated: true)
        
    }
    @IBAction func mScrrenbtn(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "optionScreenViewController") as! OptionScreenViewController
        
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    @IBAction func viewRecordsBtn(_ sender: UIButton) {
        //        db.collection(userName ?? "default").getDocuments() { (querySnapshot, err) in
        //            if let err = err {
        //                print("Error getting documents: \(err)")
        //            } else {
        //                for document in querySnapshot!.documents {
        //                    print("\(document.documentID) => \(document.data())")
        //                    print(document.data())
        //                     let userDict = document.data()
        //                    print(userDict["Username"])
        //
        //
        //                }
        //            }
        //        }
        
        
        switch sender.tag {
        case 1:
            measurmentDisplayType = "s1"
            break
            
        case 2:
            measurmentDisplayType = "s2"
            break
        case 3:
            measurmentDisplayType = "s3"
            break
        case 4:
            measurmentDisplayType = "s4"
            break
        case 5:
            measurmentDisplayType = "s5"
            break
        case 6:
            measurmentDisplayType = "s6"
            break
        case 7:
            measurmentDisplayType = "s7"
            break
        default:
            measurmentDisplayType = "sD"
            break
        }
        
        
        
        db.collection(userName ?? "").document(measurmentDisplayType!).getDocument { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else{
                if querySnapshot != nil && querySnapshot!.exists{
                    let data = querySnapshot?.data()
                    self.temp = data!["Length"] as? Int
                    let next = self.storyboard?.instantiateViewController(withIdentifier: "displayDataViewController") as! DisplayDataViewController
                    next.measurment = data!["Length"] as? Int
                    next.userName = data!["Username"] as? String
                    next.measurmentLable = data!["measurmentLable"]as? String
                    self.navigationController?.pushViewController(next, animated: true)
                    
                }
            }
        }
        //
        //        let citiesRef = db.collection("UserName")
        //
        //               // Create a query against the collection.
        //               let query = citiesRef.whereField("UserName", isEqualTo: "op@op.com")
        //        print(query.addSnapshotListener(includeMetadataChanges: true, listener: { (<#QuerySnapshot?#>, <#Error?#>) in
        //            <#code#>
        //        }))
        
    }
    
    @IBAction func testBtn(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "uploadTestArViewController") as! UploadTestArViewController
        navigationController?.pushViewController(next, animated: true)
        
    }
    @IBAction func logOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
    
    @IBAction func feedBackBtnTapped(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "feedBackViewController") as! FeedBackViewController
        navigationController?.pushViewController(next, animated: true)
    }
    @IBAction func viewAllBtnTapped(_ sender: Any) {
        
        viewAllBtnOut.isUserInteractionEnabled = false
        var s1:Int?
        var s2:Int?
        var s3:Int?
        var s4:Int?
        var s5:Int?
        var s6:Int?
        var s7:Int?
        db.collection(userName ?? "").document("s1").getDocument { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else{
                if querySnapshot != nil && querySnapshot!.exists{
                    let data = querySnapshot?.data()
                    s1 = data!["Length"] as? Int
                    self.db.collection(self.userName ?? "").document("s2").getDocument { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else{
                            if querySnapshot != nil && querySnapshot!.exists{
                                let data = querySnapshot?.data()
                                s2 = data!["Length"] as? Int
                                self.db.collection(self.userName ?? "").document("s4").getDocument { (querySnapshot, err) in
                                    if let err = err {
                                        print("Error getting documents: \(err)")
                                    } else{
                                        if querySnapshot != nil && querySnapshot!.exists{
                                            let data = querySnapshot?.data()
                                            s3 = data!["Length"] as? Int
                                            self.db.collection(self.userName ?? "").document("s4").getDocument { (querySnapshot, err) in
                                                if let err = err {
                                                    print("Error getting documents: \(err)")
                                                } else{
                                                    if querySnapshot != nil && querySnapshot!.exists{
                                                        let data = querySnapshot?.data()
                                                        s4 = data!["Length"] as? Int
                                                        self.db.collection(self.userName ?? "").document("s5").getDocument { (querySnapshot, err) in
                                                            if let err = err {
                                                                print("Error getting documents: \(err)")
                                                            } else{
                                                                if querySnapshot != nil && querySnapshot!.exists{
                                                                    let data = querySnapshot?.data()
                                                                    s5 = data!["Length"] as? Int
                                                                    self.db.collection(self.userName ?? "").document("s6").getDocument { (querySnapshot, err) in
                                                                        if let err = err {
                                                                            print("Error getting documents: \(err)")
                                                                        } else{
                                                                            if querySnapshot != nil && querySnapshot!.exists{
                                                                            let data = querySnapshot?.data()
                                                                            s6 = data!["Length"] as? Int
                                                                            self.db.collection(self.userName ?? "").document("s7").getDocument { (querySnapshot, err) in
                                                                                if let err = err {
                                                                                    print("Error getting documents: \(err)")
                                                                                } else{
                                                                                    if querySnapshot != nil && querySnapshot!.exists{
                                                                                        let data = querySnapshot?.data()
                                                                                        s7 = data!["Length"] as? Int
                                                                           
                                                                                        
                                                                                        
                                                                                        if let next = self.storyboard?.instantiateViewController(withIdentifier: "viewAllViewController") as? ViewAllViewController{
                                                                                            next.s1 = s1
                                                                                            next.s2 = s2
                                                                                            next.s3 = s3
                                                                                            next.s4 = s4
                                                                                            next.s5 = s5
                                                                                            next.s6 = s6
                                                                                            next.s7 = s7
                                                                                            
                                                                                            self.navigationController?.pushViewController(next, animated: true)
                                                                                            
                                                                                        }
                                                                                        //                    next.measurment = data!["Length"] as? Int
                                                                                        //                    next.userName = data!["Username"] as? String
                                                                                        //                    next.measurmentLable = data!["measurmentLable"]as? String
                                                                                        
                                                                                        
                                                                                    }
                                                                                }
                                                                            }
                                                                            
                                                                            
                                                                            
                                                                            

                                                                        }
                                                                    }
                                                                    
                                                                    //let next = self.storyboard?.instantiateViewController(withIdentifier: "displayDataViewController") as! DisplayDataViewController
                                                                    //                    next.measurment = data!["Length"] as? Int
                                                                    //                    next.userName = data!["Username"] as? String
                                                                    //                    next.measurmentLable = data!["measurmentLable"]as? String
                                                                    //                    self.navigationController?.pushViewController(next, animated: true)
                                                                    
                                                                }
                                                            }
                                                        }
                                                        
                                                        //let next = self.storyboard?.instantiateViewController(withIdentifier: "displayDataViewController") as! DisplayDataViewController
                                                        //                    next.measurment = data!["Length"] as? Int
                                                        //                    next.userName = data!["Username"] as? String
                                                        //                    next.measurmentLable = data!["measurmentLable"]as? String
                                                        //                    self.navigationController?.pushViewController(next, animated: true)
                                                        
                                                    }
                                                }
                                            }
                                            
                                            //let next = self.storyboard?.instantiateViewController(withIdentifier: "displayDataViewController") as! DisplayDataViewController
                                            //                    next.measurment = data!["Length"] as? Int
                                            //                    next.userName = data!["Username"] as? String
                                            //                    next.measurmentLable = data!["measurmentLable"]as? String
                                            //                    self.navigationController?.pushViewController(next, animated: true)
                                            
                                        }
                                    }
                                }
                                
                                //let next = self.storyboard?.instantiateViewController(withIdentifier: "displayDataViewController") as! DisplayDataViewController
                                //                    next.measurment = data!["Length"] as? Int
                                //                    next.userName = data!["Username"] as? String
                                //                    next.measurmentLable = data!["measurmentLable"]as? String
                                //                    self.navigationController?.pushViewController(next, animated: true)
                                
                            }
                        }
                    }
                    
                    //let next = self.storyboard?.instantiateViewController(withIdentifier: "displayDataViewController") as! DisplayDataViewController
                    //                    next.measurment = data!["Length"] as? Int
                    //                    next.userName = data!["Username"] as? String
                    //                    next.measurmentLable = data!["measurmentLable"]as? String
                    //                    self.navigationController?.pushViewController(next, animated: true)
                    
                }
            }
        }
        
        print()
        
    }
    
}
}
