//
//  WJCache.m
//  WJKit
//
//  Created by XHJ on 2017/4/24.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "WJCache.h"
#import "WJMemoryCache.h"
#import "WJDiskCache.h"

@implementation WJCache

//- (instancetype) init {
//    NSLog(@"Use \"initWithName\" or \"initWithPath\" to create WJCache instance.");
//    return [self initWithPath:@""];
//}
//
//- (instancetype)initWithName:(NSString *)name {
//    if (name.length == 0) return nil;
//    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *path = [cacheFolder stringByAppendingPathComponent:name];
//    return [self initWithPath:path];
//}
//
//- (instancetype)initWithPath:(NSString *)path {
//    if (path.length == 0) return nil;
//    WJDiskCache *diskCache = [[WJDiskCache alloc] initWithPath:path];
//    if (!diskCache) return nil;
//    NSString *name = [path lastPathComponent];
//    WJMemoryCache *memoryCache = [WJMemoryCache new];
//    memoryCache.name = name;
//    
//    self = [super init];
//    _name = name;
//    _diskCache = diskCache;
//    _memoryCache = memoryCache;
//    return self;
//}
//
//+ (instancetype)cacheWithName:(NSString *)name {
//    return [[WJCache alloc] initWithName:name];
//}
//
//+ (instancetype)cacheWithPath:(NSString *)path {
//    return [[WJCache alloc] initWithPath:path];
//}

@end
