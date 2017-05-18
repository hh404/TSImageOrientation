//
//  UIImage+Utility.h
//  CameraDemo
//
//  Created by 张小刚 on 15/1/17.
//  Copyright (c) 2015年 张小刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)

- (UIImage *)orientationCorrectedImage;

@end


@interface UIImage (Debug)

- (NSString *)orientationDescription;

@end