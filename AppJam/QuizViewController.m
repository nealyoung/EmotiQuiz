//
//  QuizViewController.m
//  Fabflix
//
//  Created by Nealon Young on 3/8/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController () {
    NSTimer *timer;
    Quiz *quiz;
    double time;
    
    // Timer for each question
    double questionStartTime;
}

- (void)loadNextQuestion;

@end

@implementation QuizViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizesSubviews = YES;
    self.questionImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    // Set the view's background pattern
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.0];
    
    // Set the color of the answer buttons
    self.answer0.color = [UIColor colorWithRed:.15 green:.64 blue:.31 alpha:1.0];
    self.answer1.color = [UIColor colorWithRed:.15 green:.64 blue:.31 alpha:1.0];
    self.answer2.color = [UIColor colorWithRed:.15 green:.64 blue:.31 alpha:1.0];
    self.answer3.color = [UIColor colorWithRed:.15 green:.64 blue:.31 alpha:1.0];
    
    // Set up the cancel button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewController)];
    
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Lato-Regular" size:13.0], UITextAttributeFont, [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset, nil] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.title = @"Quiz";
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(updateTimer:)]];
    [invocation setTarget:self];
    [invocation setSelector:@selector(updateTimer:)];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 invocation:invocation repeats:YES];
    quiz = [[Quiz alloc] init];
    time = 0.0;
    
    [self loadNextQuestion];
    
    //self.questionImage.image = [quiz getImage];
    self.answerLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissViewController {
    [timer invalidate];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateTimer:(NSTimer *)fire {
    time += 0.01;
    self.timerLabel.text = [NSString stringWithFormat:@"Time: %d:%.2d", (int)time / 60, (int)time % 60];
    
    if (time >= TIME_LIMIT) {
        [timer invalidate];
        [quiz finish];
        NSString *quizTitle = @"Quiz Finished!";
        NSString *quizMessage = [NSString stringWithFormat:@"You got %d out of %d questions correct", quiz.numCorrect, quiz.numQuestions];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:quizTitle message:quizMessage delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
        [message show];
        
        [self dismissViewController];
    }
}

- (void)loadNextQuestion {
    [quiz nextQuestion];
    
    //self.questionImage.backgroundColor = [UIColor greenColor];
    //self.questionImage.clipsToBounds = YES;
    //self.questionImage.image = [UIImage imageNamed:@"happy.png"];
    
    self.questionImage.image = [quiz getImage];
    
    NSArray *answers = [quiz getAnswers];
    
    [self.answer0 setTitle:answers[0] forState:UIControlStateNormal];
    [self.answer1 setTitle:answers[1] forState:UIControlStateNormal];
    [self.answer2 setTitle:answers[2] forState:UIControlStateNormal];
    [self.answer3 setTitle:answers[3] forState:UIControlStateNormal];
    
    questionStartTime = time;
}

- (IBAction)selectAnswer:(id)sender {
    NSInteger answer = [sender tag];
    
    if ([quiz submitAnswer:answer time:time]) {
        self.answerLabel.textColor = [UIColor colorWithRed:0.1 green:0.65 blue:0.05 alpha:1.0];
        self.answerLabel.text = @"Correct!";
    } else {
        self.answerLabel.textColor = [UIColor redColor];
        NSString *correctAnswer = [[quiz getAnswers] objectAtIndex:[quiz getAnswerIndex]];
        self.answerLabel.text = [NSString stringWithFormat:@"The person was %@", [correctAnswer lowercaseString]];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", quiz.numCorrect * 10];
    
    [self loadNextQuestion];
}

@end
