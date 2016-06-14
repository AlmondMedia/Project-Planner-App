//
//  NewProjectSelectionViewController.swift
//  Project-X
//
//  Created by majeed on 20/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProjecTemplateSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let filter : FilterBar = FilterBar()
        
        filter.titles = ["Home", "Events", "Travel", "Saved"]
        filter.translucent = false
        self.view.addSubview(filter)
        let topConstraint : NSLayoutConstraint = NSLayoutConstraint(item: filter, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraint(topConstraint)
        filter.addTarget(self, action: #selector(ProjecTemplateSelectionViewController.segmentChanged(_:)), forControlEvents: .ValueChanged)
        
        templateGroups = [App.Memory.Templates,[], [], []];
        let emptyTemplate = ProjectTemplate();
        emptyTemplate.Title = "Blank Project"
        emptyTemplate.Description = "Create new project with no default tasks"
        for index in 0...(templateGroups.count - 1) {
            templateGroups[index].insert(emptyTemplate, atIndex: 0)
        }
        selectedTemplateGroup = templateGroups[0];
        
        self.calculateScreenSizeLayout();
    }
    
    var templateGroups : [[ProjectTemplate]] = [App.Memory.Templates,[], []];//= App.Data.Templates;
    var selectedTemplateGroup : [ProjectTemplate] = [];
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let bar : UINavigationBar = (self.navigationController?.navigationBar)!
        
        self.searchHierarchyForBorder(bar)
        
        
        
    }
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    func calculateScreenSizeLayout()
    {
        let screenSize = UIScreen.mainScreen().bounds;
        screenWidth = screenSize.width;
        screenHeight = screenSize.height;
        
        let layout: UICollectionViewFlowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 2, height: screenWidth / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
    
    
    @IBAction func segmentChanged(sender: AnyObject) {
        
        let filter : FilterBar = sender as! FilterBar
        
        let index : NSInteger = filter.selectedSegmentIndex
        
        selectedTemplateGroup = templateGroups[index];
        self.collectionView.reloadData();
        
    }
    
    func searchHierarchyForBorder(rootView:UIView) {
        
        if rootView.layer.borderWidth > 0.0 {
            NSLog("Found border on view: %@, %@", rootView, rootView.self)
        }
        
        let subviews : Array<UIView> = rootView.subviews
        
        for view : UIView in subviews {
            searchHierarchyForBorder(view)
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: screenWidth/2, height: screenWidth/2);
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    @objc func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return selectedTemplateGroup.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ProjectTemplateCollectionCell;
        
        cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor;
        cell.layer.borderWidth = 0.5;
        cell.layer.cornerRadius = 0;
        if((indexPath.row+1) % 4 == 3 || (indexPath.row+1) % 4 == 0){
            cell.layer.frame.insetInPlace(dx: 0, dy: -0.5);
        }
        if(indexPath.row % 2 == 0){
            cell.layer.frame.insetInPlace(dx: -0.5, dy: 0);
        }
        // Configure the cell
        let index = indexPath.row;
        let template = selectedTemplateGroup[index];
        cell.titleLabel?.text = template.Title
        cell.descriptionLabel.text = template.Description
        cell.mainImageView?.image = UIImage(named:"ui-image-" + template.Title);
        
        return cell

    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        App.Memory.selectedTemplate = selectedTemplateGroup[indexPath.row];
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
