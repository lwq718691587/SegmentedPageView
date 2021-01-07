//
//  ESCSegmentedPageViewController.h
//  MoreTableView
//
//  Created by 刘伟强 on 2020/12/30.
//

// import分组次序：Frameworks、Services、UI
#import <UIKit/UIKit.h>
#import "LQSegmentedCategoryView.h"
#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

NS_ASSUME_NONNULL_BEGIN

/**
 * <#类注释，说明类的功能#>
 * @note <#额外说明的注意项，说明一些需要注意的地方，没有可取消此项。#>
 */
@interface LQSegmentedPageView : UIView

/// 分类的空间 可以设置样式
@property (nonatomic, strong, readonly) LQSegmentedCategoryView *segmentedCategoryView;

- (instancetype)initWithFrame:(CGRect)frame
           categoryViewHeight:(CGFloat)categoryViewHeight
                   headerView:(UIView *)headerView
                     titleArr:(NSArray*)titleArr
              viewControllers:(NSArray *)viewControllers;



@end

NS_ASSUME_NONNULL_END
