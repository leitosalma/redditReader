//
//  RedditHTTPClient.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/23/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "RedditHTTPClient.h"

NSString* const BaseUrl = @"http://www.reddit.com/";
NSString* const Postfix_Url = @"%@/.json";

@implementation RedditHTTPClient

+ (instancetype)sharedInstance {
    static RedditHTTPClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // Session configuration setup
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];

        _sharedInstance = [[RedditHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl] sessionConfiguration:sessionConfiguration];

        _sharedInstance.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    
    return _sharedInstance;
}

-(void)fetchEntriesForCategory:(NSString*)category withEntriesPerPage:(int)entriesCount withPeriod:(NSString*)period afterEntry:(NSString*)afterEntry completioBlock:(CompletionBlock)completionBlock {
    
    NSString *path =[NSString stringWithFormat:Postfix_Url,category];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithCapacity:1];
    [parameters setObject:period forKey:@"t"];
    [parameters setObject:[NSNumber numberWithInt:entriesCount] forKey:@"limit"];
    
    if(afterEntry != nil) {
        [parameters setObject:afterEntry forKey:@"after"];
    }
    
    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(nil, error);
    }];
}

@end
