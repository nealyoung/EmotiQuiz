//
//  QuizQuestion.h
//  EmotiQuiz
//
//  Created by Nealon Young on 3/10/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizQuestion : NSObject

@property (nonatomic, readonly) NSString *question;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSArray *answers;
@property (nonatomic, readonly) NSInteger answerIndex;

- (id)initWithImage:(UIImage *)image answers:(NSArray *)answers answerIndex:(NSInteger)answerIndex;

@end
