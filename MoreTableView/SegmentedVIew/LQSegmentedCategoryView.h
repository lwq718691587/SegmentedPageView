//
//  LQSegmentedCategoryView.h
//  MoreTableView
//
//  Created by 刘伟强 on 2021/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQSegmentedCategoryView : UIView

@property (nonatomic, strong) NSArray *titleArr;
/// 公有属性
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;


@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleTextColor;

@property (nonatomic, strong) UIFont *selectedTitleFont;
@property (nonatomic, strong) UIColor *selectedTitleTextColor;

@property (nonatomic, copy) void(^selectedIndex)(NSInteger index);

@property (nonatomic, assign) NSInteger currentIndex;

- (CGFloat)getWidthBetweenStartIndex:(NSInteger)startIndex
                            endIndex:(NSInteger)endIndex;

- (void)scrollToIndex:(NSInteger)index;
- (void)scrollLineView:(CGFloat)position startIndex:(NSInteger)startIndex;

@end

NS_ASSUME_NONNULL_END
