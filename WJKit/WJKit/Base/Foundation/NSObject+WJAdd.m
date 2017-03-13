//
//  NSObject+WJAdd.m
//  WJKit
//
//  Created by XHJ on 2017/3/6.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "NSObject+WJAdd.h"
#import <objc/runtime.h>

@implementation NSObject (WJAdd)

#pragma mark - Swap method (Swizzling)
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getClassMethod(self, originalSel);
    Method newMethod = class_getClassMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod));
    
    class_addMethod(self,
                    newSel,
                    method_getImplementation(newMethod),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class metaClass = object_getClass(self);
    Method originalMethod = class_getClassMethod(metaClass, originalSel);
    Method newMethod = class_getClassMethod(metaClass, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    BOOL flag = class_addMethod(self, originalSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (flag) {
        class_replaceMethod(self, newSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
    return YES;
}

#pragma mark - Associate value
- (void)setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}


#pragma mark - Others
+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    //NSStringFromClass([self class]); // The same
    return [NSString stringWithUTF8String:class_getName([self class])];
}

- (id)deepCopy {
    id obj = nil;
    @try {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    return obj;
}


@end
