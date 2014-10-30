//
//  Camera.h
//  DemoPerspectiveView
//
//  Created by Sid on 30/10/14.
//  Copyright (c) 2014 whackylabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMath.h>
#import <CoreGraphics/CoreGraphics.h>

/** Camera object */
@interface Camera : NSObject

/* lens */
// field of view - in radians
@property (nonatomic, readwrite) float fov;
@property (nonatomic, readwrite) float aspectRatio;
// near and far planes
@property (nonatomic, readwrite) float nearZ, farZ;

/* motion */
@property (nonatomic, readwrite) float eyeX, eyeY, eyeZ;
@property (nonatomic, readwrite) float centerX, centerY, centerZ;
@property (nonatomic, readwrite) float upX, upY, upZ;

/* Read by Transform object */
@property (nonatomic, readonly) GLKMatrix4 projectionMatrix;
@property (nonatomic, readonly) GLKMatrix4 viewMatrix;

@end

