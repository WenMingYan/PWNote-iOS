//
//  PWDismissAnimationTransition.m
//  PWNote
//
//  Created by mingyan on 2019/1/9.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWDismissAnimationTransition.h"
#import "UIView+ALMAdditons.h"

@implementation PWDismissAnimationTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //跳转的界面
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];// category
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];// home
    //最终的位置
    CGRect finalFromRect = [transitionContext finalFrameForViewController:fromVC];
    CGRect finalToRect = [transitionContext finalFrameForViewController:toVC];
    //起始位置
    finalFromRect.origin.x = - kScreenWidth + 50;
    //执行动画
    UIVisualEffectView *effectionView;
    for (UIVisualEffectView *view in [transitionContext containerView].subviews) {
        if ([view isKindOfClass:[UIVisualEffectView class]]) {
            effectionView = view;
            break;
        }
    }
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        effectionView.alpha = 0;
        toVC.view.frame = finalToRect;
        fromVC.view.frame = finalFromRect;
    } completion:^(BOOL finished) {
        //完成动画
        [transitionContext completeTransition:YES];
    }];
}

@end
