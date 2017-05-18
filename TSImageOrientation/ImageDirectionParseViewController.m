//
//  ImageDirectionParseViewController.m
//  TSImageOrientation
//
//  Created by huangjianwu on 2017/5/17.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "ImageDirectionParseViewController.h"
#import "RawDirectionImageView.h"
#import "UIImage+Utility.h"
#import "ImageCell.h"
#import "Masonry.h"
#import "UIColor+Random.h"

@interface ImageDirectionParseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *mCollectionView;

@property(nonatomic,strong) UIImageView *previewImageView;

@property(nonatomic,strong) RawDirectionImageView *rawDirectionImageView;

@property(nonatomic,strong) RawDirectionImageView *orientationCorrectedImageView;

@property(nonatomic,strong) UILabel *orientationCorrectedLabel;

@property(nonatomic,strong) NSMutableArray *stepArray;

@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation ImageDirectionParseViewController

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Init and dealloc

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel * preViewLabel = [[UILabel alloc] init];
    preViewLabel.text = @"UIImageView预览图";
    preViewLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:preViewLabel];
    [preViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(@68);
        make.width.equalTo(@(CGRectGetWidth([UIScreen mainScreen].bounds)/2.0));
        make.height.equalTo(@35);
    }];
    
    
    UILabel *originLabel = [[UILabel alloc] init];
    originLabel.text = @"原始图";
    originLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:originLabel];
    [originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(preViewLabel.mas_right);
        make.top.equalTo(@68);
        make.width.equalTo(@(CGRectGetWidth([UIScreen mainScreen].bounds)/2.0));
        make.height.equalTo(@35);
    }];
    
    _orientationCorrectedLabel = [[UILabel alloc] init];
    _orientationCorrectedLabel.textAlignment = NSTextAlignmentCenter;
    _orientationCorrectedLabel.numberOfLines = 0;
    [self.view addSubview:_orientationCorrectedLabel];
  
    
    _previewImageView = [[UIImageView alloc] init];
    _previewImageView.backgroundColor = [UIColor randomColor];
    _previewImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_previewImageView];
    [_previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.width.equalTo(@((CGRectGetWidth([UIScreen mainScreen].bounds) - 24)/2.0));
        make.top.equalTo(originLabel.mas_bottom);
        make.height.equalTo(@((CGRectGetWidth([UIScreen mainScreen].bounds) - 24)/2.0));
    }];
    
    [_orientationCorrectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_previewImageView.mas_right);
        make.top.equalTo(_previewImageView.mas_bottom).offset(6);
        make.width.equalTo(@(CGRectGetWidth([UIScreen mainScreen].bounds)/2.0));
        make.height.equalTo(@135);
    }];
    
    _rawDirectionImageView = [[RawDirectionImageView alloc] init];
    _rawDirectionImageView.contentMode = UIViewContentModeScaleAspectFit;
    _rawDirectionImageView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:_rawDirectionImageView];
    [_rawDirectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_previewImageView.mas_right).offset(8);
        make.top.equalTo(_previewImageView.mas_top);
        make.right.equalTo(self.view).offset(-8);
        make.bottom.equalTo(_previewImageView.mas_bottom);
    }];
    
    _orientationCorrectedImageView = [[RawDirectionImageView alloc] init];
    _orientationCorrectedImageView.contentMode = UIViewContentModeScaleAspectFit;
    _orientationCorrectedImageView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:_orientationCorrectedImageView];
    [_orientationCorrectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.previewImageView);
        make.top.equalTo(_orientationCorrectedLabel.mas_top);
        make.right.equalTo(self.previewImageView);
        make.height.equalTo(self.previewImageView);
        
    }];
    _previewImageView.image = self.image;
    _rawDirectionImageView.image = self.image;
    UIImage * orientationCorrectedImage = [self.image orientationCorrectedImage];
    _orientationCorrectedImageView.image = orientationCorrectedImage;
    _orientationCorrectedLabel.text = [NSString stringWithFormat:@"由原始图生成的:%@方向新图",[orientationCorrectedImage orientationDescription]];
    
    UICollectionViewFlowLayout *ly = [[UICollectionViewFlowLayout alloc] init];
    ly.itemSize = CGSizeMake(150, 150);
    ly.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ly.minimumLineSpacing = 10;
    ly.minimumInteritemSpacing = 10;
    
    _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 240, self.view.frame.size.width, 240) collectionViewLayout:ly];
    [_mCollectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"Cell"];
    _mCollectionView.dataSource = self;
    _mCollectionView.delegate = self;
    _mCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mCollectionView];
    
    [_mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orientationCorrectedImageView.mas_bottom).offset(6);
        make.left.equalTo(@0);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    _stepArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _mCollectionView.frame = CGRectMake(0, self.view.frame.size.height - 240, self.view.frame.size.width, 240);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    
}


#pragma mark -
#pragma mark Private methods

- (UIImage *)fixOrientationWithImage:(UIImage*)aImage andStep:(HandleImageStep)aStep
{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            if(aStep & HandleImageStep1)
            {
                transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            }
            if(aStep & HandleImageStep2)
            {
                transform = CGAffineTransformRotate(transform, M_PI);
            }
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            if(aStep & HandleImageStep1)
            {
                transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            }
            if(aStep & HandleImageStep2)
            {
                transform = CGAffineTransformRotate(transform, M_PI_2);
            }
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            if(aStep & HandleImageStep1)
            {
                transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            }
            if(aStep & HandleImageStep2)
            {
                transform = CGAffineTransformRotate(transform, -M_PI_2);
            }
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGFloat r = 1;
    if(aStep & HandleImageStep1)
    {
        r = 2;
    }
    CGFloat w = aImage.size.width*r;
    CGFloat h = aImage.size.height*r;
    CGContextRef ctx = CGBitmapContextCreate(NULL, w, h,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            //CGContextDrawImage(ctx, cgrectmake, self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            //CGContextDrawImage(ctx, rect, self.CGImage);
            break;
    }
    CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium);
    
    //    CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
    UIImage *img1 = [UIImage imageNamed:@"r1"];
    CGContextDrawImage(ctx, CGRectMake(0,0,img1.size.width*2,img1.size.height*2), img1.CGImage);
    UIImage *img2 = [UIImage imageNamed:@"r2"];
    CGContextDrawImage(ctx, CGRectMake(0,0,img2.size.width*2,img2.size.height*2), img2.CGImage);
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Handlers

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return 2;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ImageCell *cell = [_mCollectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(indexPath.item == 0)
    {
        cell.mImageView.image = [self fixOrientationWithImage:self.image andStep:HandleImageStep1];
    }
    else if (indexPath.item == 1)
    {
        cell.mImageView.image = [self fixOrientationWithImage:self.image andStep:HandleImageStep1 | HandleImageStep2];
        
    }
    else
    {
        
    }
    cell.lbStep.text = [NSString stringWithFormat:@"%tu",indexPath.item];
    cell.layer.borderColor = [UIColor redColor].CGColor;
    cell.layer.borderWidth = 1;
    cell.contentView.backgroundColor = [UIColor yellowColor];
    
    return cell;
}


@end
