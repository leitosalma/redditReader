//
//  RedditArticleTableViewCell.h
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
#import "UIImageView+AFNetworking.h"

@interface RedditArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;

-(void)fillCellWithEntry:(Entry*)entry;

@end
