//
//  UIImage+Utility.m
//  CameraDemo
//
//  Created by 张小刚 on 15/1/17.
//  Copyright (c) 2015年 张小刚. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

- (UIImage *)orientationCorrectedImage
{
    UIImage * resultImage = nil;
    resultImage = self;
    UIImageOrientation imageOrientation = self.imageOrientation;
    if(imageOrientation != UIImageOrientationUp){
        UIGraphicsBeginImageContextWithOptions(self.size, YES, [UIScreen mainScreen].scale);
        [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return resultImage;
}

@end


@implementation UIImage (Debug)

- (NSString *)orientationDescription
{
    NSString * orientationDesc = nil;
    UIImageOrientation orientation = self.imageOrientation;
    switch (orientation) {
        case UIImageOrientationUp:
            orientationDesc = @"UIImageOrientationUp";
            break;
        case UIImageOrientationDown:
            orientationDesc = @"UIImageOrientationDown";
            break;
        case UIImageOrientationLeft:
            orientationDesc = @"UIImageOrientationLeft";
            break;
        case UIImageOrientationRight:
            orientationDesc = @"UIImageOrientationRight";
            break;
        case UIImageOrientationUpMirrored:
            orientationDesc = @"UIImageOrientationUpMirrored";
            break;
        case UIImageOrientationDownMirrored:
            orientationDesc = @"UIImageOrientationDownMirrored";
            break;
        case UIImageOrientationLeftMirrored:
            orientationDesc = @"UIImageOrientationLeftMirrored";
            break;
        case UIImageOrientationRightMirrored:
            orientationDesc = @"UIImageOrientationRightMirrored";
            break;
        default:
            break;
    }
    return orientationDesc;
}


@end












