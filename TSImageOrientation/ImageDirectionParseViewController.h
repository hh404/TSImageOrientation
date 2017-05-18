//
//  ImageDirectionParseViewController.h
//  TSImageOrientation
//
//  Created by huangjianwu on 2017/5/17.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import UIKit;

typedef NS_OPTIONS(NSInteger, HandleImageStep)
{
    HandleImageStep1 = 1 << 0,
    HandleImageStep2 = 1 << 1,
    HandleImageStep3 = 1 << 2,
    HandleImageStep4 = 1 << 3,
    HandleImageStep5 = 1 << 4,
};

@interface ImageDirectionParseViewController : UIViewController

@property (nonatomic, strong) UIImage * image;

@end
