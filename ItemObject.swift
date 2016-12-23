//
//  ItemObject.swift
//  YardSale
//
//  Created by Caitlyn Chen on 12/21/16.
//  Copyright © 2016 Caitlyn Chen. All rights reserved.
//

import UIKit
import Firebase
import Foundation

struct ItemObject {
    
    let key: String
    
    let title: String
    let imageUrl: String
    let caption: String
    let price: Double
    let condition: String
    let createdAt: String
    
    let ref: FIRDatabaseReference?


    init (title: String, price: Double, condition: String, caption: String, key: String = "", imageUrl: String, createdAt: String){
        
        self.key = key
        self.title = title
        self.caption = caption
        self.price = price
        self.condition = condition
        self.createdAt = createdAt
        self.ref = nil
        self.imageUrl = imageUrl
        
        
    }
    

    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        caption = snapshotValue["caption"] as! String
        price = snapshotValue["price"] as! Double
        condition = snapshotValue["condition"] as! String
        imageUrl = snapshotValue["imageUrl"] as! String
        createdAt = snapshotValue["createdAt"] as! String

        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "caption": caption,
            "price": price,
            "condition": condition,
            "imageUrl": imageUrl,
            "createdAt": createdAt
        ]
    }


}
