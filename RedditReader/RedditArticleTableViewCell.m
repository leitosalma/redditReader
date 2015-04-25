//
//  RedditArticleTableViewCell.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "RedditArticleTableViewCell.h"
#import "Utils.h"

@interface RedditArticleTableViewCell()

@property (strong, nonatomic) Entry *currentEntry;

@end

@implementation RedditArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillCellWithEntry:(Entry*)entry {
    self.currentEntry = entry;
    [self clearCell];
    self.titleLabel.text = entry.title;
    self.commentsLabel.text = [NSString stringWithFormat: NSLocalizedString(@"commentsLabel", nil),entry.commentsCount];
    
    NSString *timeString = [Utils stringTimeFromDate:entry.entryDate];
    self.timeAuthorLabel.text = [NSString stringWithFormat:NSLocalizedString(@"timeLabel", nil), timeString, entry.author];
    
     [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:entry.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
    //Detect image tap, other way is add button over the image and create a IBAction
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(ClickEventOnImage:)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [tapRecognizer setDelegate:self];
    //Don't forget to set the userInteractionEnabled to YES, by default It's NO.
    self.thumbnailImageView.userInteractionEnabled = YES;
    [self.thumbnailImageView addGestureRecognizer:tapRecognizer];
    
}

-(void) ClickEventOnImage:(id) sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.currentEntry.imageUrl]];
}

-(void)clearCell {
    self.thumbnailImageView.image = [UIImage imageNamed:@"placeholder"];
    self.titleLabel.text = @"";
    self.timeAuthorLabel.text = @"";
    self.commentsLabel.text = @"";
}

@end
