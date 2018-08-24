//
//  SDPopTransationAnimate.m
//  SuperDriver
//
//  Created by shengangneng on 2017/11/24.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDPopTransationAnimate.h"
#import "SDUserInfoViewController.h"
#import "SDUserDetailViewController.h"

@implementation SDPopTransationAnimate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 获取跳转的两个控制器
    SDUserDetailViewController *fromViewController = (SDUserDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SDUserInfoViewController *toViewController = (SDUserInfoViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Get a snapshot of the image view
    UIView *imageSnapshot = [fromViewController.imageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:fromViewController.imageView.frame fromView:fromViewController.imageView.superview];
    fromViewController.imageView.hidden = YES;
    
    // Get the cell we'll animate to
    toViewController.imageView.hidden = YES;
    
    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView addSubview:imageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        // Fade out the source view controller
        fromViewController.view.alpha = 0.0;
        
        // Move the image view
        imageSnapshot.frame = [containerView convertRect:toViewController.imageView.frame fromView:toViewController.imageView.superview];
    } completion:^(BOOL finished) {
        // Clean up
        [imageSnapshot removeFromSuperview];
        fromViewController.imageView.hidden = NO;
        toViewController.imageView.hidden = NO;
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
