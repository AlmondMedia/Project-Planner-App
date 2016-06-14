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

extension UIView {
    @IBInspectable var borderUIColor: UIColor? {
        get {
            if let colorRef = layer.borderColor {
                return UIColor(CGColor: colorRef)
            }
            
            return nil
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
}

class SaveBarButtonItem: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let color = App.primaryColor
        self.layer.borderWidth = 1;
        self.layer.borderColor = color.CGColor; //AppUIAdaptor.tintColor.CGColor
        self.layer.backgroundColor =  UIColor.clearColor().CGColor //UIColor.clearColor().CGColor // AppUIAdaptor.tintColorAction.CGColor // UIColor.clearColor().CGColor //
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true;
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        self.frame.origin.x = 110.0
        self.frame.size.width = 60.0
        
        self.setTitleColor(color, forState: .Normal)
        self.setTitle("SAVE", forState: .Normal)
        
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        
        self.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        self.titleLabel?.textColor = App.tintColor //UIColor.whiteColor();
        self.layer.borderColor = App.primaryColor.CGColor
        
        super.setTitle("SAVE", forState: state)
    }
    
    override func alignmentRectInsets() -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 5.0);
    }
}