//
//  SDTransationAnimate.m
//  SuperDriver
//
//  Created by shengangneng on 2017/11/24.
//  Copyright © 2017年 com.shen.superdriver. All rights reserved.
//

#import "SDPushTransationAnimate.h"
#import "SDUserInfoViewController.h"
#import "SDUserDetailViewController.h"

@implementation SDPushTransationAnimate

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    SDUserInfoViewController *fromViewController = (SDUserInfoViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SDUserDetailViewController *toViewController = (SDUserDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Get a snapshot of the thing cell we're transitioning from
    // 创建一个复合视图的快照。然后返回一个uiview对象来表示调用视图的整体外观。NO会立即生成快照
    UIView *cellImageSnapshot = [fromViewController.imageView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:fromViewController.imageView.frame fromView:fromViewController.imageView.superview];
    fromViewController.imageView.hidden = YES;
    
    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.imageView.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        // Fade in the second view controller's view
        toViewController.view.alpha = 1.0;
        
        // Move the cell snapshot so it's over the second view controller's image view
        CGRect frame = [containerView convertRect:toViewController.imageView.frame fromView:toViewController.view];
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        // Clean up
        toViewController.imageView.hidden = NO;
        fromViewController.imageView.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
    
//    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是vc2
//    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    //缩小动画，这里没有使用3D动画，不知怎的，使用3D动画有点卡顿
//    CGAffineTransform transform = CGAffineTransformMakeScale(0.9, 0.9);
//    CGRect scBound = [UIScreen mainScreen].bounds;
//    //获取的过度动画持续的时间
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
//    UIView * tempView = [transitionContext containerView];
//    //将需要跳转的VC的视图添加到tempView
//    [tempView addSubview:toVC.view];
//    toVC.view.frame = CGRectMake(scBound.size.width, scBound.origin.y, scBound.size.width, scBound.size.height);
//    //动画
//    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        [fromVC.view setTransform:transform];
//        fromVC.view.frame = CGRectMake(-50, fromVC.view.frame.origin.y, fromVC.view.frame.size.width, fromVC.view.frame.size.height);
//        toVC.view.frame = scBound;
//    } completion:^(BOOL finished) {
//        //转场执行完成
//        [transitionContext completeTransition:YES];
//    }];
    
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
