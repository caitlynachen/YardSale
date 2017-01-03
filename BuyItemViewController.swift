//
//  BuyItemViewController.swift
//  YardSale
//
//  Created by Caitlyn Chen on 1/2/17.
//  Copyright © 2017 Caitlyn Chen. All rights reserved.
//

import UIKit

class BuyItemViewController: UIViewController {
    
    var item: ItemObject?
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var address: UIButton!

    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.topItem?.title = item?.title
        address.setTitle(item?.addressStr, for: .normal)
        caption.text = item?.caption
        condition.text = item?.condition
      
//        price.text = String(describing: item?.price) as? String
        
        let url = URL(string: (item?.imageUrl)!)
        
        let data = NSData(contentsOf: url!)
        if data != nil{
            imageView.image = UIImage(data: data as! Data)
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func commentButtonTapped(_ sender: Any) {
    }
    
    @IBOutlet weak var addressButtonTapped: UIButton!
    

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
