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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化Router
    
    PWHomeViewController *home = [[PWHomeViewController alloc] init];
    PWNavigationViewController *vc = [[PWNavigationViewController alloc] initWithRootViewController:home];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    [[PWRouter sharedInstance] setupWithNavigation:vc];
    
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
