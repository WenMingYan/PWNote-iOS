//
//  PWAnimationTransition.m
//  PWNote
//
//  Created by mingyan on 2019/1/9.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWPresentAnimationTransition.h"
#import <objc/runtime.h>
#import "UIView+ALMAdditons.h"

@interface UIView (PWAnimation_Privated)

@property(nonatomic, weak) UINavigationController *pw_navi;

- (void)onClickVisual;

@end

@implementation UIView (PWAnimation_Privated)

- (void)setPw_navi:(UINavigationController *)navi {
    objc_setAssociatedObject(self, @selector(pw_navi), navi, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationController *)pw_navi {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)onClickVisual {
    [self.pw_navi dismissViewControllerAnimated:YES completion:nil];
}

@end

@interface PWPresentAnimationTransition ()

@property (nonatomic, strong) UIVisualEffectView *visualView;


@end

@implementation PWPresentAnimationTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //跳转的界面
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //最终的位置
    CGRect finalFromRect = [transitionContext finalFrameForViewController:fromVC];
    CGRect finalToRect = [transitionContext finalFrameForViewController:toVC];
    finalToRect.size.width -= 50;
    finalFromRect.origin.x += [[UIScreen mainScreen]bounds].size.width - 50;
    //起始位置
    toVC.view.frame = CGRectOffset(finalToRect, -[[UIScreen mainScreen]bounds].size.width + 50, 0);
    //添加到内容视图
    [[transitionContext containerView] addSubview:toVC.view];
    //执行动画
    
    UIView *containerView = [transitionContext containerView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.pw_navi = fromVC;
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
    _visualView.frame = containerView.bounds;
    _visualView.alpha = 0.4;
    _visualView.backgroundColor = [UIColor blackColor];
    _visualView.userInteractionEnabled = YES;
    [view addSubview:self.visualView];
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *visualTap = [[UITapGestureRecognizer alloc] initWithTarget:view
                                                                                action:@selector(onClickVisual)];
    [view addGestureRecognizer:visualTap];
    [containerView addSubview:view];
    [containerView bringSubviewToFront:toVC.view];
    _visualView.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        toVC.view.frame = finalToRect;
        fromVC.view.frame = finalFromRect;
        self.visualView.alpha = 0.4;
    } completion:^(BOOL finished) {
        //完成动画
        [transitionContext completeTransition:YES];
    }];
    
}
//


@end
