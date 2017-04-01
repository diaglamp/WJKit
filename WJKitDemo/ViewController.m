//
//  ViewController.m
//  WJKit
//
//  Created by XHJ on 2017/3/6.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+WJAdd.h"
#import <ImageIO/ImageIO.h>
#import "WJKitMacro.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *originView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self roundCornerTest];
    
}

- (void)roundCornerTest {
    UIImage *image = [[UIImage imageNamed:@"two_cat"] imageByRoundCornerRadius:0
                                                                        corners:UIRectCornerAllCorners
                                                                    borderWidth:10
                                                                    borderColor:[UIColor blueColor]
                                                                 borderLineJoin:kCGLineJoinMiter];
    _imageView = [[UIImageView alloc]initWithImage:image];
    _imageView.frame = CGRectMake(100, 100, 0, 0);
    [_imageView sizeToFit];
    [self.view addSubview:_imageView];
    
    UIImage *imageO = [UIImage imageNamed:@"two_cat"];
    _originView = [[UIImageView alloc]initWithImage:imageO];
    _originView.frame = CGRectMake(100, 300, 0, 0);
    [_originView sizeToFit];
    [self.view addSubview:_originView];
    
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

@end
