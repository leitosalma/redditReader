//
//  ConfigurationHelper.h
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/25/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigurationHelper : NSObject

+(ConfigurationHelper *) sharedInstance;

-(void) saveCategory: (NSString *)category;
-(NSString*) currentCategory;

-(void) saveTimePeriod: (NSString *)timePeriod;
-(NSString*) currentTimePeriod;

-(void) saveImages: (BOOL)timePeriod;
-(BOOL) currentSaveImages;

@end
