//
//  SettingsViewController.m
//  RedditReader
//
//  Created by Leonardo Salmaso on 4/25/15.
//  Copyright (c) 2015 Leonardo Salmaso. All rights reserved.
//

#import "SettingsViewController.h"
#import "ConfigurationHelper.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *categorySegmentedControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *timePeriodSegmentedControl;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)finishEdition:(id)sender {
    
    NSString *category = [_categorySegmentedControl titleForSegmentAtIndex:_categorySegmentedControl.selectedSegmentIndex];
    
    [[ConfigurationHelper sharedInstance] saveCategory:[category lowercaseString]];
    
    NSString *timePeriod =[_timePeriodSegmentedControl titleForSegmentAtIndex:_timePeriodSegmentedControl.selectedSegmentIndex];
    
    [[ConfigurationHelper sharedInstance] saveTimePeriodL:[timePeriod lowercaseString]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"settingsUpdated" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelEdition:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
