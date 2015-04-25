//
//  RedditHTTPClient.h
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/23/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^CompletionBlock)(NSDictionary *response, NSError *error);

@interface RedditHTTPClient : AFHTTPSessionManager

+(instancetype)sharedInstance;

-(void)fetchEntriesForCategory:(NSString*)category withEntriesPerPage:(int)entriesCount withPeriod:(NSString*)period afterEntry:(NSString*)afterEntry completioBlock:(CompletionBlock)completionBlock;

@end