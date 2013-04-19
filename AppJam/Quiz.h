//
//  Quiz.h
//  Fabflix
//
//  Created by Nealon Young on 3/8/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuizQuestion.h"
#import "QuizItem.h"
#import "QuestionGenerator.h"

@interface Quiz : NSObject

@property (nonatomic) NSInteger numQuestions;
@property (nonatomic) NSInteger numCorrect;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger happyCount;
@property (nonatomic) NSInteger sadCount;
@property (nonatomic) NSInteger proudCount;
@property (nonatomic) NSInteger calmCount;
@property (nonatomic) NSInteger angryCount;
@property (nonatomic) NSInteger worriedCount;
@property (nonatomic) NSInteger excitedCount;
@property (nonatomic) NSInteger curiousCount;
@property (nonatomic) NSInteger surprisedCount;
@property (nonatomic) NSInteger boredCount;

- (NSString *)getQuestion;
- (UIImage *)getImage;
- (NSArray *)getAnswers;
- (NSInteger)getAnswerIndex;
- (BOOL)submitAnswer:(NSInteger)answerIndex time:(double)time;
- (void)nextQuestion;
- (void)finish;
- (void)tabulateAnswer:(NSString *)answerType;
- (void)grantAchievements;

@end
