//
//  Quiz.m
//  Fabflix
//
//  Created by Nealon Young on 3/8/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "Quiz.h"
#import "QuestionGenerator.h"

@interface Quiz () {
    QuestionGenerator *generator;
    QuizQuestion *currentQuestion;
    double lastQuestionAnsweredTime;
}

@end

@implementation Quiz

- (id)init {
    self = [super init];
    
    if (self) {
        // Generate the first question in the quiz
        generator = [[QuestionGenerator alloc] init];
    }
    
    return self;
}

- (NSString *)getQuestion {
    return currentQuestion.question;
}

- (UIImage *)getImage {
    return currentQuestion.image;
}

- (NSArray *)getAnswers {
    return currentQuestion.answers;
}

- (NSInteger)getAnswerIndex {
    return currentQuestion.answerIndex;
}

- (BOOL)submitAnswer:(NSInteger)answerIndex time:(double)time {
    // Check if the submitted answer is correct
    BOOL correctAnswer = (answerIndex == currentQuestion.answerIndex);
    
    // Increment total number of questions
    self.numQuestions++;
    
    lastQuestionAnsweredTime = time;
    
    NSArray* answers = currentQuestion.answers;
    NSString* answerType = [answers objectAtIndex:currentQuestion.answerIndex];
    
    if (correctAnswer) {
        // Increment number of correct questions
        self.numCorrect++;
        [self tabulateAnswer:answerType];
        return true;
    } else {
        return false;
    }
}

- (void)nextQuestion {
    currentQuestion = [generator newQuestion];
}

// Save statistics from the quiz, should be called after quiz is finshed
- (void)finish {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // Update number of quizzes taken
    NSInteger quizzesTaken = [prefs integerForKey:@"quizzesTaken"];
    quizzesTaken++;
    
    [prefs setInteger:quizzesTaken forKey:@"quizzesTaken"];
    
    // Update total time spent
    double totalTime = [prefs integerForKey:@"totalTime"];
    totalTime += lastQuestionAnsweredTime;
    
    [prefs setFloat:totalTime forKey:@"totalTime"];
    
    // Update total number of answers
    NSInteger totalAnswers = [prefs integerForKey:@"totalAnswers"];
    totalAnswers += self.numQuestions;
    
    [prefs setInteger:totalAnswers forKey:@"totalAnswers"];
    
    // Update number of correct answers
    NSInteger correctAnswers = [prefs integerForKey:@"correctAnswers"];
    correctAnswers += self.numCorrect;
    
    [prefs setInteger:correctAnswers forKey:@"correctAnswers"];
    
    // Update number of incorrect answers
    NSInteger incorrectAnswers = [prefs integerForKey:@"incorrectAnswers"];
    incorrectAnswers += (self.numQuestions - self.numCorrect);
    
    [prefs setInteger:incorrectAnswers forKey:@"incorrectAnswers"];
    
    //Update the total score
    NSInteger totalScore = [prefs integerForKey:@"totalScore"];
    totalScore += (self.numCorrect * 100);
    
    [prefs setInteger:totalScore forKey:@"totalScore"];
    
    //Update the happy total
    NSInteger happyScore = [prefs integerForKey:@"happyScore"];
    happyScore += (self.happyCount);
    
    [prefs setInteger:happyScore forKey:@"happyScore"];
    
    //Update the sad total
    NSInteger sadScore = [prefs integerForKey:@"sadScore"];
    sadScore += (self.sadCount);
    
    [prefs setInteger:sadScore forKey:@"sadScore"];
    
    //Update the proud total
    NSInteger proudScore = [prefs integerForKey:@"proudScore"];
    proudScore += (self.proudCount);
    
    [prefs setInteger:proudScore forKey:@"proudScore"];
    
    //Update the calm total
    NSInteger calmScore = [prefs integerForKey:@"calmScore"];
    calmScore += (self.calmCount);
    
    [prefs setInteger:calmScore forKey:@"calmScore"];
    
    //Update the angry total
    NSInteger angryScore = [prefs integerForKey:@"angryScore"];
    angryScore += (self.angryCount);
    
    [prefs setInteger:angryScore forKey:@"angryScore"];
    
    //Update the worried total
    NSInteger worriedScore = [prefs integerForKey:@"worriedScore"];
    worriedScore += (self.worriedCount);
    
    [prefs setInteger:worriedScore forKey:@"worriedScore"];
    
    //Update the excited total
    NSInteger excitedScore = [prefs integerForKey:@"excitedScore"];
    excitedScore += (self.excitedCount);
    
    [prefs setInteger:excitedScore forKey:@"excitedScore"];
    
    //Update the curious total
    NSInteger curiousScore = [prefs integerForKey:@"curiousScore"];
    curiousScore += (self.curiousCount);
    
    [prefs setInteger:curiousScore forKey:@"curiousScore"];
    
    //Update the surprised total
    NSInteger surprisedScore = [prefs integerForKey:@"surprisedScore"];
    surprisedScore += (self.surprisedCount);
    
    [prefs setInteger:surprisedScore forKey:@"surprisedScore"];
    
    //Update the bored total
    NSInteger boredScore = [prefs integerForKey:@"boredScore"];
    boredScore += (self.boredCount);
    
    [prefs setInteger:boredScore forKey:@"boredScore"];
    
    [self grantAchievements];
}

