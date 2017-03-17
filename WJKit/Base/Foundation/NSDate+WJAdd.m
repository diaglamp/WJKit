//
//  NSDate+WJAdd.m
//  WJKit
//
//  Created by XHJ on 2017/3/16.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "NSDate+WJAdd.h"
#import "WJKitMacro.h"

@implementation NSDate (WJAdd)

#pragma mark - Component Properties
///=============================================================================
/// @name Component Properties
///=============================================================================
- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}


#pragma mark - Date modify
///=============================================================================
/// @name Date modify
///=============================================================================
- (NSDate *)addYears:(NSInteger)year {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitYear value:year toDate:self options:0];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)addMonths:(NSInteger)month {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:month toDate:self options:0];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:month];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)addDays:(NSInteger)day {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:day toDate:self options:0];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)addHours:(NSInteger)hour {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitHour value:hour toDate:self options:0];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hour];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)addMinutes:(NSInteger)minute {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMinute value:minute toDate:self options:0];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:minute];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)addSeconds:(NSInteger)second {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitSecond value:second toDate:self options:0];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setSecond:second];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - Date Format
///=============================================================================
/// @name Date Format
///=============================================================================
- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter dateFromString:dateString];
}

#pragma mark - Date Compare
///=============================================================================
/// @name Date Compare
///=============================================================================
- (BOOL)isToday {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] isDateInToday:self];
    }
    
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] isDateInYesterday:self];
    }
    
    NSDate *added = [self addDays:1];
    return [added isToday];
}

- (BOOL)isTomorrow {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] isDateInTomorrow:self];
    }
    
    NSDate *added = [self addDays:-1];
    return [added isToday];
}

- (BOOL)isInSameDayAsDate:(NSDate *)date {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] isDate:self inSameDayAsDate:date];
    }
    
    return [[self startOfDay] isEqualToDate:[date startOfDay]];
}

- (NSDate *)startOfDay {
    if (IOS8_OR_LATER) {
        return [[NSCalendar currentCalendar] startOfDayForDate:self];
    }
    
    NSDateComponents *cmpts = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:cmpts];
}

//在指定粒度比较两个日期
- (NSComparisonResult)compare:(NSDate *)date toGranularity:(NSCalendarUnit)unit {
    NSCalendarUnit realUnit = NSCalendarUnitYear;
    switch (unit) {
        case NSCalendarUnitSecond: {
            realUnit = realUnit | NSCalendarUnitSecond;
        }
        case NSCalendarUnitMinute: {
            realUnit = realUnit | NSCalendarUnitMinute;
        }
        case NSCalendarUnitHour: {
            realUnit = realUnit | NSCalendarUnitHour;
        }
        case NSCalendarUnitDay: {
            realUnit = realUnit | NSCalendarUnitDay;
        }
        case NSCalendarUnitMonth: {
            realUnit = realUnit | NSCalendarUnitMonth;
        }
        case NSCalendarUnitYear: {
            realUnit = realUnit | NSCalendarUnitYear;
            break;
        }
        default:
            break;
    }
    return [[NSCalendar currentCalendar] compareDate:self toDate:date toUnitGranularity:realUnit];
}

@end
