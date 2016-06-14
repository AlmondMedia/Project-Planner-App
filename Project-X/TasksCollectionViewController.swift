//
//  TasksCollectionViewController.swift
//  Project-X
//
//  Created by majeed on 24/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TasksCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.calculateScreenSizeLayout();
        App.TasksReloadedEvent.addHandler {self.refereshView()}
    }
    func refereshView()
    {
        dispatch_async(dispatch_get_main_queue()) {
            self.collectionView?.reloadData();
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        App.Memory.selectedTask = nil;
        self.collectionView?.reloadData();
    }
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    func calculateScreenSizeLayout()
    {
        let screenSize = UIScreen.mainScreen().bounds;
        screenWidth = screenSize.width;
        screenHeight = screenSize.height;
        
        let layout: UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 2, height: screenWidth / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
    
    
    @IBAction func accountBtnTapped(sender: AnyObject) {
        App.Data.SyncTimestamp = NSDate()
        App.SaveLocalData()
        self.navigationController!.tabBarController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
//        if(indexPath.row == 0) {
//            return CGSize(width: screenWidth, height: screenWidth/2);
//        }
//        else {
//            return CGSize(width: screenWidth/2, height: screenWidth/2);
//        }
        return CGSize(width: screenWidth, height: screenWidth/2);
        
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return App.Memory.selectedProject!.Tasks.count;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("taskCell", forIndexPath: indexPath) as! TaskCollectionViewCell
    
        cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).CGColor;
        cell.layer.borderWidth = 0.5;
        cell.layer.cornerRadius = 0;
        if((indexPath.row+1) % 4 == 3 || (indexPath.row+1) % 4 == 0){
            //cell.layer.frame.insetInPlace(dx: 0, dy: -0.5);
            
        }
        if((indexPath.row + 1) % 2 == 0){
            //cell.layer.frame.insetInPlace(dx: -0.5, dy: 0);
        }
        
        if((indexPath.row % 2) != 0) {
            //cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.01)
        }

        
        
        cell.task = App.Memory.selectedProject!.Tasks[indexPath.row]
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        App.Memory.selectedTask = App.Memory.selectedProject!.Tasks[indexPath.row];
    }


}
