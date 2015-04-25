//
//  Entry.h
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property NSString *title;
@property NSString *author;
@property NSDate *entryDate;
@property NSString *imageUrl;
@property NSString *thumbnailUrl;
@property double commentsCount;

@end
