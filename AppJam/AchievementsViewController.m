//
//  AchievementsViewController.m
//  EmotiQuiz
//
//  Created by Nealon Young on 4/18/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "AchievementsViewController.h"

@interface AchievementsViewController () {
    NSDictionary *achievements;
}

@end

@implementation AchievementsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Achievements" image:[UIImage imageNamed:@"Trophy"] tag:1];
        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.0], UITextAttributeTextColor, [UIFont fontWithName:@"Lato-Bold" size:12.0], UITextAttributeFont,nil] forState:UIControlStateNormal];
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"TrophySelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"TrophyUnselected.png"]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// Reload the list of achievements whenever the view appears so newly earned achievements are reflected
- (void)viewDidAppear:(BOOL)animated {
    achievements = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userAchievements"];
    
    if (achievements == nil) {
        NSString *achievementsPath = [[NSBundle mainBundle] pathForResource:@"achievements" ofType:@"plist"];
        achievements = [NSDictionary dictionaryWithContentsOfFile:achievementsPath];
        [[NSUserDefaults standardUserDefaults] setObject:achievements forKey:@"userAchievements"];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"achievement";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSArray *keys = [achievements allKeys];
    
    // Alphabetically sort the array of keys so achievements appear in the correct order
    keys = [keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    NSString *achievementKey = keys[indexPath.row];
    NSDictionary *achievement = achievements[achievementKey];
    
    BOOL awarded = [[achievement objectForKey:@"awarded"] boolValue];
    
    if (awarded) {
        cell.imageView.image = [UIImage imageNamed:@"UnlockedAchievement.png"];
        cell.detailTextLabel.text = achievement[@"description"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"LockedAchievement.png"];
        cell.detailTextLabel.text = [@"Locked · " stringByAppendingString:achievement[@"description"]];
    }
    
    cell.textLabel.text = achievement[@"title"];
    cell.textLabel.font = [UIFont fontWithName:@"Lato-Bold" size:19.0];
    cell.textLabel.textColor = [UIColor colorWithRed:0.13 green:0.18 blue:0.25 alpha:1.0];
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Lato-Regular" size:14.0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.51 green:0.58 blue:0.58 alpha:1.0];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [achievements count];
}

@end
