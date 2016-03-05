//
//  HomeViewController.swift
//  InstagramRedux
//
//  Created by Saul Soto on 2/27/16.
//  Copyright © 2016 CodePath - Saul. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var instaPosts: [PFObject]!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        //self.getPosts()
   
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.getPosts()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts()
    {
        let query = PFQuery(className: "UserMedia")
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                //print(self.instaPosts)
                self.instaPosts = results
                self.tableView.reloadData()
                
            } else {
                print(error)
            }
        }
    
    }
    
    
    func loadList(notification: NSNotification){
        self.getPosts()
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if instaPosts != nil {
                return instaPosts!.count
                } else {
                    return 0
                }
        
        }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HRC", forIndexPath: indexPath) as! InstaPostCellTableViewCell
        
        cell.getPhotoandCaption = instaPosts[indexPath.row]
        
        return cell
    }
    
    // MARK: - Navigation

    /*3override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }*/
    

}
