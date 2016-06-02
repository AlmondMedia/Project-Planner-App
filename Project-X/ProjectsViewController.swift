//
//  ProfileViewController.swift
//  Project-X
//
//  Created by majeed on 24/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var projectsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        (projectsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = CGFloat.max;
        
        App.ProjectsReloadedEvent.addHandler {self.refereshView()}
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        App.ResetMemory();
        refereshView();
    
    }
    
    func refereshView()
    {
        dispatch_async(dispatch_get_main_queue()) {
           self.projectsCollectionView.reloadData();
        }
    }
    
    
    @IBAction func openDrawerToggle(sender: AnyObject) {
        (self.navigationController!.parentViewController as! KYDrawerController).setDrawerState(KYDrawerController.DrawerState.Opened, animated: true)
    }

    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let width = collectionView.bounds.size.width - 20.0;
            let height = width * 0.8
            return CGSizeMake(width, height)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = App.Data.Projects.count
        return count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("projectCell", forIndexPath: indexPath) as! ProjectsCollectionViewCell
        
        cell.project = App.Data.Projects[indexPath.row];
        cell.menuButton.tag = indexPath.row;
        cell.menuButton.addTarget(self, action: #selector(ProjectsViewController.showActionSheet(_:)), forControlEvents: .TouchUpInside)
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        App.Memory.selectedProject = App.Data.Projects[indexPath.row]
    }
    
   
    func showActionSheet(sender: UIButton ) {
        let itemId = sender.tag
        // 1
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Project Delete \(itemId)")
        })
        let editAction = UIAlertAction(title: "Edit Project", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Project Edit \(itemId)")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(editAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    

}
