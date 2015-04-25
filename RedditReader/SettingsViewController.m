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
    NSString *category = [[ConfigurationHelper sharedInstance] currentCategory];
    NSString *period = [[ConfigurationHelper sharedInstance] currentTimePeriod];
    
    [self setCategory:category];
    [self setTimePeriod:period];
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

-(void)setCategory:(NSString*)categroy {
    int index = 0;

    if([categroy isEqualToString:@"controversial"]) {
        index = 1;
    } else if([categroy isEqualToString:@"new"]) {
        index = 2;
    } else if([categroy isEqualToString:@"hot"]) {
        index = 3;
    }
    
    [_categorySegmentedControl setSelectedSegmentIndex:index];
}

-(void)setTimePeriod:(NSString*)period {
    int index = 0;
    
    if([period isEqualToString:@"day"]) {
        index = 1;
    } else if([period isEqualToString:@"week"]) {
        index = 2;
    } else if([period isEqualToString:@"month"]) {
        index = 3;
    } else if([period isEqualToString:@"year"]) {
        index = 4;
    } else if([period isEqualToString:@"all"]) {
        index = 5;
    }
    
    [_timePeriodSegmentedControl setSelectedSegmentIndex:index];
}

@end
