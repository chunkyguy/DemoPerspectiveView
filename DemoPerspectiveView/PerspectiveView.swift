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

  let contentView = UIView()

  required init?(coder: NSCoder)
  {
    super.init(coder: coder)


    setUp()
  }

  override init(frame: CGRect)
  {
    super.init(frame: frame)
    setUp()
  }

  func setUp()
  {
    var viewDict:[String: UIView] = [String: UIView]()

    viewDict["contentView"] = contentView
    addSubview(contentView)

    if let imagePath:String = Bundle.main.path(forResource: "sample", ofType: "jpg") {
      let image = UIImage(contentsOfFile: imagePath)
      let imageView = UIImageView(image: image)
      imageView.translatesAutoresizingMaskIntoConstraints = false
      viewDict["imageView"] = imageView
      contentView.addSubview(imageView)
    }

    applyConstraints(viewDict: viewDict)
    applyPerspective()

    contentView.backgroundColor = .yellow
    backgroundColor = .purple
  }

  func applyConstraints(viewDict:[String: UIView])
  {

    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[contentView(>=100)]",
                                                               options: [],
                                                               metrics: nil,
                                                               views: viewDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[contentView(>=100)]",
                                                               options: [],
                                                               metrics: nil,
                                                               views: viewDict))


    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageView]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: viewDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageView]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: viewDict))

    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[contentView]-|",
                                                  options: [],
                                                  metrics: nil,
                                                  views: viewDict))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[contentView]-|",
                                                  options: [],
                                                  metrics: nil,
                                                  views: viewDict))
  }

//  func calculatePerspectiveTransform() -> CATransform3D
//  {
//    let eyePosition:Float = 5.0;
//    var contentTransform:CATransform3D = CATransform3DIdentity
//    contentTransform.m34 = CGFloat(-1/eyePosition)
//
//    contentTransform = CATransform3DRotate(contentTransform, CGFloat(GLKMathDegreesToRadians(45)), 1, 0, 0)
//    contentTransform = CATransform3DTranslate(contentTransform, 0, 0, -20)
//
//    return contentTransform
//  }

  func applyPerspective()
  {
    // config camera
    let contentCam:Camera = Camera()
    contentCam.fov = 10
    contentCam.aspectRatio = Float(UIScreen.main.bounds.width/UIScreen.main.bounds.height)
    contentCam.eyeZ = 25

    // config content transform
    let contentTransform:Transform = Transform(camera: contentCam)
    contentTransform.rotationX = 1.0
    contentTransform.rotationY = 0.0
    contentTransform.rotationZ = 0.0
    contentTransform.angle = -1.0

    contentView.layer.sublayerTransform = contentTransform.transform
  }
}
