//
//  UIApplication+WJAdd.h
//  WJKit
//
//  Created by XHJ on 2017/4/11.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIApplication`.
 */
@interface UIApplication (WJAdd)

/// App’s bundle contains the app and all of its resources. Cannot write
@property (nonatomic, readonly) NSString *applicationPath;

/// User data you want to expose to the user, backed up to iCloud by default
@property (nonatomic, readonly) NSString *documentsPath;

/// This is the top-level directory for any files that are not user data files.
@property (nonatomic, readonly) NSString *libraryPath;

/// The system may delete the Caches/ directory to free up disk space
@property (nonatomic, readonly) NSString *cachesPath;

/// The system will periodically purge these files when your app is not running
@property (nonatomic, readonly) NSString *tmpPath;


/// Application's Bundle Name (show in SpringBoard).
@property (nullable, nonatomic, readonly) NSString *appBundleName;

/// Application's Bundle ID.  e.g. "com.xhj.MyApp"
@property (nullable, nonatomic, readonly) NSString *appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString *appVersion;

/// Application's Build number. e.g. "123"
@property (nullable, nonatomic, readonly) NSString *appBuildVersion;


/// Whether this app is pirated (not install from appstore).
@property (nonatomic, readonly) BOOL isPirated;

/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL isBeingDebugged;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float cpuUsage;


/**
 Increments the number of active network requests.
 If this number was zero before incrementing, this will start animating the
 status bar network activity indicator.
 
 This method is thread safe.
 
 This method has no effect in App Extension.
 */
- (void)incrementNetworkActivityCount;

/**
 Decrements the number of active network requests.
 If this number becomes zero after decrementing, this will stop animating the
 status bar network activity indicator.
 
 This method is thread safe.
 
 This method has no effect in App Extension.
 */
- (void)decrementNetworkActivityCount;

/// Returns YES in App Extension.
+ (BOOL)isAppExtension;

/// Same as sharedApplication, but returns nil in App Extension.
+ (nullable UIApplication *)sharedExtensionApplication;

@end

NS_ASSUME_NONNULL_END
