//
//  Transform.h
//  DemoPerspectiveView
//
//  Created by Sid on 30/10/14.
//  Copyright (c) 2014 whackylabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Camera.h"

@interface Transform : NSObject

- (id)initWithCamera:(Camera *)camera;

@property (nonatomic, readwrite) float positionX, positionY, positionZ;
@property (nonatomic, readwrite) float rotationX, rotationY, rotationZ;
@property (nonatomic, readwrite) float scaleX, scaleY, scaleZ;
@property (nonatomic, readwrite) float angle;

@property (nonatomic, readonly) CATransform3D transform;

@end
