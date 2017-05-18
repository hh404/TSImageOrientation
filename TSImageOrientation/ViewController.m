//
//  ViewController.m
//  TSImageOrientation
//
//  Created by huangjianwu on 2017/5/17.
//  Copyright © 2017年 huangjianwu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UIImage+Utility.h"
#import "ImageDirectionParseViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *previewImageView;

@property (nonatomic, strong) UIButton *takePhotoButton;

@property (nonatomic, strong) UILabel *orientationKeyLabel;

@property (nonatomic, strong) UILabel *orientationValueLabel;

@property (nonatomic, strong) UILabel *previewLabel;

@property (nonatomic, strong) UIButton *showStepButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _takePhotoButton = [[UIButton alloc] init];
    [_takePhotoButton setTitle:@"拍照" forState:UIControlStateNormal];
    [_takePhotoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_takePhotoButton addTarget:self action:@selector(_takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_takePhotoButton];
    
    [_takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@72);
        make.height.equalTo(@40);
        make.width.equalTo(@120);
    }];
    
    _previewLabel = [[UILabel alloc] init];
    [_previewLabel setText:@"图片预览"];
    [self.view addSubview:_previewLabel];
    
    [_previewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(self.takePhotoButton.mas_bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@35);
    }];
    
    _previewImageView = [[UIImageView alloc] init];
    [self.view addSubview:_previewImageView];
    [_previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.previewLabel.mas_right).offset(6);
        make.top.equalTo(self.previewLabel);
        make.right.equalTo(self.view).offset(-8);
        make.height.equalTo(@120);
    }];
    
    _orientationKeyLabel = [[UILabel alloc] init];
    [_orientationKeyLabel setText:@"图片方向"];
    [self.view addSubview:_orientationKeyLabel];
    
    [_orientationKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(self.previewImageView.mas_bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@35);
    }];
    
    _orientationValueLabel = [[UILabel alloc] init];
    [self.view addSubview:_orientationValueLabel];
    
    [_orientationValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orientationKeyLabel.mas_right).offset(5);
        make.top.equalTo(self.previewImageView.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-8);
        make.height.equalTo(@35);
    }];
    
    _showStepButton = [[UIButton alloc] init];
    [_showStepButton setTitle:@"查看原始方向" forState:UIControlStateNormal];
    [_showStepButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_showStepButton addTarget:self action:@selector(_showStepViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_showStepButton];
    
    [_showStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.orientationKeyLabel.mas_bottom).offset(8);
        make.height.equalTo(@40);
        make.width.equalTo(@120);
    }];
    _showStepButton.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)_takePhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:0];
}

- (void)_showStepViewController
{
    ImageDirectionParseViewController *ic = [[ImageDirectionParseViewController alloc] init];
    ic.image = _previewImageView.image;
    [self.navigationController pushViewController:ic animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    _previewImageView.image = image;
    CGSize size = image.size;
    CGFloat i = size.height/size.width;
    CGFloat w = CGRectGetWidth(_previewImageView.frame);
    [_previewImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(w*i));
    }];
    [picker dismissViewControllerAnimated:YES completion:0];
    _orientationValueLabel.text = [image orientationDescription];
    _showStepButton.hidden = NO;
}
@end
