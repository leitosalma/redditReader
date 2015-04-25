//
//  RedditManager.h
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedditHTTPClient.h"

@protocol RedditManagerDelegate;

@interface RedditManager : NSObject

@property (nonatomic, weak) id<RedditManagerDelegate> delegate;

-(void)synchronizeEntries;

@end

@protocol RedditManagerDelegate<NSObject>

-(void) didGetNewEntries:(NSArray*)entries;
-(void) didFailWithError:(NSError*)error;

@end
