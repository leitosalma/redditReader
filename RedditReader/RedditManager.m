//
//  RedditManager.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "RedditManager.h"
#import "RedditHTTPClient.h"
#import "Entry.h"

@interface RedditManager()

@property (strong,atomic) NSString *afterEntry;

@end

@implementation RedditManager

-(void)synchronizeEntriesAndReset:(BOOL)reset {
    
    //Should be configurable
    NSString *category = @"top";
    int entriesPerPage = 20;
    NSString *period = @"day";
    
    NSString *after = reset ? nil : self.afterEntry;
    NSLog(@"%@",after);
    
    [[RedditHTTPClient sharedInstance] fetchEntriesForCategory:category withEntriesPerPage:entriesPerPage withPeriod:period afterEntry:after completioBlock:^(NSDictionary *response, NSError *error) {
        
        if(error == nil) {
            NSMutableArray *entriesJSON = [[NSMutableArray alloc]initWithCapacity:1];
            
            NSDictionary *data = response[@"data"];
            NSDictionary *children = data[@"children"];
            
            for (NSDictionary *entryToParse in children) {
                Entry *newEntry = [[Entry alloc]init];
                newEntry.title = entryToParse[@"data"][@"title"];
                newEntry.author = entryToParse[@"data"][@"author"];
                newEntry.thumbnailUrl = entryToParse[@"data"][@"thumbnail"];
                newEntry.imageUrl = entryToParse[@"data"][@"url"];
                newEntry.commentsCount = [entryToParse[@"data"][@"num_comments"]doubleValue];
                newEntry.entryDate = [NSDate dateWithTimeIntervalSince1970:[entryToParse[@"data"][@"created_utc"] doubleValue]];
                
                [entriesJSON addObject:newEntry];
            }
            
            self.afterEntry = data[@"after"];
            
            if([self.delegate respondsToSelector:@selector(didGetNewEntries:)]) {
                [self.delegate didGetNewEntries:entriesJSON];
            }
            
        } else {
            if([self.delegate respondsToSelector:@selector(didGetNewEntries:)]) {
                [self.delegate didFailWithError:error];
            }
        }        
    }];
}

@end
