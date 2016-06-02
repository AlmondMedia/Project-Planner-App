//
//  TintedImagedUIButton.swift
//  Evolve Studio
//
//  Created by majeed on 05/01/2016.
//  Copyright © 2016 Almond Media. All rights reserved.
//

import UIKit

class TintedImageUIButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tintColor = App.window.tintColor;
        self.setImage(self.imageView?.image, forState: .Normal)
    }
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image?.imageWithRenderingMode(.AlwaysTemplate), forState: state)
    }

}

extension UIViewController
{
    func applyAppBackground()
    {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "App-BG")!)
    }
}

class CircleImageView : UIImageView
{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius = self.frame.size.width / 2.0;
        self.layer.cornerRadius = cornerRadius;
        self.clipsToBounds = true;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.1).CGColor
        //self.layer.cornerRadius = 5.0
        self.clipsToBounds = true;
    }
    
    func setRadius(radius : CGFloat)
    {
        self.layer.cornerRadius = radius;
    }
}


class CircleView : UIView
{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius = self.frame.size.height / 2.0;
        self.layer.cornerRadius = cornerRadius;
        self.clipsToBounds = true;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.1).CGColor
        //self.layer.cornerRadius = 5.0
        self.clipsToBounds = true;
    }
    
    
    func updateRadius()
    {
        self.layer.cornerRadius = self.frame.size.height / 2.0;
    }
}
//extension UIViewController {
//    public override class func initialize() {
//        struct Static {
//            static var token: dispatch_once_t = 0
//        }
//        
//        // make sure this isn't a subclass
//        if self !== UIViewController.self {
//            return
//        }
//        
//        dispatch_once(&Static.token) {
//            let originalSelector = Selector("viewWillAppear:")
//            let swizzledSelector = Selector("nsh_viewWillAppear:")
//            
//            let originalMethod = class_getInstanceMethod(self, originalSelector)
//            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
//            
//            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//            
//            if didAddMethod {
//                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod)
//            }
//        }
//    }
//    
//    // MARK: - Method Swizzling
//    
//    func nsh_viewWillAppear(animated: Bool) {
//        self.nsh_viewWillAppear(animated)
//    
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "App-BG")!)
//    }
//}