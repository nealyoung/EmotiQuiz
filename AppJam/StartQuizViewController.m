//
//  StartQuizViewController.m
//  EmotiQuiz
//
//  Created by Nealon Young on 3/8/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "StartQuizViewController.h"

@interface StartQuizViewController ()

@end

@implementation StartQuizViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Quiz" image:[UIImage imageNamed:@"quiz.png"] tag:0];
        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.0], UITextAttributeTextColor, [UIFont fontWithName:@"Lato-Bold" size:12.0], UITextAttributeFont,nil] forState:UIControlStateNormal];
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"QuizSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"QuizUnselected.png"]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.0];
    
    self.startQuizButton.color = [UIColor colorWithRed:.15 green:.64 blue:.31 alpha:1.0];
    self.startQuizButton.titleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:24.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startQuiz:(id)sender {
    QuizViewController *quizView = [[QuizViewController alloc] initWithNibName:@"QuizViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:quizView];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
