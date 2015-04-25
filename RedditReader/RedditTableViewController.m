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

@end

@implementation RedditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _items = [[NSMutableArray alloc]initWithCapacity:0];
    _redditManager = [[RedditManager alloc]init];
    _redditManager.delegate = self;
    [_redditManager synchronizeEntries];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *redditCellIdentifier = @"RedditCellIdentifier";
    
    RedditArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:redditCellIdentifier];
    
   [cell fillCellWithEntry:_items[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark Reddit Manager Delegate
-(void) didGetNewEntries:(NSArray*)entries {
    [_items addObjectsFromArray:entries];
    [self.tableView reloadData];
}

-(void) didFailWithError:(NSError*)error {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
