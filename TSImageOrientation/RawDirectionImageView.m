//
//  RawDirectionImageView.m
//  CameraDemo
//
//  Created by 张小刚 on 15/1/17.
//  Copyright (c) 2015年 张小刚. All rights reserved.
//

#import "RawDirectionImageView.h"

@implementation RawDirectionImageView

- (void)setImage:(UIImage *)image
{
    /*
     1. UIImageView如果发现image的imageOrientation不为UIImageOrientationUp时，imageView会根据imageOrientation调整显示内容。
     因此，我们把如果image的imageOrientation调整为UIImageOrientationUp就可以看到image的原始图。
     
     2. UIImage是CGImage的上层表现，CGImage真正存储了UIImage的数据。
     */
    UIImage * rawDirectionImage = image;
    if(image.imageOrientation != UIImageOrientationUp){
        rawDirectionImage = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUp];
    }
    [super setImage:rawDirectionImage];
}


@end
