//
//  BuyItemViewController.swift
//  YardSale
//
//  Created by Caitlyn Chen on 1/2/17.
//  Copyright © 2017 Caitlyn Chen. All rights reserved.
//

import UIKit
import MapKit

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
        
        navBar.topItem!.title = ""
        navBar.topItem!.title = item?.title
        address.setTitle(item?.addressStr, for: .normal)
        caption.text = item?.caption
        condition.text = item?.condition
        
        let prices = item?.price
        let priceString = String(format: "%.01f", prices!)
        
        price.text = priceString
        
        
        
        
        let url = URL(string: (item?.imageUrl)!)
        
        let data = NSData(contentsOf: url!)
        if data != nil{
            imageView.image = UIImage(data: data as! Data)
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func commentButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toCommentView", sender: self)
    }
    
    
    @IBAction func addressButtonTapped(_ sender: Any) {
        
        let latitude:CLLocationDegrees =  (item?.latCoor)!
        let longitude:CLLocationDegrees =  (item?.longCoor)!
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(item?.title)"
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCommentView"{
            let dvc = segue.destination as! CommentViewController
            dvc.item = self.item
//
//            dvc.URLstr = newString
//            print(newString)
            
            
            
        }
    }
    @IBAction func unwindToBuyItem(segue: UIStoryboardSegue){
        
    }
    
}
