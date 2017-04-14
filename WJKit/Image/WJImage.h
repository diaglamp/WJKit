//
//  WJImage.h
//  WJKit
//
//  Created by XHJ on 2017/4/13.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<YYKit/YYKit.h>)
#import <WJKit/WJAnimatedImageView.h>
#import <WJKit/WJImageCoder.h>
#else
#import "WJAnimatedImageView.h"
#import "WJImageCoder.h"
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 A WJImage object is a high-level way to display animated image data.
 
 @discussion It is a fully compatible `UIImage` subclass. It extends the UIImage
 to support animated WebP, APNG and GIF format image data decoding. It also
 support NSCoding protocol to archive and unarchive multi-frame image data.
 
 If the image is created from multi-frame image data, and you want to play the
 animation, try replace UIImageView with `WJAnimatedImageView`.
 
 Sample Code:
 
     // animation@3x.webp
     WJImage *image = [WJImage imageNamed:@"animation.webp"];
     WJAnimatedImageView *imageView = [[WJAnimatedImageView alloc] initWithImage:image];
     [view addSubView:imageView];
 
 */
@interface WJImage : UIImage

+ (nullable WJImage *)imageNamed:(NSString *)name; // no cache!
+ (nullable WJImage *)imageWithContentsOfFile:(NSString *)path;
+ (nullable WJImage *)imageWithData:(NSData *)data;
+ (nullable WJImage *)imageWithData:(NSData *)data scale:(CGFloat)scale;

/**
 If the image is created from data or file, then the value indicates the data type.
 */
@property (nonatomic, readonly) YYImageType animatedImageType;

/**
 If the image is created from animated image data (multi-frame GIF/APNG/WebP),
 this property stores the original image data.
 */
@property (nullable, nonatomic, readonly) NSData *animatedImageData;

/**
 The total memory usage (in bytes) if all frame images was loaded into memory.
 The value is 0 if the image is not created from a multi-frame image data.
 */
@property (nonatomic, readonly) NSUInteger animatedImageMemorySize;

/**
 Preload all frame image to memory.
 
 @discussion Set this property to `YES` will block the calling thread to decode
 all animation frame image to memory, set to `NO` will release the preloaded frames.
 If the image is shared by lots of image views (such as emoticon), preload all
 frames will reduce the CPU cost.
 
 See `animatedImageMemorySize` for memory cost.
 */
@property (nonatomic) BOOL preloadAllAnimatedImageFrames;

@end

NS_ASSUME_NONNULL_END
