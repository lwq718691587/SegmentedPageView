//
//  ESCBaseSegmentedSingleViewController.m
//  MoreTableView
//
//  Created by 刘伟强 on 2020/12/30.
//

// import分组次序：Frameworks、Services、UI
#import "ESCBaseSegmentedSingleViewController.h"

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

@interface ESCBaseSegmentedSingleViewController ()

#pragma mark - 私有属性

@end

@implementation ESCBaseSegmentedSingleViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segmentedDelegate scrollViewDidScroll:scrollView];
}

#pragma mark - Getters and Setters

@end
