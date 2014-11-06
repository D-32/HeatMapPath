//
//  DMAppDelegate.m
//  HeatMapPath
//
//  Created by CocoaPods on 11/05/2014.
//  Copyright (c) 2014 Dylan Marriott. All rights reserved.
//

#import "DMAppDelegate.h"
#import "DemoViewController.h"

@implementation DMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    DemoViewController* vc = [[DemoViewController alloc] init];
    self.window.rootViewController = vc;
    vc.view.frame = CGRectMake(0, 0, vc.view.frame.size.width, vc.view.frame.size.height);
    
    return YES;
}

@end
