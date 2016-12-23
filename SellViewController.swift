//
//  SellViewController.swift
//  YardSale
//
//  Created by Caitlyn Chen on 12/21/16.
//  Copyright © 2016 Caitlyn Chen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class SellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView?
    var imagePicker = UIImagePickerController()
    
    

    
    @IBOutlet weak var cameraButton: UIButton!

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var conditionTextField: UITextField!
    var items: [ItemObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButtonTapped(sender: AnyObject) {
        //println("hi")
 
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Only show camera option if rear camera is available
        if (UIImagePickerController.isCameraDeviceAvailable(.rear)) {
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .default) { (action) in
//                imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
            alertController.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .default) { (action) in
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        
        alertController.addAction(photoLibraryAction)
        
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        cameraButton.isHidden = true
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageView?.contentMode = .scaleAspectFit //3
        imageView?.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }

    @IBAction func sellButtonTapped(_ sender: Any) {
        let storage = FIRStorage.storage()
        
        let storageRef = storage.reference(forURL: "gs://yardsale-cd99c.appspot.com")


        let ref = FIRDatabase.database().reference(withPath: "item-name")
        let itemRef = ref.child((titleTextField.text?.lowercased())!)
        
        let imageData: NSData = UIImagePNGRepresentation((imageView?.image)!)! as NSData
        
        let imageRef = storageRef.child(titleTextField.text!)
        
        let uploadTask = imageRef.put(imageData as Data, metadata: nil) { metadata, error in
            if error != nil {
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()
                let price = round(Double(self.priceTextField.text!)!*100)/100
                let items = ItemObject(title: self.titleTextField.text!, price: Double(price), condition: self.conditionTextField.text!, caption: self.captionTextView.text, imageUrl: String(describing: downloadURL!), createdAt: Ns)
                
                itemRef.setValue(items.toAnyObject())

            }
        }
        
       
       
        
        
        // 4
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
