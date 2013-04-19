//
//  AchievementsViewController.h
//  EmotiQuiz
//
//  Created by Nealon Young on 4/18/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchievementsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