//This method tabulates the running totals for the number of correct answers of each answer type
- (void)tabulateAnswer:(NSString *)answerType{
    if ([answerType isEqualToString:@"Happy"]){
        self.happyCount++;
    }
    else if([answerType isEqualToString:@"Sad"]){
        self.sadCount++;
    }
    else if ([answerType isEqualToString:@"Proud"]){
        self.proudCount++;
    }
    else if ([answerType isEqualToString:@"Calm"]){
        self.calmCount++;
    }
    else if ([answerType isEqualToString:@"Angry"]){
        self.angryCount++;
    }
    else if ([answerType isEqualToString:@"Worried"]){
        self.worriedCount++;
    }
    else if ([answerType isEqualToString:@"Excited"]){
        self.excitedCount++;
    }
    else if ([answerType isEqualToString:@"Curious"]){
        self.curiousCount++;
    }
    else if ([answerType isEqualToString:@"Suprised"]){
        self.surprisedCount++;
    }
    else if ([answerType isEqualToString:@"Bored"]){
        self.boredCount++;
    }
    
}

- (void)grantAchievements {
    //Load userDefaults and get the plist loaded up
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *achievementsDataPath = [[NSBundle mainBundle] pathForResource:@"achievements" ofType:@"plist"];
    NSDictionary *achievementsData = [NSDictionary dictionaryWithContentsOfFile:achievementsDataPath];
    
    //Create the dictionary of user achievements to be stored in NSUserDefaults
    NSDictionary *userAchievementsImmutable;
    
    //If the dictionary does not exist in NSUserDefaults, we must copy it over from the plist of achievements
    if ([prefs dictionaryForKey:@"userAchievements"] == nil) {
        [prefs setObject:achievementsData forKey:@"userAchievements"];
    }
    
    userAchievementsImmutable = [prefs dictionaryForKey:@"userAchievements"];
    NSMutableDictionary *userAchievements = [[NSMutableDictionary alloc] initWithDictionary:userAchievementsImmutable];
    
    //get all the keys in the dictionary
    NSArray *keys = [achievementsData allKeys];
    NSInteger size = [keys count];
    
    //get each dictionary in the plist
    for (int i = 0; i < size; i++) {
        
        //Get the plist achievement and the user achievement
        NSString *key = keys[i];
        NSDictionary *userAchievementAlpha = [userAchievements valueForKey:key];
        NSMutableDictionary *userAchievement = [[NSMutableDictionary alloc] initWithDictionary:userAchievementAlpha];
        
        //Get all necessarry info
        NSNumber *progress = [userAchievement valueForKey:@"progress"];
        Boolean awarded = [[userAchievement objectForKey:@"awarded"] boolValue];
        NSString *type = [userAchievement valueForKey:@"type"];
        NSLog(@"%@", type);
        NSNumber *condition = [userAchievement valueForKey:@"condition"];
        NSInteger con = [condition intValue];
        NSInteger userValue = [prefs integerForKey:type];
        NSNumber *numVal = [NSNumber numberWithInt:userValue];
        
        //If the user just earned an achievement, this method will be executed
        NSLog(@"userValue: %d", userValue);
        NSLog(@"con : %d", con);
        NSLog(@"Awarded: %@", awarded ? @"YES" : @"NO");
        if ((userValue >= con) && (awarded == NO)){
            
            [userAchievement setValue:[NSNumber numberWithBool:YES] forKey:@"awarded"];
            
            NSNumber *num = [NSNumber numberWithFloat:([progress floatValue] + [numVal floatValue])];
            
            [userAchievement setValue:num forKey:@"progress"];
            
        }
        
        //if they haven't this gets executed
        if(numVal < condition){
            
            NSInteger prog = [progress intValue];
            NSInteger sum = prog + userValue;
            
            NSNumber *runningTotal = [NSNumber numberWithInt:sum];
            [userAchievement setValue:runningTotal forKey:@"progress"];
            
        }
        
        //Save the user achievement to the dictionary of all achievements
        [userAchievements setValue:userAchievement forKey:key];
    }
    
    //save the complete achievements dictonary to user defaults
    NSDictionary *userAchievementsAdd = [NSDictionary dictionaryWithDictionary:userAchievements];
    [prefs setObject:userAchievementsAdd forKey:@"userAchievements"];
}

@end
