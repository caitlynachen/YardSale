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

class ManageSalesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var items: [ItemObject] = []
    let ref = FIRDatabase.database().reference(withPath: "item-name")


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        self.tableView.rowHeight = 144

        
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
        let query = ref.queryOrdered(byChild: "addedByUser").queryEqual(toValue: FIRAuth.auth()?.currentUser?.email!)
        query.observe(.value, with: { snapshot in
            var newItems: [ItemObject] = []
            
            for item in snapshot.children {
                let itemOb = ItemObject(snapshot: item as! FIRDataSnapshot)
                newItems.append(itemOb)
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
        

        // Do any additional setup after loading the view.
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    var itemRow: Int?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ManageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "manCell", for: indexPath) as! ManageTableViewCell
        let itemOb = items[indexPath.row]
        
        let url = URL(string: itemOb.imageUrl)
        
        let data = NSData(contentsOf: url!)
        if data != nil{
            cell.imgView.image = UIImage(data: data as! Data)
        }
        itemRow = indexPath.row
        
        cell.titleLabel.text = itemOb.title
        cell.priceLabel.text = String(itemOb.price)
        cell.conditionLabel.text = itemOb.condition
        cell.addressLabel.text = itemOb.addressStr
        cell.soldButton.addTarget(self, action: #selector(self.soldButtonClicked), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let actionSheetController: UIAlertController = UIAlertController()
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            }
            actionSheetController.addAction(cancelAction)
            let takePictureAction: UIAlertAction = UIAlertAction(title: "Delete", style: .default) { action -> Void in
                let deleteAlert: UIAlertController = UIAlertController(title: "Confirm Deletion.", message: "Delete?", preferredStyle: .alert)
                
                let dontDeleteAction: UIAlertAction = UIAlertAction(title: "Don't Delete", style: .cancel) { action -> Void in
                }
                deleteAlert.addAction(dontDeleteAction)
                let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .default) { action -> Void in
                    
                    let itemOb = self.items[indexPath.row]
                    itemOb.ref?.removeValue()
                }
                deleteAlert.addAction(deleteAction)
                
                
                self.present(deleteAlert, animated: true, completion: nil)
            }
            actionSheetController.addAction(takePictureAction)
            self.present(actionSheetController, animated: true, completion: nil)
            
        }
    }
    
    func soldButtonClicked(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController()
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Sell", style: .default) { action -> Void in
            let deleteAlert: UIAlertController = UIAlertController(title: "Confirm Sale.", message: "Sell?", preferredStyle: .alert)
            
            let dontDeleteAction: UIAlertAction = UIAlertAction(title: "Don't Sell", style: .cancel) { action -> Void in
            }
            deleteAlert.addAction(dontDeleteAction)
            let deleteAction: UIAlertAction = UIAlertAction(title: "Sell", style: .default) { action -> Void in
                
                let itemOb = self.items[self.itemRow!]
                itemOb.ref?.removeValue()
            }
            deleteAlert.addAction(deleteAction)
            
            
            self.present(deleteAlert, animated: true, completion: nil)
        }
        actionSheetController.addAction(takePictureAction)
        self.present(actionSheetController, animated: true, completion: nil)
        
       
        
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
