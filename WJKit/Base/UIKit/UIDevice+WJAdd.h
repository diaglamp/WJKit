//
//  UIDevice+WJAdd.h
//  WJKit
//
//  Created by XHJ on 2017/4/7.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Network traffic type:
 
 WWAN: Wireless Wide Area Network.
 For example: 3G/4G.
 
 WIFI: Wi-Fi.
 
 AWDL: Apple Wireless Direct Link (peer-to-peer connection).
 For exmaple: AirDrop, AirPlay, GameKit.
 */
typedef NS_OPTIONS(NSUInteger, YYNetworkTrafficType) {
    YYNetworkTrafficTypeWWANSent     = 1 << 0,
    YYNetworkTrafficTypeWWANReceived = 1 << 1,
    YYNetworkTrafficTypeWIFISent     = 1 << 2,
    YYNetworkTrafficTypeWIFIReceived = 1 << 3,
    YYNetworkTrafficTypeAWDLSent     = 1 << 4,
    YYNetworkTrafficTypeAWDLReceived = 1 << 5,
    
    YYNetworkTrafficTypeWWAN = YYNetworkTrafficTypeWWANSent | YYNetworkTrafficTypeWWANReceived,
    YYNetworkTrafficTypeWIFI = YYNetworkTrafficTypeWIFISent | YYNetworkTrafficTypeWIFIReceived,
    YYNetworkTrafficTypeAWDL = YYNetworkTrafficTypeAWDLSent | YYNetworkTrafficTypeAWDLReceived,
    
    YYNetworkTrafficTypeALL = YYNetworkTrafficTypeWWAN |
                              YYNetworkTrafficTypeWIFI |
                              YYNetworkTrafficTypeAWDL,
};

/**
 Provides extensions for `UIDevice`.
 */
@interface UIDevice (WJAdd)

#pragma mark - Device Information
///=============================================================================
/// @name Device Information
///=============================================================================

/// Device system version (e.g. 8.1)
+ (double)systemVersion;

/// Whether the device is a simulator.
@property (nonatomic, readonly) BOOL isSimulator;

/// Whether the device is jailbroken.
@property (nonatomic, readonly) BOOL isJailbroken;

/// Wherher the device can make phone calls.
@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *machineModelName;

/// The System's startup time.
@property (nonatomic, readonly) NSDate *systemUptime;

#pragma mark - Network Information
///=============================================================================
/// @name Network Information
///=============================================================================

/// WIFI IP address of this device (can be nil). e.g. @"192.168.1.111"
@property (nullable, nonatomic, readonly) NSString *ipAddressWIFI;

/// Cell IP address of this device (can be nil). e.g. @"10.2.2.222"
@property (nullable, nonatomic, readonly) NSString *ipAddressCell;


/**
 Get device network traffic bytes.
 
 @discussion This is a counter since the device's last boot time.
 Usage:
 
 uint64_t bytes = [[UIDevice currentDevice] getNetworkTrafficBytes:YYNetworkTrafficTypeALL];
 NSTimeInterval time = CACurrentMediaTime();
 
 uint64_t bytesPerSecond = (bytes - _lastBytes) / (time - _lastTime);
 
 _lastBytes = bytes;
 _lastTime = time;
 
 
 @param types traffic types
 @return bytes counter.
 */
- (uint64_t)getNetworkTrafficBytes:(YYNetworkTrafficType)types;

@end

NS_ASSUME_NONNULL_END
