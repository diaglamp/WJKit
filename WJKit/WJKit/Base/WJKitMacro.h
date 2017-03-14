//
//  WJKitMacro.h
//  WJKit
//
//  Created by XHJ on 2017/3/14.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#ifndef WJKitMacro_h
#define WJKitMacro_h

/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes. 
 Objective-C just create link symbol for classes but not categories,
 so we create dummy classes for each category.
 *******************************************************************************
 Example:
 WJSYNTH_DUMMY_CLASS(NSString_WJAdd)
 */
#ifndef WJSYNTH_DUMMY_CLASS
#define WJSYNTH_DUMMY_CLASS(_name_) \
@interface WJSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation WJSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif

#endif /* WJKitMacro_h */
