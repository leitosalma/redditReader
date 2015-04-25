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
#import "ConfigurationHelper.h"

@interface RedditManager()

@property (strong,atomic) NSString *afterEntry;
@property (strong,atomic) NSString *category;
@property (strong,atomic) NSString *period;

@end

@implementation RedditManager

const int ENTRIES_PER_PAGE = 40;

- (id)init
{
    self = [super init];
    if (self) {
        _category = [[ConfigurationHelper sharedInstance] currentCategory];
        _period = [[ConfigurationHelper sharedInstance] currentTimePeriod];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(settingsUpdated:)
                                                     name:@"settingsUpdated"
                                                   object:nil];
    }
    
    return self;
}

-(void)settingsUpdated:(NSNotification *)notification {
    _category = [[ConfigurationHelper sharedInstance] currentCategory];
    _period = [[ConfigurationHelper sharedInstance] currentTimePeriod];
}

-(void)synchronizeEntriesAndReset:(BOOL)reset {
    
    if(!reset && self.afterEntry == nil) {
        //Send empty array to update the screen
        [self.delegate didGetNewEntries:[[NSArray alloc]init]];
    }
    
    NSString *after = reset ? nil : self.afterEntry;
    NSLog(@"%@",after);
    
    [[RedditHTTPClient sharedInstance] fetchEntriesForCategory:_category withEntriesPerPage:ENTRIES_PER_PAGE withPeriod:_period afterEntry:after completioBlock:^(NSDictionary *response, NSError *error) {
        
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
