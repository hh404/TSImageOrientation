//
//  ImageCell.m
//  CameraDemo
//
//  Created by huangjianwu on 15/10/14.
//  Copyright © 2015年 张小刚. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _mImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_mImageView];
        
        _lbStep = [[UILabel alloc] init];
        _lbStep.textAlignment = NSTextAlignmentCenter;
        _lbStep.textColor = [UIColor redColor];
        [self.contentView addSubview:_lbStep];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_mImageView.image)
    {
        CGSize sz = _mImageView.image.size;
        CGFloat r = 1;
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        if (sz.width > sz.height)
        {
            r = sz.height / sz.width;
            h = r * w;
        }
        else
        {
            r = sz.width / sz.height;
            w = r * h;
        }


        _mImageView.frame = CGRectMake(0, 0, w, h);

        _lbStep.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    }
}

@end
