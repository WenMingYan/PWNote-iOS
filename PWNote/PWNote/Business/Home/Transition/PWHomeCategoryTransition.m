//
//  PWHomeCategoryTransition.m
//  PWNote
//
//  Created by mingyan on 2019/1/9.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWHomeCategoryTransition.h"
#import "PWPresentAnimationTransition.h"
#import "PWPresentationController.h"
#import "PWDismissAnimationTransition.h"

@interface PWHomeCategoryTransition ()

@property (nonatomic, strong) PWPresentAnimationTransition *transition; 

@end

@implementation PWHomeCategoryTransition

/*
 presented为要弹出的Controller
 presenting为当前的Controller
 source为源Contrller 对于present动作  presenting与source是一样的
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PWPresentAnimationTransition alloc] init];
}
//
////这个函数用来设置当执行dismiss方法时 进行的转场动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[PWDismissAnimationTransition alloc] init];
}
//
////这个函数用来设置当执行present方法时 进行可交互的转场动画
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return nil;
//}
//
////这个函数用来设置当执行dismiss方法时 进行可交互的转场动画
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}
//
////iOS8后提供的新接口  返回UIPresentationController处理转场
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source  {
    return  [[PWPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];;
}



@end
