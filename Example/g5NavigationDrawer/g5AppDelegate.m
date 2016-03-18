//
//  g5AppDelegate.m
//  g5NavigationDrawer
//
//  Created by cliffhanger62 on 03/13/2016.
//  Copyright (c) 2016 cliffhanger62. All rights reserved.
//

#import "g5AppDelegate.h"
#import "g5ViewController.h"

@implementation g5AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    g5ViewController *vc = [[g5ViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
    return YES;
}

@end
