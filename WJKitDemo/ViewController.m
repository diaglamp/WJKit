//
//  ViewController.m
//  WJKit
//
//  Created by XHJ on 2017/3/6.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+WJAdd.h"
#import "UIColor+WJAdd.h"
#import <ImageIO/ImageIO.h>
#import "WJKitMacro.h"
#import "UIApplication+WJAdd.h"
#import "WJAlertController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *originView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)webPImageTest {
    UIImage *image = [UIImage imageNamed:@"google@2x.webp"];
    [self imageTestBase:image];
}

- (void)netWorkRequestTest {
    [[UIApplication sharedApplication] incrementNetworkActivityCount];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] decrementNetworkActivityCount];
    });
}

- (void)grayscaleTest {
    UIImage *image = [[UIImage imageNamed:@"two_cat"] imageByBlurDark];
    [self imageTestBase:image];
}

- (void)tintColorTest {
    
    _originView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"two_cat"]];
    [_originView sizeToFit];
    _originView.center = CGPointMake(self.view.frame.size.width / 2, 100 + _originView.frame.size.height / 2);
    [self.view addSubview:_originView];
    UIImage *image = [[UIImage imageNamed:@"two_cat"] imageByTintColor:[UIColor colorWithRGB:0x999999 alpha:0.5]];
    [self imageTestBase:image];
}

- (void)rotateTest {
    UIImage *image = [[UIImage imageNamed:@"two_cat"] imageByRotate:2 fitSize:YES];
    [self imageTestBase:image];
}

- (void)roundCornerTest {
    UIImage *image = [[UIImage imageNamed:@"two_cat"] imageByRoundCornerRadius:50
                                                                        corners:UIRectCornerAllCorners
                                                                    borderWidth:5
                                                                    borderColor:[UIColor blueColor]
                                                                 borderLineJoin:kCGLineJoinMiter];
    [self imageTestBase:image];
    
}

- (void)smallGifTest {
    NSString *resPath = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [resPath stringByAppendingPathComponent:@"EmoticonQQ.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *path = [bundle pathForResource:@"001@2x.gif" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithSmallGIFData:data scale:2.0];
    _imageView = [[UIImageView alloc]initWithImage:image];
    _imageView.frame = CGRectMake(100, 100, 0, 0);
    [_imageView sizeToFit];
    [self.view addSubview:_imageView];
}

- (void)imageTestBase:(UIImage *)image {
    _imageView = [[UIImageView alloc]initWithImage:image];
    [_imageView sizeToFit];
    _imageView.center = CGPointMake(self.view.frame.size.width / 2, 100 + _imageView.frame.size.height / 2);
    [self.view addSubview:_imageView];
}

- (void)alertControllerTest {
    WJAlertController *alert = [WJAlertController actionSheetWithTitle:@"alertTitle"];
    [alert addActionWithTitle:@"confirm" handler:^{
        NSLog(@"hello alert!");
    }];
    [alert addActionWithTitle:@"cancle" handler:nil];
    [alert show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self alertControllerTest];
}

@end
