//
//  RedditArticleTableViewCell.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "RedditArticleTableViewCell.h"
#import "Utils.h"

@implementation RedditArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillCellWithEntry:(Entry*)entry {
    [self clearCell];
    self.titleLabel.text = entry.title;
    self.commentsLabel.text = [NSString stringWithFormat: NSLocalizedString(@"commentsLabel", nil),entry.commentsCount];
    
    NSString *timeString = [Utils stringTimeFromDate:entry.entryDate];
    self.timeAuthorLabel.text = [NSString stringWithFormat:NSLocalizedString(@"timeLabel", nil), timeString, entry.author];
    
     [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:entry.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
}

-(void)clearCell {
    self.thumbnailImageView.image = [UIImage imageNamed:@"placeholder"];
    self.titleLabel.text = @"";
    self.timeAuthorLabel.text = @"";
    self.commentsLabel.text = @"";
}

@end
