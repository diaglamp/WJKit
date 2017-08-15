//
//  WJAlertController.h
//  WJKit
//
//  Created by dengweijie on 2017/8/15.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJAlertController : UIAlertController
+ (instancetype)alertViewWithTitle:(NSString *)title;
+ (instancetype)alertViewWithTitle:(NSString *)title content:(NSString *)content;

+ (instancetype)actionSheetWithTitle:(NSString *)title;
+ (instancetype)actionSheetWithTitle:(NSString *)title content:(NSString *)content;

- (void)addActionWithTitle:(NSString *)title handler:(void (^)())handler;

- (void)show;
@end
