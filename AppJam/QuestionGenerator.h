//
//  QuestionGenerator.h
//  Fabflix
//
//  Created by Nealon Young on 3/13/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuizItem.h"
#import "QuizQuestion.h"

@interface QuestionGenerator : NSObject

- (QuizQuestion *)newQuestion;

@end
