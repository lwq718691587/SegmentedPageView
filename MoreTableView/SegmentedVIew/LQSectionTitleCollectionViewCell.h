//
//  LQSectionTitleCollectionViewCell.h
//  MoreTableView
//
//  Created by 刘伟强 on 2021/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQSectionTitleCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *selectedFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedtTextColor;
@end

NS_ASSUME_NONNULL_END
