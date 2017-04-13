//
//  NSBundle+WJAdd.m
//  WJKit
//
//  Created by XHJ on 2017/4/13.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "NSBundle+WJAdd.h"
#import "NSString+WJAdd.h"
#import "WJKitMacro.h"

WJSYNTH_DUMMY_CLASS(NSBundle_WJAdd)

@implementation NSBundle (WJAdd)

+ (NSArray *)preferredScales {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

@end
