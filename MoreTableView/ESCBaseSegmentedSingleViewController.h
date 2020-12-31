//
//  ESCBaseSegmentedSingleViewController.h
//  MoreTableView
//
//  Created by 刘伟强 on 2020/12/30.
//

// import分组次序：Frameworks、Services、UI
#import <UIKit/UIKit.h>

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

NS_ASSUME_NONNULL_BEGIN


@protocol SegmentedPageViewDelegate <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface ESCBaseSegmentedSingleViewController : UITableViewController

@property (nonatomic, weak) id<SegmentedPageViewDelegate>segmentedDelegate;

@end

NS_ASSUME_NONNULL_END
