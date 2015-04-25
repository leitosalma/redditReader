//
//  RedditTableViewController.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/24/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "RedditTableViewController.h"
#import "RedditArticleTableViewCell.h"

@interface RedditTableViewController ()

@property RedditManager *redditManager;
@property NSMutableArray *items;
@property UIRefreshControl *refreshControl;

@end

@implementation RedditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:131.0/255 green:183.0/255 blue:221.0/255 alpha:0.75];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    
    _items = [[NSMutableArray alloc]initWithCapacity:0];
    _redditManager = [[RedditManager alloc]init];
    _redditManager.delegate = self;
    [_redditManager synchronizeEntriesAndReset:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(settingsUpdated:)
                                                 name:@"settingsUpdated"
                                               object:nil];
}

-(void)settingsUpdated:(NSNotification *)notification {
    [self refreshTableView];
}

-(void)refreshTableView {
    _items = [[NSMutableArray alloc]initWithCapacity:0];
    [self.tableView reloadData];
    [_redditManager synchronizeEntriesAndReset:YES];
}

-(void)loadMoreItems:(int)rowNumber {
    if(self.items.count - 20 == rowNumber){
        NSLog(@"COUNT: %lu",(unsigned long)self.items.count);
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        spinner.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 70);
        self.tableView.tableFooterView = spinner;
        
        [_redditManager synchronizeEntriesAndReset:NO];
    }
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *redditCellIdentifier = @"RedditCellIdentifier";
    
    RedditArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:redditCellIdentifier];
    [cell fillCellWithEntry:_items[indexPath.row]];
    [self loadMoreItems:(int)indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


#pragma mark Reddit Manager Delegate


-(void) didGetNewEntries:(NSArray*)entries {
    [self.refreshControl endRefreshing];
    self.tableView.tableFooterView = nil;
    
    [_items addObjectsFromArray:entries];
    [self.tableView reloadData];
}

-(void) didFailWithError:(NSError*)error {

}

@end
