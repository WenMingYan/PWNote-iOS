//
//  PWViewController.h
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWLocalManager.h"
#import "PWRouter.h"
#import "PWRouterAction.h"


@interface PWViewController : UIViewController

+ (NSString *)urlName;

/**
 路由至某个URL

 @param routerURL url
 @param param param
 */
- (void)routerURL:(NSString *)routerURL withParam:(NSDictionary *)param;

@end

#define __PW_ROUTER_REGISTER__   \
+(void)load {\
PWRouterAction *action = [[PWRouterAction alloc] init];\
action.actionType = PWRouterActionTypePushNewPage;\
action.address = [self urlName];\
action.actionBlock = ^(UINavigationController *navigationController) {\
[navigationController pushViewController:[[self alloc] init] animated:YES];\
};\
[[PWRouter sharedInstance] registerRouterWithURLAddress:[self urlName] action:action];\
}
