//
//  UIViewController+LQSegmented.h
//  MoreTableView
//
//  Created by 刘伟强 on 2021/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIViewController (LQSegmented)

@property (nonatomic, copy) void(^segmentedBlock)(UIScrollView *scrollview);

@end

NS_ASSUME_NONNULL_END
