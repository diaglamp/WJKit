//
//  WJCache.h
//  WJKit
//
//  Created by XHJ on 2017/4/24.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WJMemoryCache, WJDiskCache;

NS_ASSUME_NONNULL_BEGIN

/**
 `WJCache` is a thread safe key-value cache.
 
 It use `WJMemoryCache` to store objects in a small and fast memory cache,
 and use `WJDiskCache` to persisting objects to a large and slow disk cache.
 See `WJMemoryCache` and `WJDiskCache` for more information.
 */
@interface WJCache : NSObject

/** The name of the cache, readonly. */
@property (copy, readonly) NSString *name;

/** The underlying memory cache. see `YYMemoryCache` for more information.*/
@property (strong, readonly) WJMemoryCache *memoryCache;

/** The underlying disk cache. see `YYDiskCache` for more information.*/
@property (strong, readonly) WJDiskCache *diskCache;

/**
 Create a new instance with the specified name.
 Multiple instances with the same name will make the cache unstable.
 
 @param name  The name of the cache. It will create a dictionary with the name in
 the app's caches dictionary for disk cache. Once initialized you should not
 read and write to this directory.
 @result A new cache object, or nil if an error occurs.
 */
- (nullable instancetype)initWithName:(NSString *)name;

/**
 Create a new instance with the specified path.
 Multiple instances with the same name will make the cache unstable.
 
 @param path  Full path of a directory in which the cache will write data.
 Once initialized you should not read and write to this directory.
 @result A new cache object, or nil if an error occurs.
 */
- (nullable instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;

/**
 Convenience Initializers
 Create a new instance with the specified name.
 Multiple instances with the same name will make the cache unstable.
 
 @param name  The name of the cache. It will create a dictionary with the name in
 the app's caches dictionary for disk cache. Once initialized you should not
 read and write to this directory.
 @result A new cache object, or nil if an error occurs.
 */
+ (nullable instancetype)cacheWithName:(NSString *)name;

/**
 Convenience Initializers
 Create a new instance with the specified path.
 Multiple instances with the same name will make the cache unstable.
 
 @param path  Full path of a directory in which the cache will write data.
 Once initialized you should not read and write to this directory.
 @result A new cache object, or nil if an error occurs.
 */
+ (nullable instancetype)cacheWithPath:(NSString *)path;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
