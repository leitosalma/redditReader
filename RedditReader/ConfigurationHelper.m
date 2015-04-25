//
//  ConfigurationHelper.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/25/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "ConfigurationHelper.h"

@interface ConfigurationHelper()

@property (strong, nonatomic) NSUserDefaults *userDefaults;

@end

@implementation ConfigurationHelper

const NSString *DEFAULT_CATEGORY = @"top";
const NSString *DEFAULT_TIME_PERIOD = @"day";

- (id)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}

+(ConfigurationHelper *) sharedInstance {
    
    static ConfigurationHelper *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ConfigurationHelper alloc] init];
    });
    
    return _sharedInstance;
}


-(void) saveCategory: (NSString *)category {
    [self.userDefaults setObject:category forKey:@"category"];
    [self.userDefaults synchronize];
}

-(NSString*) currentCategory {
    NSString *category = [self.userDefaults objectForKey:@"category"] == nil ? DEFAULT_CATEGORY : [self.userDefaults objectForKey:@"category"];

    return category;
}

-(void) saveTimePeriod: (NSString *)timePeriod {
    [self.userDefaults setObject:timePeriod forKey:@"time_period"];
    [self.userDefaults synchronize];
}

-(NSString*) currentTimePeriod {
    NSString *timePeriod = [self.userDefaults objectForKey:@"time_period"] == nil ? DEFAULT_TIME_PERIOD : [self.userDefaults objectForKey:@"time_period"];
    
    return timePeriod;
}

-(void) saveImages: (BOOL)timePeriod {
    [self.userDefaults setBool:timePeriod forKey:@"save_images"];
    
    [self.userDefaults synchronize];
}

-(BOOL) currentSaveImages {
    return [self.userDefaults boolForKey:@"save_images"];
}

@end
