//
//  LQSegmentedTableView.m
//  MoreTableView
//
//  Created by 刘伟强 on 2021/1/4.
//

#import "LQSegmentedTableView.h"

@implementation LQSegmentedTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
