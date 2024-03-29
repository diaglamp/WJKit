//
//  WJAnimatedImageView.h
//  WJKit
//
//  Created by XHJ on 2017/4/13.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An image view for displaying animated image.
 
 @discussion It is a fully compatible `UIImageView` subclass.
 If the `image` or `highlightedImage` property adopt to the `WJAnimatedImage` protocol,
 then it can be used to play the multi-frame animation. The animation can also be
 controlled with the UIImageView methods `-startAnimating`, `-stopAnimating` and `-isAnimating`.
 
 This view request the frame data just in time. When the device has enough free memory,
 this view may cache some or all future frames in an inner buffer for lower CPU cost.
 Buffer size is dynamically adjusted based on the current state of the device memory.
 
 Sample Code:
 
     // ani@3x.gif
     WJImage *image = [WJImage imageNamed:@"ani"];
     WJAnimatedImageView *imageView = [[WJAnimatedImageView alloc] initWithImage:image];
     [view addSubView:imageView];
 */

@interface WJAnimatedImageView : UIImageView

/**
 If the image has more than one frame, set this value to `YES` will automatically
 play/stop the animation when the view become visible/invisible.
 
 The default value is `YES`.
 */
@property (nonatomic) BOOL autoPlayAnimatedImage;

/**
 Index of the currently displayed frame (index from 0).
 
 Set a new value to this property will cause to display the new frame immediately.
 If the new value is invalid, this method has no effect.
 
 You can add an observer to this property to observe the playing status.
 */
@property (nonatomic) NSUInteger currentAnimatedImageIndex;

/**
 Whether the image view is playing animation currently.
 
 You can add an observer to this property to observe the playing status.
 */
@property (nonatomic, readonly) BOOL currentIsPlayingAnimation;

/**
 The animation timer's runloop mode, default is `NSRunLoopCommonModes`.
 
 Set this property to `NSDefaultRunLoopMode` will make the animation pause during
 UIScrollView scrolling.
 */
@property (nonatomic, copy) NSString *runloopMode;

/**
 The max size (in bytes) for inner frame buffer size, default is 0 (dynamically).
 
 When the device has enough free memory, this view will request and decode some or
 all future frame image into an inner buffer. If this property's value is 0, then
 the max buffer size will be dynamically adjusted based on the current state of
 the device free memory. Otherwise, the buffer size will be limited by this value.
 
 When receive memory warning or app enter background, the buffer will be released
 immediately, and may grow back at the right time.
 */
@property (nonatomic) NSUInteger maxBufferSize;

@end


/**
 The WJAnimatedImage protocol declares the required methods for animated image
 display with WJAnimatedImageView.
 
 Subclass a UIImage and implement this protocol, so that instances of the Imgae class
 can be set to WJAnimatedImageView.image or WJAnimatedImageView.highlightedImage
 to display animation.
 
 See `WJImage` and `WJFrameImage` for example.
 */
@protocol WJAnimatedImage <NSObject>
@required
/// Total animated frame count.
/// It the frame count is less than 1, then the methods below will be ignored.
- (NSUInteger)animatedImageFrameCount;

/// Animation loop count, 0 means infinite looping.
- (NSUInteger)animatedImageLoopCount;

/// Bytes per frame (in memory). It may used to optimize memory buffer size.
- (NSUInteger)animatedImageBytesPerFrame;

/// Returns the frame image from a specified index.
/// This method may be called on background thread.
/// @param index  Frame index (zero based).
- (nullable UIImage *)animatedImageFrameAtIndex:(NSUInteger)index;

/// Returns the frames's duration from a specified index.
/// @param index  Frame index (zero based).
- (NSTimeInterval)animatedImageDurationAtIndex:(NSUInteger)index;

@optional
/// A rectangle in image coordinates defining the subrectangle of the image that
/// will be displayed. The rectangle should not outside the image's bounds.
/// It may used to display sprite animation with a single image (sprite sheet).
- (CGRect)animatedImageContentsRectAtIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
