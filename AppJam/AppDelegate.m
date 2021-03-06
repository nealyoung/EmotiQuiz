//
//  AppDelegate.m
//  EmotiQuiz
//
//  Created by Nealon Young on 3/8/13.
//  Copyright (c) 2013 Nealon Young. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"FlatTabBar.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1.0], UITextAttributeTextColor, [UIFont fontWithName:@"Lato-Bold" size:21.0], UITextAttributeFont,nil]];
    
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"Empty.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Lato-Regular" size:19]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    StartQuizViewController *quizView = [[StartQuizViewController alloc] initWithNibName:@"StartQuizViewController" bundle:nil];
    UIViewController *achievementsView = [[AchievementsViewController alloc] initWithNibName:@"AchievementsViewController" bundle:nil];
    StatsViewController *statsView = [[StatsViewController alloc] initWithNibName:@"StatsViewController" bundle:nil];
    
    self.tabController = [[UITabBarController alloc] init];
    
    NSArray *tabs = [[NSArray alloc] initWithObjects: quizView, achievementsView, statsView, nil];
    
    [self.tabController setViewControllers:tabs];
    self.tabController.tabBar.backgroundImage = [UIImage imageNamed:@"FlatTabBar.png"];
    self.tabController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"Empty.png"];
    self.tabController.tabBar.selectedImageTintColor = [UIColor colorWithRed:.82 green:.82 blue:.82 alpha:1.0];
    
    self.window.rootViewController = self.tabController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
