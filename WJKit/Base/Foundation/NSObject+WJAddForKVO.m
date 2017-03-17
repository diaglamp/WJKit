//
//  NSObject+WJAddForKVO.m
//  WJKit
//
//  Created by XHJ on 2017/3/14.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "NSObject+WJAddForKVO.h"
#import "WJKitMacro.h"
#import <objc/runtime.h>

WJSYNTH_DUMMY_CLASS(NSObject_WJAddForKVO)

typedef void (^KVOTargetBlock)(__weak id obj, id oldVal, id newVal);

static const char *kObserverTargetKey = "kObserverTargetKey";

@interface _WJNSObjectKVOBlockTarget : NSObject
@property (nonatomic, copy) KVOTargetBlock block;
- (instancetype)initWithBlock:(KVOTargetBlock)block;
@end

@implementation _WJNSObjectKVOBlockTarget

- (instancetype)initWithBlock:(KVOTargetBlock)block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (!self.block) return;
    
    BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) return;
    
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    
    self.block(object, oldVal, newVal);
}

@end

@implementation NSObject (WJAddForKVO)

- (void)addObserverBlockForKeyPath:(NSString *)keyPath block:(KVOTargetBlock)block {
    if (!keyPath || !block) return;
    _WJNSObjectKVOBlockTarget *target = [[_WJNSObjectKVOBlockTarget alloc] initWithBlock:block];
    NSMutableDictionary *dict = [self _wj_allObserverTargets];
    NSMutableArray *targetArr = dict[keyPath];
    if (!targetArr) {
        targetArr = [NSMutableArray array];
        dict[keyPath] = targetArr;
    }
    [targetArr addObject:target];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)removeObserverBlocksForKeyPath:(NSString *)keyPath {
    if (!keyPath) return;
    NSMutableDictionary *dict = [self _wj_allObserverTargets];
    NSMutableArray *targetArr = dict[keyPath];
    [targetArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    [dict removeObjectForKey:keyPath];
}

- (void)removeObserverBlocks {
    NSMutableDictionary *dict = [self _wj_allObserverTargets];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    [dict removeAllObjects];
}

- (NSMutableDictionary *)_wj_allObserverTargets {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, kObserverTargetKey);
    if (!dict) {
        dict = [NSMutableDictionary new];
        objc_setAssociatedObject(self, kObserverTargetKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

@end
