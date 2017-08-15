//
//  WJAlertController.m
//  WJKit
//
//  Created by dengweijie on 2017/8/15.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "WJAlertController.h"

@implementation WJAlertController

+ (instancetype)alertViewWithTitle:(NSString *)title {
    return [super alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
}

+ (instancetype)alertViewWithTitle:(NSString *)title content:(NSString *)content {
    return [super alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
}

+ (instancetype)actionSheetWithTitle:(NSString *)title {
    return [super alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
}

+ (instancetype)actionSheetWithTitle:(NSString *)title content:(NSString *)content {
    return [super alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleActionSheet];
}

- (void)addActionWithTitle:(NSString *)title handler:(void (^)())handler {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) handler();
    }];
    [self addAction:action];
}

- (void)show {
    [[self topViewController] presentViewController:self animated:YES completion:nil];
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } 
    return vc;
}
@end
