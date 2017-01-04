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

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var item : ItemObject?
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var commentRef: FIRDatabaseReference?
    
    var comments: [CommentObject] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100
        

        commentRef = FIRDatabase.database().reference(withPath: "item-name/\((item?.title)!)/comments")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        commentRef?.observe(.value, with: { snapshot in
            var newComs: [CommentObject] = []
            
            for item in snapshot.children {
                let itemOb = CommentObject(snapshot: item as! FIRDataSnapshot)
                newComs.append(itemOb)
            }
            
            self.comments = newComs
            self.tableView.reloadData()
        })


    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        let comref = commentRef?.child(textField.text!)
        
        let comOb = CommentObject(title: self.textField.text!, createdAt: String(describing: NSDate()), createdBy: (FIRAuth.auth()?.currentUser?.email)!)

        comref?.setValue(comOb.toAnyObject())
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ComCell", for: indexPath) as! CommentsTableViewCell
        let itemOb = comments[indexPath.row]
        
        cell.commentLabel.text = itemOb.title
        cell.createdBy.text = itemOb.createdBy
        
        return cell
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
