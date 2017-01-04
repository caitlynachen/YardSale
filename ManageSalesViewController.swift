//
//  BuyViewController.swift
//  
//
//  Created by Caitlyn Chen on 12/21/16.
//
//

import UIKit
import Firebase
import FirebaseAuth

class ManageSalesViewController: UIViewController {

    override func viewDidLoad() {
        let ref = FIRDatabase.database().reference(withPath: "item-name")
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToManage(segue: UIStoryboardSegue){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
