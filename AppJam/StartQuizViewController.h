//
//  StartQuizViewController.h
//  EmotiQuiz
//
//  Created by Nealon Young on 3/8/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizViewController.h"
#import "BButton.h"

@interface StartQuizViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (strong, nonatomic) IBOutlet BButton *startQuizButton;
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBarTitle;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)startQuiz:(id)sender;

@end
