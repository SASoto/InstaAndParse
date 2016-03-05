//
//  PhotosViewController.swift
//  InstagramRedux
//
//  Created by Saul Soto on 2/28/16.
//  Copyright © 2016 CodePath - Saul. All rights reserved.
//

import UIKit
import Parse

class PhotosViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getImage() {
        
        let imageFromSource = UIImagePickerController()
        imageFromSource.delegate = self
        imageFromSource.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
                imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else {
        
            imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(imageFromSource, animated:true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        
        selectedImage.image = image
        
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        //If statement does not prevent crash
        if selectedImage.image != nil || captionTextField.text != nil {
            
            UserMedia.postUserImage(selectedImage.image, withCaption: self.captionTextField.text, withCompletion: nil)
        }
        
        else {
            print("ERROR! No image and/or caption")
        }
        
        //NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        
        self.tabBarController!.selectedIndex = 0;
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

class UserMedia: NSObject {
        
        class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
            // Create Parse object PFObject
            let media = PFObject(className: "UserMedia")
            
            // Add relevant fields to the object
            media["media"] = getPFFileFromImage(image) // PFFile column type
            media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
            media["caption"] = caption
            media["likesCount"] = 0
            media["commentsCount"] = 0
            
            // Save object (following function will save the object in Parse asynchronously)
            media.saveInBackgroundWithBlock(completion)
        }
    
        class func getPFFileFromImage(image: UIImage?) -> PFFile? {
            // check if image is not nil
            if let image = image {
                // get image data and check if that is not nil
                if let imageData = UIImagePNGRepresentation(image) {
                    return PFFile(name: "image.png", data: imageData)
                }
            }
            return nil
        }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
