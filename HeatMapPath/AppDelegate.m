//
//  AppDelegate.m
//  HeatMapPath
//
//  Created by Dylan Marriott on 08.12.13.
//  Copyright (c) 2013 Dylan Marriott. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoViewController.h"

@implementation AppDelegate

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
