//
//  PerspectiveView.swift
//  DemoPerspectiveView
//
//  Created by Sid on 29/10/14.
//  Copyright (c) 2014 whackylabs. All rights reserved.
//

import Foundation
import UIKit
import GLKit

class PerspectiveView: UIView {
    
    let contentView:UIView?
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        contentView = UIView()

        contentView?.backgroundColor = UIColor.yellowColor()
        backgroundColor = UIColor.purpleColor()

        setUp()
    }
    
    func setUp()
    {
        var viewDict:[String: UIView] = [String: UIView]()

        viewDict["contentView"] = contentView!
        addSubview(contentView!)
        
        if let imagePath:String = NSBundle.mainBundle().pathForResource("photo4", ofType: "JPG") {
            let image:UIImage = UIImage(contentsOfFile: imagePath)
            let imageView:UIImageView = UIImageView(image: image)
            imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
            viewDict["imageView"] = imageView
            contentView?.addSubview(imageView)
        }

        applyConstraints(viewDict: viewDict)
        applyPerspective()
    }
    
    func applyConstraints(#viewDict:[String: UIView])
    {
        
        contentView?.setTranslatesAutoresizingMaskIntoConstraints(false)

        contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[contentView(>=100)]",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewDict))
        contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[contentView(>=100)]",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewDict))
        

        contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[imageView]-|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewDict))
        contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[imageView]-|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewDict))

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[contentView]-|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[contentView]-|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewDict))
    }

    func calculatePerspectiveTransform() -> CATransform3D
    {
        let eyePosition:Float = 5.0;
        var contentTransform:CATransform3D = CATransform3DIdentity
        contentTransform.m34 = CGFloat(-1/eyePosition)
        
        contentTransform = CATransform3DRotate(contentTransform, CGFloat(GLKMathDegreesToRadians(45)), 1, 0, 0)
        contentTransform = CATransform3DTranslate(contentTransform, 0, 0, -20)
        
        return contentTransform
    }

    
    func applyPerspective()
    {
        // config camera
        let contentCam:Camera = Camera()
        contentCam.fov = 10
        contentCam.aspectRatio = Float(CGRectGetWidth(UIScreen.mainScreen().bounds))/Float(CGRectGetHeight(UIScreen.mainScreen().bounds))
        contentCam.eyeZ = 25
        
        // config content transform
        let contentTransform:Transform = Transform(camera: contentCam)
        contentTransform.rotationX = 1.0
        contentTransform.rotationY = 0.0
        contentTransform.rotationZ = 0.0
        contentTransform.angle = -1.0
        
//        contentView?.layer.sublayerTransform = contentTransform.transform
        contentView?.layer.sublayerTransform = calculatePerspectiveTransform()
    }
}
