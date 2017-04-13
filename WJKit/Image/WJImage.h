//
//  WJImage.h
//  WJKit
//
//  Created by XHJ on 2017/4/13.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@end

NS_ASSUME_NONNULL_END
