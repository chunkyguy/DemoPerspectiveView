//
//  Camera.m
//  DemoPerspectiveView
//
//  Created by Sid on 30/10/14.
//  Copyright (c) 2014 whackylabs. All rights reserved.
//

#import "Camera.h"

@interface Camera ()

@property (nonatomic, readwrite) GLKMatrix4 projectionMatrix;
@property (nonatomic, readwrite) GLKMatrix4 viewMatrix;

- (void) updateProjection;
- (void) updateView;
@end

@implementation Camera

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _fov = 60.0;
    _aspectRatio = 1.0;
    _nearZ = 0.1; _farZ = 100.0;

    _eyeX = 0.0; _eyeY = 0.0; _eyeZ = 100.0;
    _centerX = 0.0; _centerY = 0.0; _centerZ = 0.0;
    _upX = 0.0; _upY = 1.0; _upZ = 0.0;

    [self updateProjection];
    [self updateView];

    return self;
}

#pragma mark projection

- (void)setFov:(float)fov
{
    _fov = fov;
    [self updateProjection];
}

- (void)setAspectRatio:(float)aspectRatio
{
    _aspectRatio = aspectRatio;
    [self updateProjection];
}

- (void)setNearZ:(float)nearZ
{
    _nearZ = nearZ;
    [self updateProjection];
}

- (void)setFarZ:(float)farZ
{
    _farZ = farZ;
    [self updateProjection];
}

- (void) updateProjection;
{
    self.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(_fov),
                                                      _aspectRatio,
                                                      _nearZ, _farZ);
}

#pragma mark view
- (void)setEyeX:(float)eyeX
{
    _eyeX = eyeX;
    [self updateView];
}

- (void)setEyeY:(float)eyeY
{
    _eyeY = eyeY;
    [self updateView];
}

- (void)setEyeZ:(float)eyeZ
{
    _eyeZ = eyeZ;
    [self updateView];
}

- (void)setCenterX:(float)centerX
{
    _centerX = centerX;
    [self updateView];
}

- (void)setCenterY:(float)centerY
{
    _centerY = centerY;
    [self updateView];
}

- (void)setCenterZ:(float)centerZ
{
    _centerZ = centerZ;
    [self updateView];
}

- (void)setUpX:(float)upX
{
    _upX = upX;
    [self updateView];
}

- (void)setUpY:(float)upY
{
    _upY = upY;
    [self updateView];
}

- (void)setUpZ:(float)upZ
{
    _upZ = upZ;
    [self updateView];
}

- (void) updateView;
{
    self.viewMatrix = GLKMatrix4MakeLookAt(_eyeX, _eyeY, _eyeZ,
                                           _centerX, _centerY, _centerZ,
                                           _upX, _upY, _upZ);
}

@end
