//
//  CommentViewController.swift
//  YardSale
//
//  Created by Caitlyn Chen on 1/2/17.
//  Copyright © 2017 Caitlyn Chen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class CommentViewController: UIViewController {

    var item : ItemObject?
    @IBOutlet weak var textField: UITextField!
    
    var ref: FIRStorageReference?
    var commentRef: FIRDatabaseReference?
//    var comrefs: FIRStorageReference?

//    var URLstr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let itemref = FIRStorage.storage().reference(withPath: "item-name")
//        comrefs = itemref.storage.reference(withPath: "comments")
        ref = FIRStorage.storage().reference(forURL: "gs://yardsale-cd99c.appspot.com/item-name")
        
//        let itemref = FIRDatabase.database().reference(withPath: "item-name")
//        let itemsRef = itemref.database.reference(withPath: (item?.title)!)
//        print((item?.title)!)
        commentRef = FIRDatabase.database().reference(withPath: "item-name/\((item?.title)!)/comments")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        let data = NSData()
        
        let comref = ref?.child(textField.text!)
        
        let uploadTask = comref?.put(data as Data, metadata: nil) { metadata, error in
            if error != nil {
                
            } else {
                
                let comOb = CommentObject(title: self.textField.text!, createdAt: String(describing: NSDate()), createdBy: (FIRAuth.auth()?.currentUser?.email)!)
//                self.commentRef?.child("comments").setValue(comOb.toAnyObject())
                self.commentRef?.updateChildValues(comOb.toAnyObject() as! [AnyHashable : Any])
                
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
