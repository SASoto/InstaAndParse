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
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        
        self.getPosts()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts()
    {
        var query = PFQuery(className: "Post")
        /*query.getObjectInBackgroundWithId("imkmJsHVIH") {
            (post: PFObject?, error: NSError?) -> Void in*/
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil /*&& gameScore != nil*/ {
                //print(post)
                self.instaPosts = results
                //self.instaPosts = [post!]
                self.tableView.reloadData()
                
            } else {
                print(error)
            }
        }
        
        //self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return instaPosts?.count ?? 0
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HRC"/*, forIndexPath: indexPath*/) as! InstaPostCellTableViewCell
        
        cell.getPhotoandCaption = instaPosts[indexPath.row]
        
        return cell
    }
    
    // MARK: - Navigation

    /*3override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }*/
    

}
