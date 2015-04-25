//
//  Utils.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSString*)stringTimeFromDate:(NSDate*)date {
    NSDateComponents *articleTime = [self differenceBetweenDate:date andDate:[NSDate date] inTimeUnits:NSMinuteCalendarUnit];
    
    return [self stringTime:articleTime];
}


+ (NSDateComponents *)differenceBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime inTimeUnits:(NSCalendarUnit)timeUnits
{
    if (fromDateTime != nil && toDateTime != nil) {
        
        NSDate *fromDate;
        NSDate *toDate;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        if(timeUnits == NSDayCalendarUnit){
            
            [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                         interval:NULL forDate:fromDateTime];
            
            [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                         interval:NULL forDate:toDateTime];
            
            NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                                       fromDate:fromDateTime toDate:toDateTime options:0];
            return difference;
        }
        else {
            
            [calendar rangeOfUnit:NSMinuteCalendarUnit startDate:&fromDate
                         interval:NULL forDate:fromDateTime];
            
            [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                         interval:NULL forDate:toDateTime];
            
            NSDateComponents *difference = [calendar components:NSMinuteCalendarUnit
                                                       fromDate:fromDateTime toDate:toDateTime options:0];
            return difference;
            
        }
    }
    else {
        NSDateComponents *fakeDate = [[NSDateComponents alloc] init];
        [fakeDate setDay:0];
        [fakeDate setMinute:0];
        return fakeDate;
    }
}

+(NSString*)stringTime:(NSDateComponents*)dateComponent {
    
    int minutes = (int)[dateComponent minute];
    
    int hours = minutes/60;
    int days = minutes/1440;
    
    NSString *time;
    int finalTimeValue = 0;
    
    if (minutes <=0) {
        time = NSLocalizedString(@"JustNow", nil);
    }
    else if(minutes == 1){
        finalTimeValue = 1;
        time = NSLocalizedString(@"MinuteAgo",nil);
    }
    else if (hours == 1){
        finalTimeValue = 1;
        time = NSLocalizedString(@"HourAgo", nil);
    }
    else if (hours > 1 && minutes <=1439) {
        finalTimeValue= hours;
        time= NSLocalizedString(@"HoursAgo", nil);
    }
    else if (days == 1){
        finalTimeValue = days;
        time = NSLocalizedString(@"DayAgo", nil);
    }
    else if (days > 1) {
        finalTimeValue = days;
        time= NSLocalizedString(@"DaysAgo", nil);
    }
    else {
        time = NSLocalizedString(@"MinutesAgo", nil);
    }

    NSString *fullTime;
    
    if (minutes <=0) {
        fullTime = [NSString stringWithFormat:@"%@", time];
    }
    else {
        fullTime = [NSString stringWithFormat:@"%d %@", finalTimeValue, time];
    }
    
    return fullTime;
}

@end
