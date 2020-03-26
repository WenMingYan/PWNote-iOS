//
//  AppDelegate.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "AppDelegate.h"
#import "PWNavigationViewController.h"
#import "PWHomeViewController.h"
#import "PWRouter.h"

#import "PWNetworkTestViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化Router
//    PWHomeViewController *vc = [[PWHomeViewController alloc] init];
//    PWNavigationViewController *navigator = [[PWNavigationViewController alloc] initWithRootViewController:vc];
//    [[PWRouter sharedInstance] setupWithNavigation:navigator];
//    self.window.rootViewController = navigator;
//    [self.window makeKeyAndVisible];
    
    
    //TODO: wmy PWNetworkTestViewController test
    PWNetworkTestViewController *vc = [[PWNetworkTestViewController alloc] init];
//    PWHomeViewController *vc = [[PWHomeViewController alloc] init];
    PWNavigationViewController *navigator = [[PWNavigationViewController alloc] initWithRootViewController:vc];
    [[PWRouter sharedInstance] setupWithNavigation:navigator];
    self.window.rootViewController = navigator;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
 
}


@end
