//
//  RedditArticleTableViewCell.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "RedditArticleTableViewCell.h"
#import "Utils.h"
#import "ConfigurationHelper.h"

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

    BOOL saveImage =  [[ConfigurationHelper sharedInstance] currentSaveImages];
    
    self.currentEntry = entry;
    [self clearCell];
    self.titleLabel.text = entry.title;
    self.commentsLabel.text = [NSString stringWithFormat: NSLocalizedString(@"commentsLabel", nil),entry.commentsCount];
    
    NSString *timeString = [Utils stringTimeFromDate:entry.entryDate];
    self.timeAuthorLabel.text = [NSString stringWithFormat:NSLocalizedString(@"timeLabel", nil), timeString, entry.author];
    
    if(!saveImage) {
        [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:entry.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    } else {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:entry.thumbnailUrl]];
        
        [self.thumbnailImageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            self.thumbnailImageView.image = image;
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            //Do nothing
        }];
    }
    
    
    //Detect image tap, other way is add button over the image and create a IBAction
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(ClickEventOnImage:)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [tapRecognizer setDelegate:self];
    self.thumbnailImageView.userInteractionEnabled = YES;
    [self.thumbnailImageView addGestureRecognizer:tapRecognizer];
    
}

-(void) ClickEventOnImage:(id) sender
{
    if(self.currentEntry.imageUrl != nil && ![self.currentEntry.imageUrl isEqualToString:@""]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.currentEntry.imageUrl]];
    }
}

-(void)clearCell {
    self.thumbnailImageView.image = [UIImage imageNamed:@"placeholder"];
    self.titleLabel.text = @"";
    self.timeAuthorLabel.text = @"";
    self.commentsLabel.text = @"";
}

@end
