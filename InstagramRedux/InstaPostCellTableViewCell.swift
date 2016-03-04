//
//  InstaPostCellTableViewCell.swift
//  InstagramRedux
//
//  Created by Saul Soto on 3/2/16.
//  Copyright © 2016 CodePath - Saul. All rights reserved.
//

import UIKit
import Parse
//import ParseUI

class InstaPostCellTableViewCell: UITableViewCell {

    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var postedCaption: UILabel!
    
    var getPhotoandCaption: PFObject! {
        didSet {
            self.postedCaption.text = getPhotoandCaption["caption"] as? String
            
        //let image = getPhotoandCaption["media"] as! PFObject
            //self.postedImage = getPhotoandCaption["image.png"] as? PFFile
            //postedImage = getPhotoandCaption[] as? PFFile
        
            }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
