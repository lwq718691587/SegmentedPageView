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
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;
@property (nonatomic, strong) UIFont *normalTitleFont;
@property (nonatomic, strong) UIColor *normalTitleTextColor;
@property (nonatomic, strong) UIFont *selectedTitleFont;
@property (nonatomic, strong) UIColor *selectedTitleTextColor;
/// 设置线的size
@property (nonatomic, assign) CGSize lineSize;
/// 线 距离底部的位置
@property (nonatomic, assign) CGFloat lineOffsetY;
/// 设置 线的图片
@property (nonatomic, strong) UIImage *lineImage;
/// 点击回调
@property (nonatomic, copy) void(^selectedIndex)(NSInteger index);
/// 选中的index
@property (nonatomic, assign) NSInteger currentIndex;

- (void)scrollStartIndex:(NSInteger)startIndex tagretIndex:(NSInteger)tagretIndex percent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
