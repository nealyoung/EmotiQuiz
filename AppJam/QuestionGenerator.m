//
//  QuestionGenerator.m
//  EmotiQuiz
//
//  Created by Nealon Young on 3/13/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "QuestionGenerator.h"

@interface QuestionGenerator()

- (QuizQuestion *)generateQuestionWithImage:(UIImage *)image correctAnswer:(NSString *)answer incorrectAnswers:(NSMutableArray *)answers;

@end

@implementation QuestionGenerator

- (QuizQuestion *)newQuestion {
    NSString *questionDataPath = [[NSBundle mainBundle] pathForResource:@"QuestionData" ofType:@"plist"];
    NSDictionary *questionData = [NSDictionary dictionaryWithContentsOfFile:questionDataPath];
    
    // Select a random correct emotion
    NSArray *keys = [questionData allKeys];
    UInt16 randomIndex = arc4random() % [keys count];
    NSString *correctEmotion = keys[randomIndex];
    
    // Choose 3 random incorrect answers
    NSMutableArray *incorrectEmotions = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        while (true) {
            randomIndex = arc4random() % [keys count];
            NSString *incorrectEmotion = keys[randomIndex];
            
            // If the emotion has not already been selected as a correct or incorrect answer
            if (![incorrectEmotions containsObject:incorrectEmotion] && ![incorrectEmotion isEqualToString:correctEmotion]) {
                [incorrectEmotions addObject:incorrectEmotion];
                break;
            }
        }
    }
    
    // Select an image portraying the correct emotion
    NSArray *images = questionData[correctEmotion];
    randomIndex = arc4random() % [images count];
    UIImage *image = [UIImage imageNamed:images[randomIndex]];
    
    // Generate the question with the 
    QuizQuestion *question = [self generateQuestionWithImage:image correctAnswer:correctEmotion incorrectAnswers:incorrectEmotions];
    
    return question;
}

//Helper Method that takes a the question in string format, the answer, and an array of incorrect answers.
- (QuizQuestion *)generateQuestionWithImage:(UIImage *)image correctAnswer:(NSString *)answer incorrectAnswers:(NSMutableArray *)answers {
    int answerIndex = arc4random() % 4;
    [answers insertObject:answer atIndex:answerIndex];
    
    QuizQuestion *quizQuestion = [[QuizQuestion alloc] initWithImage:image answers:answers answerIndex:answerIndex];
    return quizQuestion;
}

@end
