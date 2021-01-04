//
//  UIViewController+LQSegmented.m
//  MoreTableView
//
//  Created by 刘伟强 on 2021/1/4.
//

#import "UIViewController+LQSegmented.h"
#import <objc/runtime.h>

//定义常量 必须是C语言字符串
static char *SegmentedDelegateKey = "segmentedDelegate";

@implementation UIViewController (LQSegmented)


- (void)setSegmentedBlock:(void (^)(UIScrollView * _Nonnull))segmentedBlock {
    objc_setAssociatedObject(self, SegmentedDelegateKey, segmentedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(UIScrollView * _Nonnull))segmentedBlock {
    return objc_getAssociatedObject(self, SegmentedDelegateKey);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.segmentedBlock) {
        self.segmentedBlock(scrollView);
    }
}

@end
