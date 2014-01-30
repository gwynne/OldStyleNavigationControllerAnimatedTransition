//
//  SXTNavigationControllerAnimatedTransition.m
//  
//
//  Created by Davide Di Stefano on 16/09/13.
//  Copyright (c) 2013 ReturnService. All rights reserved.
//

#import "OldStyleNavigationControllerAnimatedTransition.h"

@implementation OldStyleNavigationControllerAnimatedTransition

- (id)init {
    self = [super init];
    if (self) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_6_1
        _operation = UINavigationControllerOperationPush;
#endif
    }
    return self;
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_6_1
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;
{
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
{
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect screenFrame = fromViewController.view.frame;
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toViewController.view];
    CGFloat toStartX, fromEndX;

    if (_operation == UINavigationControllerOperationPush)
    {
        toStartX = screenFrame.size.width;
        fromEndX = -screenFrame.size.width;
    } else
    {
        toStartX = -screenFrame.size.width;
        fromEndX = screenFrame.size.width;
    }

    toViewController.view.frame = CGRectOffset(screenFrame, toStartX, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
    {
        toViewController.view.frame = screenFrame;
        fromViewController.view.frame = CGRectOffset(screenFrame, fromEndX, 0);
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}
#endif


@end
