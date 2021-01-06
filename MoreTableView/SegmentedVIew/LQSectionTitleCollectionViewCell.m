//
//  LQSectionTitleCollectionViewCell.m
//  MoreTableView
//
//  Created by 刘伟强 on 2021/1/5.
//

#import "LQSectionTitleCollectionViewCell.h"

@interface LQSectionTitleCollectionViewCell()

@property (nonatomic, strong) UILabel *cusTitleLabel;

@end

@implementation LQSectionTitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.cusTitleLabel];
    }
    return self;
}


- (UILabel *)cusTitleLabel {
    if (!_cusTitleLabel) {
        _cusTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _cusTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cusTitleLabel;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.cusTitleLabel.font = self.font;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.cusTitleLabel.text = _title;
}




@end
