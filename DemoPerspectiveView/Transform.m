//
//  Transform.m
//  DemoPerspectiveView
//
//  Created by Sid on 30/10/14.
//  Copyright (c) 2014 whackylabs. All rights reserved.
//

#import "Transform.h"
#import <GLKit/GLKMath.h>

static CATransform3D TransformMake(GLKMatrix4 matrix)
{
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m11 = matrix.m00;
    transform.m12 = matrix.m01;
    transform.m13 = matrix.m02;
    transform.m14 = matrix.m03;
    
    transform.m21 = matrix.m10;
    transform.m22 = matrix.m11;
    transform.m23 = matrix.m12;
    transform.m24 = matrix.m13;
    
    transform.m31 = matrix.m20;
    transform.m32 = matrix.m21;
    transform.m33 = matrix.m22;
    transform.m34 = matrix.m23;
    
    transform.m41 = matrix.m30;
    transform.m42 = matrix.m31;
    transform.m43 = matrix.m32;
    transform.m44 = matrix.m33;
    
    return transform;
}


@interface Transform () {
}
@property (nonatomic, strong) Camera *camera;
@end

@implementation Transform

- (id)initWithCamera:(Camera *)camera;
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _positionX = 0.0; _positionY = 0.0; _positionZ = 0.0;
    _rotationX = 0.0; _rotationY = 0.0; _rotationZ = 1.0;
    _scaleX = 1.0; _scaleY = 1.0; _scaleZ = 1.0;
    _angle = 0.0;
    
    self.camera = camera;
    return self;
}

- (CATransform3D)transform;
{
    GLKMatrix4 modelMatrix = GLKMatrix4MakeTranslation(_positionX, _positionY, _positionZ);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, GLKMathDegreesToRadians(_angle), _rotationX, _rotationY, _rotationZ);

    GLKMatrix4 mvp = GLKMatrix4Multiply(_camera.projectionMatrix, GLKMatrix4Multiply(_camera.viewMatrix, modelMatrix));
    return TransformMake(mvp);
}

@end
